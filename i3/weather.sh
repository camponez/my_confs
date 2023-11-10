APIKEY=''

$HOME/.pyenv/shims/python "$HOME/.i3/weather.py" --update-interval 900  \
        --api-key "$APIKEY" --place Dublin \
        --format '{city}, {text}, {temp_c}C, Winds: {wind_speed_kmh}km/h' > "$HOME/weather"
