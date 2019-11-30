# shellcheck shell=bash
#
# Commands for starting and stopping torrent services
#

for cmd in transmission-daemon transmission-remote windscribe; do
	command -v "$cmd" > /dev/null || return
done

torrent-start() {
	windscribe connect Cub
	windscribe firewall on
	transmission-daemon
	$BROWSER https://ipleak.net/
}

torrent-stop() {
	transmission-remote --exit
	windscribe firewall auto
	windscribe disconnect
}
