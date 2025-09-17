
#!/usr/bin/env zsh

# directory name is executed as if it were the argument to a cd
setopt AUTO_CD

# auto misspelled commands
setopt CORRECT

# include filenames beginning with a . in the results of expansions
setopt DOT_GLOB

# case-insensitive globbing (used in pathname expansion)
setopt NO_CASE_GLOB

# append to the history file, don't overwrite it
setopt APPEND_HISTORY
setopt HIST_VERIFY
