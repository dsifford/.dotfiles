"""
Dotbot plugin for installing arch linux packages with yay.

Note: The only key in the yay object that matters is `aur`, which should
specify the packages that exist in the AUR. Otherwise, keys can be anything.

Note: No keys are required.

Usage:
    - yay:
        aur:
            - aur-package-1
            - aur-package-2
        key_doesnt_matter:
            - package-name
            - group-name
            - another-package
        can_be_anything:
            - you
            - get
            - the
            - idea
"""
from itertools import chain, filterfalse
from subprocess import CalledProcessError, run  # nosec
from typing import Dict, List

from dotbot import Plugin

DataType = Dict[str, List[str]]


class Yay(Plugin):
    """Plugin implementation"""

    _directive = "yay"

    def can_handle(self, directive: str) -> bool:
        """Checks to see if current item is handleable"""
        return directive == self._directive and self.is_installed

    def handle(self, _directive: str, data: DataType) -> bool:
        """Handler implementation"""
        aur = data.pop("aur", None)
        official = sorted(chain(*data.values()))
        success = self.install_official(official)
        if aur:
            success &= self.install_aur(aur)
        return success

    def install_aur(self, packages: List[str]) -> bool:
        """Installs the AUR packages given that are needed to be installed"""
        self._log.info("Installing missing AUR packages")
        to_install = list(filterfalse(Yay.is_package_installed, packages))
        if to_install:
            return Yay.__run(["-S", *to_install])
        return True

    def install_official(self, packages: List[str]) -> bool:
        """Installs the packages given that are needed to be installed"""
        self._log.info("Installing missing arch packages")
        return Yay.__run(["-Syuq", "--needed", *packages])

    @property
    def is_installed(self) -> bool:
        """Returns True if yay is installed"""
        try:
            run(
                ["bash", "-c", "command -v yay"],
                capture_output=True,
                text=True,
                check=True,
            )
            return True
        except CalledProcessError:
            return False

    @staticmethod
    def is_package_installed(package: str) -> bool:
        """Returns true if the given package is already installed"""
        return Yay.__run(["-Qi", package], capture_output=True, text=True)

    @staticmethod
    def __run(args: List[str], capture_output=False, text=None) -> bool:
        """Internal helper for running yay commands"""
        try:
            run(["yay", *args], capture_output=capture_output, text=text, check=True)
            return True
        except CalledProcessError:
            return False
