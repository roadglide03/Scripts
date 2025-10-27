sudo launchctl list | sed 1d | awk '!/0x|com\.(apple|openssh|vix)|edu\.mit|org\.(amavis|apache|cups|isc|ntp|postfi x|x)/{print $3}'

