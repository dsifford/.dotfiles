"""
Dotbot plugin for syncing pipx packages.
"""
from distutils.util import strtobool
from re import MULTILINE, findall
from subprocess import DEVNULL, PIPE, CalledProcessError, check_call, run
from typing import FrozenSet, List

from dotbot import Plugin


class Pipx(Plugin):
    """Plugin implementation."""

    __directive: str = "pipx"

    def can_handle(self, directive) -> bool:
        """Checks to see if current item is handleable."""
        return directive == self.__directive and Pipx.__is_installed()

    def handle(self, _directive, data) -> bool:
        """Handler implementation."""
        success = True
        truth = frozenset(data)
        installed = Pipx.__get_installed_packages()

        to_uninstall = list(installed.difference(truth))
        to_install = list(truth.difference(installed))

        if to_uninstall:
            success &= self.__uninstall(to_uninstall)

        if to_install:
            success &= self.__install(to_install)

        if success:
            self._log.info("Successfully synced pipx packages")
        else:
            self._log.warning("Pipx packages not synced successfully")

        return success

    def __install(self, packages: List[str]) -> bool:
        """Installs pipx packages."""
        self._log.lowinfo(f"Installing missing pipx packages: {packages}")
        try:
            for pkg in packages:
                run(["pipx", "install", pkg], check=True)
            return True
        except CalledProcessError as err:
            self._log.error("An error occurred while attempting to install packages")
            print(err.output)
            return False

    def __uninstall(self, packages: List[str]) -> bool:
        """Uninstalls pipx packages."""
        self._log.lowinfo(f"Uninstalling extraneous pipx packages: {packages}")
        try:
            for pkg in packages:
                run(["pipx", "uninstall", pkg], check=True)
            return True
        except CalledProcessError as err:
            self._log.error("An error occurred while attempting to uninstall packages.")
            print(err.output)
            return False

    @staticmethod
    def __get_installed_packages() -> FrozenSet[str]:
        """Fetches and returns a frozenset of installed packages."""
        output = run(["pipx", "list"], stdout=PIPE, stderr=DEVNULL).stdout.decode(
            "utf-8"
        )
        return frozenset(findall(r"^\s+package ([\w-]+)", output, MULTILINE))

    @staticmethod
    def __is_installed() -> bool:
        """Checks to see if pipx is installed and available in PATH."""
        try:
            check_call(
                ["bash", "-c", "command -v pipx"], stdout=DEVNULL, stderr=DEVNULL
            )
            return True
        except CalledProcessError:
            return False
