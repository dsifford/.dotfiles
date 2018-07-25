"""
Dotbot plugin for copying secure files from keybase into the filesystem.
"""

from os import path
from subprocess import DEVNULL, PIPE, CalledProcessError, check_call, run
from typing import Optional

from dotbot import Plugin


class Keybase(Plugin):
    """Plugin implementation."""

    __directive: str = "keybase"

    def can_handle(self, directive: str) -> bool:
        """Checks to see if current item is handleable."""
        return directive == self.__directive and Keybase.__is_installed

    def handle(self, _directive, data) -> bool:
        """Handler implementation."""
        success = True
        for dest, source in data.items():
            dest_abs = path.expandvars(path.expanduser(dest))
            if not self.__file_exists(source):
                success = False
            elif path.isfile(dest_abs):
                if self.__files_are_identical(source, dest_abs):
                    self._log.lowinfo(f"Files are identical: {source} -> {dest}")
                else:
                    self._log.lowinfo(
                        f"Files not indentical. Copying: {source} -> {dest}"
                    )
                    success &= self.__copy_file(source, dest_abs)
            else:
                self._log.lowinfo(f"Copying file: {source} -> {dest}")
                success &= self.__copy_file(source, dest_abs)

        if success:
            self._log.info("Successfully synced keybase files")
        else:
            self._log.warning("One or more keybase files not synced successfully")
        return success

    def __files_are_identical(
        self, kb_file_path: str, dest_file_path: str
    ) -> Optional[bool]:
        """
        Compares the contents of the source and dest files and returns a bool
        specifying whether or not they are identical. If None is returned,
        that means an error happened.
        """
        kb_file_contents = Keybase.__read(kb_file_path)
        if kb_file_contents is None:
            self._log.warning(
                f"An error occurred while attempting to read file {kb_file_path}"
            )
            return None

        with open(dest_file_path) as file:
            dest_file_contents = file.read()
            return dest_file_contents == kb_file_contents

    def __file_exists(self, kb_file_path: str) -> bool:
        """Checks to see if a given file exists in KBFS."""
        try:
            check_call(
                ["keybase", "fs", "stat", kb_file_path], stdout=DEVNULL, stderr=DEVNULL
            )
            return True
        except CalledProcessError:
            if not path.isabs(kb_file_path):
                self._log.warning(
                    f"keybase path must be absolute. Skipping {kb_file_path}"
                )
            else:
                self._log.warning(
                    f"keybase path does not exist. Skipping {kb_file_path}"
                )
            return False

    def __copy_file(self, kb_file_path: str, dest_file_path: str) -> bool:
        """Copies (and forcibly overwrites) keybase file to local filesystem."""
        try:
            check_call(
                ["keybase", "fs", "cp", "-f", kb_file_path, dest_file_path],
                stdout=DEVNULL,
                stderr=DEVNULL,
            )
            return True
        except CalledProcessError as err:
            self._log.error(
                f"An error occurred while attempting to copy {kb_file_path} to {dest_file_path}"
            )
            print(err.output)
            return False

    @staticmethod
    def __read(kb_file_path: str) -> Optional[str]:
        """Reads a given file from KBFS and returns the contents as a utf-8 string."""
        try:
            return run(
                ["keybase", "fs", "read", kb_file_path],
                check=True,
                stdout=PIPE,
                stderr=DEVNULL,
            ).stdout.decode("utf-8")
        except CalledProcessError:
            return None

    @staticmethod
    def __is_installed() -> bool:
        """Checks to see if keybase is installed and available in PATH."""
        try:
            check_call(
                ["bash", "-c", "command -v keybase"], stdout=DEVNULL, stderr=DEVNULL
            )
            return True
        except CalledProcessError:
            return False
