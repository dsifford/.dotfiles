# shellcheck shell=bash
#
# Temporary helper function that fixes a known issue in zeal due to a QTWebKit
# issue.
#

# FIXME: delete this when this issue gets resolved: https://github.com/zealdocs/zeal/issues/1155
zeal-fix-content-rendering() {
	find "$XDG_DATA_HOME"/Zeal/Zeal/docsets -type f -iname 'react-main.*.js' -delete
}
