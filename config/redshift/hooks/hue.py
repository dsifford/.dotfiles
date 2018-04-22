#!/usr/bin/env python3
"""Redshift hook that automatically adjust hue lights in workstation"""
from argparse import ArgumentParser
from os import path
import sys
from subprocess import call
from phue import Bridge


class Dotprop(dict):
    """Helper class that allows all dicts to be accessed with a dot"""

    def __init__(self, obj):
        super().__init__(obj)
        for key, val in self.items():
            if isinstance(val, dict):
                self[key] = Dotprop(val)

    def __getattr__(self, name):
        return self[name]

    def __setattr__(self, name, value):
        self[name] = value


class HueController(object):
    """Main controller class"""
    groups = Dotprop({})

    config = Dotprop({
        'day': {
            'accent': {
                'on': True,
                'bri': 254,
            },
            'main': {
                'on': True,
                'bri': 254,
                'hue': 39392,
                'sat': 13,
                'ct': 230,
                'xy': [0.3691, 0.3719],
            },
        },
        'night': {
            'accent': {
                'on': True,
                'bri': 50,
            },
            'main': {
                'on': True,
                'bri': 77,
                'hue': 8402,
                'sat': 140,
                'ct': 366,
                'xy': [0.4575, 0.4099],
            },
        },
    })

    _groups = Dotprop({
        'accent': 'Bedroom Accent',
        'main': 'Bedroom Lights',
    })

    def __init__(self):
        try:
            self.args = self._parse_args()
            self.bridge = self._get_bridge()
            self.groups.main = Dotprop(
                self.bridge.get_group(self._groups.main))
            self.groups.accent = Dotprop(
                self.bridge.get_group(self._groups.accent))
        except (FileNotFoundError, ValueError) as err:
            self.alert(err, 'critical')
            exit(1)

        if self.groups.main.state.all_on is False or self.args.event != 'period-changed':
            exit(0)

    def apply_config(self, config):
        """Applys configuration settings to bridge"""
        self.bridge.set_group(self._groups.main, config.main)
        self.bridge.set_group(self._groups.accent, config.accent)

    @staticmethod
    def alert(message, urgency='normal'):
        """Displays a desktop notification"""
        urgency = 'normal' if urgency not in ['low', 'critical'] else urgency
        call(['notify-send', '-u', urgency, 'Redshift Hue', message])

    @staticmethod
    def _get_bridge():
        config = path.expandvars('$XDG_CONFIG_HOME/phue/config.json')
        if not path.isfile(config):
            raise FileNotFoundError('Invalid config path: {}'.format(config))
        bridge = Bridge('192.168.1.236', config_file_path=config)
        bridge.connect()
        bridge.get_api()
        return bridge

    @staticmethod
    def _parse_args():
        if len(sys.argv) < 4:
            raise ValueError('Invalid number of arguments')
        parser = ArgumentParser()
        parser.add_argument('event')
        parser.add_argument('period_before')
        parser.add_argument('period_after')
        return parser.parse_args()


def main():
    """Main entrypoint"""
    controller = HueController()
    controller.alert('Event: {}\n'
                     'Old Period: {}\n'
                     'New Period: {}'.format(controller.args.event,
                                             controller.args.period_before,
                                             controller.args.period_after))

    if controller.args.period_after in ['transition', 'night']:
        config = controller.config.night
    else:
        config = controller.config.day

    if controller.args.period_after == 'transition':
        config.accent.transitiontime = 18000  # 30 mins
        config.main.transitiontime = 18000

    controller.apply_config(config)


if __name__ == '__main__':
    main()
