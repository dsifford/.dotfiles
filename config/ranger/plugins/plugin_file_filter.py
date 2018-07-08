# This plugin improves the default hidden file filter
# by respecting .gitignore if one exists
from __future__ import absolute_import, division, print_function
from logging import getLogger
from os import getenv, path, getcwd
from subprocess import run, PIPE, CalledProcessError
from typing import Optional, List

from ranger.container.fsobject import FileSystemObject  # pyre-ignore
import ranger.container.directory  # pyre-ignore

log = getLogger(__file__)
ignored_cache = {}

accept_file_core = ranger.container.directory.accept_file


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


def accept_file(fobj: FileSystemObject, filters: list):
    filter_hidden_active = next(
        (i for i in filters if i.__name__ is "hidden_filter_func"), None
    )
    if not filter_hidden_active:
        return True
    workdir = fobj.dirname
    filename = fobj.basename
    if workdir in ignored_cache:
        ignored = ignored_cache[workdir]
    else:
        ignored = get_ignored_files(fobj.dirname)
        ignored_cache[workdir] = ignored
    if ignored is not None:
        return False if filename in [*ignored, ".git"] else True
    return accept_file_core(fobj, filters)


ranger.container.directory.accept_file = accept_file
