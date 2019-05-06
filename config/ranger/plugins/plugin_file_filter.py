# This plugin improves the default hidden file filter
# by respecting .gitignore if one exists
from __future__ import absolute_import, division, print_function

from logging import getLogger
from subprocess import PIPE, CalledProcessError, run
from typing import Callable, Dict, List, Optional

import ranger.container.directory
from ranger.container.fsobject import FileSystemObject

FilterList = List[Callable[[FileSystemObject], bool]]

BASE_ACCEPT_FILE = ranger.container.directory.accept_file
IGNORED_CACHE: Dict[str, Optional[List[str]]] = {}
LOGGER = getLogger(__file__)


def get_ignored_files(curr_path: str) -> Optional[List[str]]:
    try:
        ignored_files = (
            run(
                f"cd {curr_path} && git check-ignore * .[^.]*",
                check=True,
                stdout=PIPE,
                stderr=PIPE,
                shell=True,
            )
            .stdout.decode("utf-8")
            .strip()
            .split("\n")
        )
        return ignored_files
    except CalledProcessError as err:
        return [] if err.returncode == 1 else None


def filter_gitignore(fobj: FileSystemObject) -> bool:
    workdir = fobj.dirname
    filename = fobj.basename
    if workdir in IGNORED_CACHE:
        ignored = IGNORED_CACHE[workdir]
    else:
        ignored = get_ignored_files(fobj.dirname)
        IGNORED_CACHE[workdir] = ignored
    if ignored is not None:
        return not filename in [*ignored, ".git"]
    return True


def accept_file(fobj: FileSystemObject, filters: FilterList) -> bool:
    if not fobj.fm.settings.show_hidden and filter_gitignore(fobj) is False:
        return False
    return BASE_ACCEPT_FILE(fobj, filters)


ranger.container.directory.accept_file = accept_file
