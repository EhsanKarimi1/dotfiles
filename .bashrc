#!/bin/bash

#######################################
##         Basic definitions         ##
#######################################
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

#######################################
##             EXPORTS               ##
#######################################
# Disable the bell
if [[ $iatest > 0 ]]; then bind "set bell-style visible"; fi

# Expand the history size
export HISTFILESIZE=10000
export HISTSIZE=500

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest > 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest > 0 ]]; then bind "set show-all-if-ambiguous On"; fi

# Set the default editor
export EDITOR=nvim
export VISUAL=nvim

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'
#export GREP_OPTIONS='--color=auto' #deprecated
alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS

# Set Keyboard language
setxkbmap gb

#######################################
##          Alias commands           ##
#######################################
# Change directory aliases
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cl='clear'
alias w='cd ~/w'

# Edit this .bashrc file
alias ebrc='vi ~/.bashrc'

# alias to show the date
alias da='date "+%Y-%m-%d %B %A %T"'

# Alias's to modified commands
alias rm='rm -rf'
alias srm='sudo rm -rf'
alias cp='cp'
alias mv='mv'
alias mkdir='mkdir -p'
alias ping='ping -c 10'
alias vi='nvim'
alias svi='sudo nvim'

# Changing "ls" to "exa"
alias la='exa -alh --color=always --group-directories-first --icons' # show all files (hidden/visible)
alias law='exa -a --color=always --group-directories-first --icons' # wide view visible files
alias l='exa -lh --color=always --group-directories-first --icons' # show visible files
alias l.='exa -a | egrep "^\."' # show dotfiles
alias lrec='exa -lRh --color=always --group-directories-first' # recursive ls
alias lf="exa -l | egrep -v '^d'" # files only
alias ldir="exa -l | egrep '^d'" # directories only

# Alias's for multiple directory listing commands
alias lsize='ls -lSrh --color=always --group-directories-first' # sort by size
alias ldate='ls -ltrh --color=always --group-directories-first' # sort by date
alias labc='ls -lap --color=always --group-directories-first' #alphabetical sort

# Search command line history
alias h="history | grep"

# Search files in the current folder
alias f="find . | grep"

# Search running processes
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -20"

# Show open ports
alias openports='netstat -nape --inet'

# Alias's for safe and forced reboots
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

# Alias's for archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias mkzip='zip -r'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# additional aliases
alias py='python'
alias dns='sudo vi /etc/systemd/resolved.conf'
alias dnsre='sudo systemctl restart systemd-resolved.service'
alias hosts='sudo vi /etc/hosts'
alias neko='sudo ./Downloads/nekoray/launcher'

### DNF package manager
alias dnfin='sudo dnf install'
alias dnfrm='sudo dnf autoremove'
alias dnfup='sudo dnf update'
alias dnfhi='dnf history'
alias dnfse='dnf search'
alias dnfcl='dnf clean all'

### APT(nala) package manager
alias nalain='sudo nala install'
alias nalarm='sudo nala '
alias nalaup='sudo nala update'
alias nalahi='nala history' # sudo nala history undo [install num]
alias nalafe='sudo nala fetch'

# Show all logs in /var/log
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f | less"

# Adding flags
alias df='df -h' # human-readable sizes

# git
alias addup='git add -u'
alias addall='git add -A'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status' # 'status' is protected name so using 'stat' instead 
alias tag='git tag' 
alias newtag='git tag -a'

#######################################
##         Specefic Aliases          ##
#######################################
# Alias's for SSH
alias SERVERNAME='ssh root@IP'

# Alias's to change the directory
alias web='cd /var/www/html'

#######################################
##        Special functions          ##
#######################################
# Extracts any archive(s) (if unp isn't installed)
extract () {
	for archive in $*; do
		if [ -f $archive ] ; then
			case $archive in
				*.tar.bz2)   tar xvjf $archive    ;;
				*.tar.gz)    tar xvzf $archive    ;;
				*.bz2)       bunzip2 $archive     ;;
				*.rar)       rar x $archive       ;;
				*.gz)        gunzip $archive      ;;
				*.tar)       tar xvf $archive     ;;
				*.tbz2)      tar xvjf $archive    ;;
				*.tgz)       tar xvzf $archive    ;;
				*.zip)       unzip $archive       ;;
				*.Z)         uncompress $archive  ;;
				*.7z)        7z x $archive        ;;
				*)           echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}

ftext ()
{
	# -i case-insensitive
	# -I ignore binary files
	# -H causes filename to be printed
	# -r recursive search
	# -n causes line number to be printed
	# optional: -F treat search term as a literal, not a regular expression
	# optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
	grep -iIHrn --color=always "$1" . | less -r
}

# Copy file with a progress bar
cpp()
{
	set -e
	strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
	| awk '{
	count += $NF
	if (count % 10 == 0) {
		percent = count / total_size * 100
		printf "%3d%% [", percent
		for (i=0;i<=percent;i++)
			printf "="
			printf ">"
			for (i=percent;i<100;i++)
				printf " "
				printf "]\r"
			}
		}
	END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

# Create and go to the directory
mkdirg ()
{
	mkdir -p $1
	cd $1
}

# Show the current distribution
distribution(){
if [[ -e /etc/os-release ]]
then
	DISTRO=$(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)
fi
echo $DISTRO
}

#######################################
##            Starship               ##
#######################################
eval "$(starship init bash)"
