#!/bin/bash

APIKEY=''

i3status -c ~/.i3/i3status | while :
do
    read line
    BTC=$($HOME/.pyenv/shims/python $HOME/.i3/btc.py)
    WEATHER=$($HOME/.pyenv/shims/python $HOME/.i3/weather.py --update-interval 900  --api-key $APIKEY --place Dublin --format '{city}, {text}, {temp_c}C, Winds: {wind_speed_kmh}km/h')
    echo "$BTC - $WEATHER - $line" || exit 1
done
