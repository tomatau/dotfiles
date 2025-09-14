# not added into history:
# - entries beginning with space
# - duplicates
export HISTCONTROL="ignorespace:erasedups"

# to internity!...
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTTIMEFORMAT="[%F %T] "

# Commands not to show up in history
export HISTIGNORE="pwd:..:...:....:.....:ls:l:li:la:lai:las:lt:lti:cd:cd -:-:pwd:exit:date:* --help";
