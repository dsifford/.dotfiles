"""
Dotbot plugin that "merges" the contents of a defined directory with a
directory in the system by creating symlinks of all first-level children to
the directory specified on the system.

Salient use-case: Linking contents from `dotfiles/config/` to `$XDG_CONFIG_HOME/`

Usage:
    - merge:
        ~/.config: config
"""
from os import listdir, mkdir, path, symlink

from dotbot import Plugin


class Merge(Plugin):
    """Plugin implementation."""

    _directive = "merge"

    def can_handle(self, directive) -> bool:
        """Checks to see if current item is handleable."""
        return directive == self._directive

    def handle(self, _directive, data) -> bool:
        """Handler implementation."""
        global_success = True

        for dest, source in data.items():
            success = True
            source_raw = source
            dest_raw = dest
            source = self._normalize_path(
                path.join(self._context.base_directory(), source), True
            )
            dest = self._normalize_path(dest, True)

            if not path.isdir(source):
                self._log.warning(f"'{source}' must be a directory. Use 'link' instead")
                global_success = False
                continue

            if not path.exists(dest):
                mkdir(dest)
            elif not path.isdir(dest):
                self._log.warning(f"Destination {dest} exists, but is not a directory")
                global_success = False
                continue

            for item in listdir(source):
                src_path = self._normalize_path(path.join(source, item), True)
                dest_path = self._normalize_path(path.join(dest, item), True)
                dest_path_raw = path.join(dest_raw, item)

                if path.exists(dest_path):
                    success &= self._check_existing_dest(
                        src_path, dest_path, dest_path_raw
                    )
                elif not path.exists(src_path):
                    self._log.warning(
                        f"Nonexistent target for {dest_path} : {src_path}"
                    )
                    success = False
                else:
                    try:
                        symlink(src_path, dest_path)
                    except OSError:
                        self._log.warning(f"Linking failed {dest_path} -> {src_path}")
                        success = False
                    else:
                        self._log.lowinfo(f"Creating link {dest_path} -> {src_path}")
            if success:
                self._log.info(f"Successfully merged {source_raw} to {dest_raw}")
            else:
                self._log.error(
                    f"Some links were not successfully set up in {dest_raw}"
                )

            global_success &= success

        if not global_success:
            self._log.error("Some merges failed to complete successfully")

        return global_success

    def _check_existing_dest(
        self, src_path: str, dest_path: str, dest_path_raw: str
    ) -> bool:
        """Return True if existing path "dest_path" is a symlink that points to src"""
        if not path.islink(dest_path):
            self._log.warning(
                f"{dest_path_raw} already exists but is a regular file or directory"
            )
            return False
        elif not path.exists(src_path):
            self._log.warning(f"Nonexistent target {dest_path_raw} -> {src_path}")
            return False
        elif path.realpath(dest_path) != src_path:
            self._log.warning(
                f"Invalid link {dest_path_raw} -> {path.realpath(dest_path)}"
            )
            return False

        self._log.lowinfo(f"Link exists {dest_path_raw} -> {src_path}")
        return True

    @staticmethod
    def _normalize_path(raw_path: str, require_absolute=False) -> str:
        """Takes a path containing '..', '$ENVVAR', or '~' and returns normalized path"""
        normalized = path.normpath(path.expandvars(path.expanduser(raw_path)))
        if require_absolute and not path.isabs(normalized):
            raise ValueError(f"Path {normalized} must be absolute")
        else:
            return normalized
