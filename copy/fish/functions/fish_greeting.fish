function fish_greeting
  set_color 444
  echo -ns \
    (command whoami) \
    ' @ ' \
    (command hostname) \
    ' / uptime: ' \
    (command uptime | sed 's/.*up \([^,]*\), .*/\1/') \
    ' / version: ' \
    "$FISH_VERSION"
  set_color $fish_color_normal
  echo
end
