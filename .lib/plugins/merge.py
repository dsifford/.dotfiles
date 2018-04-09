# pylint: disable=missing-docstring
"""
Dotbot plugin that "merges" the contents of a defined directory with a
directory in the system by creating symlinks of all first-level children to
the directory specified on the system.

Salient use-case: Linking contents from `dotfiles/config/` to `$XDG_CONFIG_HOME/`

Usage:
    - merge:
        ~/.config: config
"""
# import os
from os import listdir, mkdir, path, symlink
import dotbot


class Merge(dotbot.Plugin):

    _directive = 'merge'

    def can_handle(self, directive):
        return directive == self._directive

    def handle(self, _directive, data) -> bool:
        global_success = True

        for dest, source in data.items():
            success = True
            source_raw = source
            dest_raw = dest
            source = self._normalize_path(
                path.join(self._context.base_directory(), source), True)
            dest = self._normalize_path(dest, True)

            if not path.isdir(source):
                self._log.warning(
                    '"{}" must be a directory. Use "link" instead'
                    .format(source))
                global_success = False
                continue

            if not path.exists(dest):
                mkdir(dest)
            elif not path.isdir(dest):
                self._log.warning(
                    'Destination {} exists, but is not a directory'
                    .format(dest))
                global_success = False
                continue

            for item in listdir(source):
                src_path = self._normalize_path(path.join(source, item), True)
                dest_path = self._normalize_path(path.join(dest, item), True)
                dest_path_raw = path.join(dest_raw, item)

                if path.exists(dest_path):
                    success &= self._check_existing_dest(
                        src_path, dest_path, dest_path_raw)
                elif not path.exists(src_path):
                    self._log.warning('Nonexistent target for {} : {}'.format(
                        dest_path, src_path))
                    success = False
                else:
                    try:
                        symlink(src_path, dest_path)
                    except OSError:
                        self._log.warning('Linking failed {} -> {}'.format(
                            dest_path, src_path))
                        success = False
                    else:
                        self._log.lowinfo('Creating link {} -> {}'.format(
                            dest_path, src_path))
            if success:
                self._log.info('Successfully merged {} to {}'.format(
                    source_raw, dest_raw))
            else:
                self._log.error(
                    'Some links were not successfully set up in {}'.format(
                        dest_raw))

            global_success &= success

        if global_success:
            self._log.info('All merges completed successfully')
        else:
            self._log.error('Some merges failed to complete successfully')

        return global_success

    def _check_existing_dest(self, src_path: str, dest_path: str,
                             dest_path_raw: str) -> bool:
        """Return True if existing path "dest_path" is a symlink that points to src"""
        if not path.islink(dest_path):
            self._log.warning(
                '{} already exists but is a regular file or directory'
                .format(dest_path_raw))
            return False
        elif not path.exists(src_path):
            self._log.warning('Nonexistent target {} -> {}'.format(
                dest_path_raw, src_path))
            return False
        elif path.realpath(dest_path) != src_path:
            self._log.warning('Invalid link {} -> {}'.format(
                dest_path_raw, path.realpath(dest_path)))
            return False

        self._log.lowinfo('Link exists {} -> {}'.format(
            dest_path_raw, src_path))
        return True

    @staticmethod
    def _normalize_path(raw_path: str, require_absolute=False) -> str:
        """Takes a path containing '..', '$ENVVAR', or '~' and returns normalized path"""
        normalized = path.normpath(path.expandvars(path.expanduser(raw_path)))
        if require_absolute and not path.isabs(normalized):
            raise ValueError('Path {} must be absolute'.format(normalized))
        else:
            return normalized
