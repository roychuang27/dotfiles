#! /usr/bin/nu

let layout = (mmsg get all-tags | from json | get all_tags.0.tags | where is_active == true | get layout | to text)

echo $layout

notify-send "Current Layout" $"($layout)"
