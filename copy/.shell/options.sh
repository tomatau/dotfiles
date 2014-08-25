#!/bin/bash

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# When the name of a directory is a command, it is executed as if it were the argument to a cd
shopt -s autocd

# auto fix minor typos to CD and directory names
shopt -s cdspell
shopt -s dirspell

# include filenames beginning with a . in the results of expansions
shopt -s dotglob

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob


