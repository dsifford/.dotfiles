"""
Dotbot plugin for syncing global npm modules.
"""
import json
from subprocess import DEVNULL, PIPE, CalledProcessError, run
from typing import FrozenSet, List

from dotbot import Plugin


class Npm(Plugin):
    """Plugin implementation."""

    _directive = "npm"

    def can_handle(self, directive) -> bool:
        """Checks to see if current item is handleable."""
        return directive == self._directive

    def handle(self, _directive, data) -> bool:
        """Handler implementation."""
        success = True
        truth = frozenset(data)
        installed = Npm._get_installed_modules()

        to_uninstall = list(installed.difference(truth))
        to_install = list(truth.difference(installed))

        if to_uninstall:
            success &= self._uninstall(to_uninstall)

        if to_install:
            success &= self._install(to_install)

        if success:
            self._log.info("Successfully synced global npm modules")
        else:
            self._log.warning("Global npm modules not synced successfully")
        return success

    def _install(self, mods: List[str]) -> bool:
        self._log.lowinfo(f"Installing missing npm modules: {mods}")
        try:
            run(["npm", "-g", "i", *mods], check=True, stdout=PIPE, stderr=PIPE)
            return True
        except CalledProcessError as err:
            self._log.error("An error occurred while attempting to install modules")
            print(err.output)
            return False

    def _uninstall(self, mods: List[str]) -> bool:
        self._log.lowinfo(f"Uninstalling extraneous npm modules: {mods}")
        try:
            run(["npm", "-g", "rm", *mods], check=True, stdout=PIPE, stderr=PIPE)
            return True
        except CalledProcessError as err:
            self._log.error(f"An error occurred while attempting to uninstall modules")
            print(err.output)
            return False

    @staticmethod
    def _get_installed_modules() -> FrozenSet[str]:
        output = json.loads(
            run(
                ["npm", "ls", "-g", "--depth", "0", "--json"],
                stdout=PIPE,
                stderr=DEVNULL,
            ).stdout
        )
        try:
            modules = output["dependencies"].keys()
            return frozenset(modules)
        except KeyError:
            return frozenset([])
