# shellcheck shell=bash
#
# Commands for starting and stopping torrent services
#

for cmd in transmission-daemon transmission-remote windscribe; do
	command -v "$cmd" > /dev/null || return
done

torrent-start() {
	systemctl start wg-quick@wg0.service
	transmission-daemon
	$BROWSER https://ipleak.net/
	systemctl status wg-quick@wg0.service
}

torrent-stop() {
	transmission-remote --exit
	systemctl stop wg-quick@wg0.service
	systemctl status wg-quick@wg0.service
}
