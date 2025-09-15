function __update_fzf_commands
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -gx FZF_DEFAULT_COMMAND "git ls-files --cached --others --exclude-standard"
        set -gx FZF_CTRL_T_COMMAND "git ls-files --cached --others --exclude-standard"
        set -gx FZF_ALT_C_COMMAND "git ls-files --cached --others --exclude-standard | xargs -I {} dirname {} | sort -u"
    else
        set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"
        set -gx FZF_CTRL_T_COMMAND "fd --type f --type d --hidden --follow --exclude .git"
        set -gx FZF_ALT_C_COMMAND "fd --type d --hidden --follow --exclude .git"
    end
end
