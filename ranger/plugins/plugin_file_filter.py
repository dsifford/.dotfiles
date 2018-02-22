# This plugin shows all files located inside the .dotfiles directory by default

from __future__ import (absolute_import, division, print_function)
from os import getenv, path
import ranger.container.directory
# from logging import getLogger

ACCEPT_FILE_OLD = ranger.container.directory.accept_file

DOTFILES_PATH = "{}/.dotfiles/".format(getenv('HOME', '/home/dsifford'))

# LOG = getLogger(__file__)


# Define a new one
def custom_accept_file(fobj, filters):
    ignored = ['.git', '__pycache__']
    if (fobj.path.startswith(DOTFILES_PATH) and
            path.basename(fobj.path) not in ignored):
        return True
    return ACCEPT_FILE_OLD(fobj, filters)


# Overwrite the old function
ranger.container.directory.accept_file = custom_accept_file
