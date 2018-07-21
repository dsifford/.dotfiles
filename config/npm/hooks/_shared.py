"""Shared helper functions for global (un)install hooks."""
import json
import sys
from glob import glob
from os import getenv, path
from subprocess import DEVNULL, PIPE, CalledProcessError, run
from typing import List, Optional

import yaml

NPM_PACKAGES_FILE = path.expanduser(
    "~/.dotfiles/.lib/config/generated/packages.npm.yml"
)


def get_toplevel_packages() -> Optional[List[str]]:
    """Return toplevel packages if current package is part of the list. Otherwise None."""
    current_package = getenv("npm_package_name")
    argv = getenv("npm_config_argv")
    if not current_package or not argv:
        return None
    packages = json.loads(argv)["remain"]
    return None if current_package not in packages else packages


def get_global_packages() -> List[str]:
    """Return a list of all currently installed global npm packages."""
    try:
        prefix = run(
            ["npm", "config", "get", "prefix"], stdout=PIPE, stderr=DEVNULL, check=True
        )
        packages = sorted(
            [
                path.basename(x)
                for x in glob(
                    path.join(
                        prefix.stdout.decode("utf-8").strip(),
                        "lib",
                        "node_modules",
                        "*",
                    )
                )
            ]
        )
        return packages
    except CalledProcessError as err:
        print(err)
        sys.exit(1)


def write_pkg_file(exclude: Optional[List[str]] = None) -> None:
    """Writes package list to NPM_PACKAGES_FILE, excluding packages given"""
    excluded = exclude if exclude is not None else []
    with open(NPM_PACKAGES_FILE, mode="w") as file:
        file.write("#\n" "# THIS IS A GENERATED FILE. DO NOT EDIT DIRECTLY.\n" "#\n")
        yaml.dump(
            [{"npm": [p for p in get_global_packages() if p not in excluded]}],
            file,
            default_flow_style=False,
        )
