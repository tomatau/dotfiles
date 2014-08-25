# ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
# ~/.extra can be used for settings you don’t want to commit
# for file in ./copy/.shell/{extra,prompt,exports,aliases,functions}; do
#   [ -r ${file} ] && echo ${file}
# done

for file in ./copy/.shell/*; do
  # don't need checks! :o
  echo "$file"
done

unset file