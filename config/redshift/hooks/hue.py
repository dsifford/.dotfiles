#!/usr/bin/env python3.7
"""Redshift hook that automatically adjust hue lights in workstation."""
import json
from argparse import ArgumentParser
from os import makedirs
from os.path import expandvars
from urllib import request

from phue import Bridge  # type: ignore

GROUP = "Bedroom"
SCENE_DAY = "Day"
SCENE_NIGHT = "Night"


def parse_args():
    "Parse input args from redshift."
    parser = ArgumentParser()
    subparser = parser.add_subparsers(dest="action")
    subparser.add_parser("toggle")
    period_changed = subparser.add_parser("period-changed")
    period_changed.add_argument("period_before")
    period_changed.add_argument("period_after")
    return parser.parse_args()


def get_bridge():
    "Retrieves the hue bridge instance."
    data_path = expandvars("$XDG_DATA_HOME/phue")
    makedirs(data_path, exist_ok=True)
    with request.urlopen("https://discovery.meethue.com") as response:  # nosec
        ip_addr = json.loads(response.read())[0]["internalipaddress"]
        bridge = Bridge(ip_addr, config_file_path=f"{data_path}/data.json")
        bridge.connect()
        bridge.get_api()
        return bridge


def main():
    "Main entrypoint."
    bridge = get_bridge()
    args = parse_args()

    group_id = int(bridge.get_group_id_by_name(GROUP))
    group = bridge.get_group(group_id)
    lights_are_on = group["state"]["any_on"]

    if args.action == "toggle":
        bridge.set_group(group_id, "on", not lights_are_on)
        return

    transition = 18000 if args.period_after == "transition" else 4

    if not lights_are_on:
        return

    if args.period_after in ["night", "transition"]:
        bridge.run_scene(GROUP, SCENE_NIGHT, transition_time=transition)
    else:
        bridge.run_scene(GROUP, SCENE_DAY, transition_time=transition)


if __name__ == "__main__":
    main()
