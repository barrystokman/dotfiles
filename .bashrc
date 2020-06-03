# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# readable colors
bldblk='\e[1;30m' # Black, Nord subtle (comment color)
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green, Nord success 
bldylw='\e[1;33m' # Yellow, Nord warning
bldblu='\e[1;34m' # blue, Nord highlight
bldppl='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan, Nord primary
bldwht='\e[1;37m' # White
bldlbl='\e[1;94m' # Light Blue
txtrst='\e[0m'    # Text Reset - Useful for avoiding color bleed

# parsing git and conda info
parse_git_branch() {
  git_repo_branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
  if [ -z $git_repo_branch ]; then
    git_repo_branch="None"
  fi
  echo $git_repo_branch
}

parse_git_name() {
  if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
    local git_repo_name=$(basename `git rev-parse --show-toplevel`) 
  else
    local git_repo_name="None"
  fi
  echo $git_repo_name
}

parse_conda_env() {
  if [ -z $CONDA_DEFAULT_ENV ]; then
    conda_env_name="None"
  else
    conda_env_name=$(echo $CONDA_DEFAULT_ENV)
  fi
  echo $conda_env_name
}


if [ "$color_prompt" = yes ]; then
     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    #PS1='┌─[\[\e[34m\]\h\[\e[00m\]][\[\e[34m\]\w\[\e[00m\]]\n└──\[\e[34m\]■\[\e[00m\] '
    #PS1="[\[$bldblu\]\h\[$txtrst\]] in [\[$bldlbl\]\w\[$txtrst\]]"
    #PS1="${PS1} working on \[$bldred\]\$(parse_git_name)\[$txtrst\] $"
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

#export PS1="\[$bldblu\]\h\[$txtrst\] \[$bldcyn\]\w\[$txtrst\] Conda env: \[$bldppl\]\$(parse_conda_env)\[$txtrst\] Git repo: \[$bldred\]\$(parse_git_name)\[$txtrst\] Git branch: \[$bldylw\]\$(parse_git_branch)\[$txtrst\]\n$"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
# alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

# added by Miniconda3 installer
export PATH="/home/barry/miniconda3/bin:$PATH"

# adds Julia bin to $PATH
export PATH="/home/barry/julia-1.0.0/bin:$PATH"

# autojump: source /usr/share/autojump/autojump.sh on startup.
. /usr/share/autojump/autojump.sh

# Only load Liquid Prompt in interactive shells, not from a script or from scp
[[ $- = *i* ]] && source ~/liquidprompt/liquidprompt

# required for fasd
eval "$(fasd --init auto)"

# required for `conda activate`
. /home/barry/miniconda3/etc/profile.d/conda.sh
