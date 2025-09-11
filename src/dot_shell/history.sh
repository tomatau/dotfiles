# not added into history:
# - entries beginning with space
# - duplicates
export HISTCONTROL="ignorespace:erasedups"

# to internity!...
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTTIMEFORMAT="[%F %T] "

# make some commands not show up in history
export HISTIGNORE="ls:l:li:la:lai:las:lt:lti:cd:cd -:-:pwd:exit:date:* --help";
