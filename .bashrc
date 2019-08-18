# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Set the custom bin path
PATH="$HOME/bin:$PATH"

# Load some special dotfiles
for file in ~/.{bash_prompt,aliases,motd}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Support for GO-Installation
export GOPATH=/mnt/c/Development/_GOLang
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# Export System Variables for Development
export MUTATION_THREADS=4

###
# Configure the Bash
###

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;
# Append to the Bash history file, rather than overwriting it
shopt -s histappend;
# Autocorrect typos in path names when using `cd`
shopt -s cdspell;
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize;

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
