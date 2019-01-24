# pylint: disable=too-few-public-methods
"""Custom commands for ranger file manager"""

from __future__ import absolute_import, division, print_function

import os
from subprocess import STDOUT, CalledProcessError, check_output

from ranger.api.commands import Command


class GitRoot(Command):
    """Command to quickly change to the root of a git repository.

    :GitRoot

    cd to the root of the current git repository.
    If already at the root, cd to ~/repos.
    If not in a git repository, cd to ~/repos.
    """

    def execute(self):
        """Command to execute"""
        cwd = self.fm.thisdir.path
        cd_path = os.path.expanduser("~/repos")

        try:
            git_root = (
                check_output("git rev-parse --show-toplevel", stderr=STDOUT, shell=True)
                .decode("utf-8")
                .strip()
            )
            if git_root != cwd:
                cd_path = git_root
        except CalledProcessError:
            pass

        self.fm.cd(cd_path)


# TODO: this needs to be tweaked.
class Fzf(Command):
    """
    :fzf_select

    Find a file using fzf.

    With a prefix argument select only directories.

    See: https://github.com/junegunn/fzf
    """

    def execute(self):
        """Command to execute"""
        import subprocess

        command = "fd -L -t d -t f . | fzf-tmux +m"
        fzf = self.fm.execute_command(
            command, universal_newlines=True, stdout=subprocess.PIPE
        )
        stdout, _ = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip("\n"))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)
