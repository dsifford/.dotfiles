"""
A ranger plugin for improving the default hidden file filter by
respecting .gitignore in git repositories.
"""
from functools import lru_cache
from logging import getLogger
from subprocess import DEVNULL, CalledProcessError, check_call, check_output  # nosec
from typing import AnyStr, Callable, List

import ranger.container.directory
from ranger.container.fsobject import FileSystemObject

FilterList = List[Callable[[FileSystemObject], bool]]

BASE_ACCEPT_FILE = ranger.container.directory.accept_file
LOGGER = getLogger(__file__)


@lru_cache()
def get_ignored_files(cwd: str) -> List[str]:
    """Returns a list of git ignored files in cwd, or None if none exist."""
    try:
        return (
            check_output(
                "git check-ignore * .[^.]*",
                cwd=cwd,
                shell=True,  # nosec
                stderr=DEVNULL,
                text=True,
            )
            .strip()
            .split("\n")
        )
    except CalledProcessError:
        return []


@lru_cache()
def file_is_inside_git_repo(dirname: AnyStr) -> bool:
    """Returns True if fobject represents a file inside a git repo."""
    try:
        check_call(
            "git rev-parse --is-inside-work-tree",
            cwd=dirname,
            shell=True,  # nosec
            stderr=DEVNULL,
            stdout=DEVNULL,
        )
        return True
    except CalledProcessError:
        return False


def file_is_gitignored(fobj: FileSystemObject) -> bool:
    """Returns whether or not a file is git ignored."""
    LOGGER.info(get_ignored_files.cache_info())
    return fobj.basename in [*get_ignored_files(fobj.dirname), ".git"]


def accept_file(fobj: FileSystemObject, filters: FilterList) -> bool:
    """Returns True if file shall be shown, otherwise False."""
    if not fobj.fm.settings.show_hidden and file_is_inside_git_repo(fobj.dirname):
        return not file_is_gitignored(fobj) and BASE_ACCEPT_FILE(
            fobj,
            [
                f
                for f in filters
                if not hasattr(f, "__name__") or f.__name__ != "hidden_filter_func"
            ],
        )
    return BASE_ACCEPT_FILE(fobj, filters)


ranger.container.directory.accept_file = accept_file
