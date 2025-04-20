#!/usr/bin/env zsh

# Get the current column width as a float
WIDTH=$(niri msg --json column | jq -r .width)

# Use bc for safe float comparison
if [[ "$(echo "$WIDTH == 1.0" | bc -l)" -eq 1 ]]; then
  niri msg action set-column-width "33%"
else
  niri msg action set-column-width "100%"
fi

