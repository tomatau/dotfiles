#!/bin/bash

alias plz="sudo "
alias c="clear"
alias reload="exec $SHELL -l"

# Start an HTTP server from a directory, optionally specifying the port
function server2() {
  local port="${1:-8000}";
  sleep 1 && open "http://localhost:${port}/" &
  # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
  # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
  python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}

# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver() {
  local port="${1:-9000}";
  local ip="localhost";
  sleep 1 && open "http://${ip}:${port}/" &
  php -S "${ip}:${port}";
}

# `tree` with hidden files and color enabled,
# ignoring the `.git` directory, 
# listing directories first. The output gets piped into
# `less` preserve color and line numbers, 
# unless the output is small enough for one screen.
function tre() {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Get week number
alias week='date +%V'

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# vim to allow Ctrl+S to save
function vim() {
  # Save current stty options.
  local STTYOPTS="$(stty -g)"
 
  # Disable intercepting of ctrl-s and ctrl-q as flow control.
  stty stop '' -ixoff -ixon
 
  # Execute vim.
  vim_command "$@"
 
  # Restore saved stty options.
  stty "$STTYOPTS"
}
function vim_command() {
  if (( $+commands[reattach-to-user-namespace] )); then
    # See: https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard
    command reattach-to-user-namespace vim "$@"
  else
    command vim "$@"
  fi
}
