"""Command to quickly change to the root of a git repository"""

from __future__ import (absolute_import, division, print_function)

import os
from subprocess import check_output, CalledProcessError, STDOUT
from ranger.api.commands import Command


class GitRoot(Command):
    """:GitRoot

    cd to the root of the current git repository.
    If already at the root, cd to ~/repos.
    If not in a git repository, cd to ~/repos.
    """

    def execute(self):
        cwd = self.fm.thisdir.path
        cd_path = os.path.expanduser('~/repos')

        try:
            git_root = check_output(
                'git rev-parse --show-toplevel', stderr=STDOUT,
                shell=True).decode('utf-8').strip()
            if git_root != cwd:
                cd_path = git_root
        except CalledProcessError:
            pass

        self.fm.cd(cd_path)
