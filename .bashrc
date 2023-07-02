#!/bin/bash

# "bat" as manpager 
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"

### EXPORT
# running interactively shell
case $- in
    *i*) ;;
      *) return;;
esac

export TERM="xterm-256color"	# getting proper colors
export HISTFILESIZE=10000
export HISTSIZE=500
export HISTCONTRPL=ignoreboth,erasedups,ignorespace
export EDITOR=nvim
export VISUAL=nvim

if [ -f /etc/bashrc ]; then
	 . /etc/bashrc
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

### BIND
bind 'set completion-ignore-case on'
bind 'TAB:menu-complete'

### SHOPT
#shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dirspell
shopt -s dotglob
shopt -s expand_aliases
shopt -s checkwinsize

### PATH
if [ -d "$HOME/.bin" ] ;
	then PATH="$HOME/.bin:$PATH" 
fi 

if [ -d "$HOME/.local/bin" ] ;
	then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.emacs.d/bin" ] ;   
	then PATH="$HOME/.emacs.d/bin:$PATH" 
fi

if [ -d "$HOME/.config/emacs/bin/" ] ;
	then PATH="$HOME/.config/emacs/bin/:$PATH" 
fi

if [ -d "$HOME/go/bin" ] ;
	then PATH="$HOME/go/bin/:$PATH"
fi

export PATH=$PATH:/usr/local/go/bin


### Custom Stuff
distribution(){
if [[ -e /etc/os-release ]]
then
	DISTRO=$(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)
	KERNEL=$(uname -s)
	KERNELVERSION=$(uname -r)
fi
echo $DISTRO
echo $KERNEL $KERNELVERSION
}

ipcheck(){
ip=$(curl -s http://ip-api.com/json/?fields=message,query,reverse,country,regionName,city,isp,as,proxy)
echo "$ip" | jq -r | sed 's/{//g'| sed 's/}//g' | sed 's/"//g' | sed 's/,//g'
}

dnscheck(){ 
        ns=$(curl -Ls http://edns.ip-api.com/json/?callback)                                                     
        echo "$ns" | jq -r | sed 's/{//g'| sed 's/}//g' | sed 's/"//g'| sed -r '/^\s*$/d'
}

ulogout(){
	com=$(sudo pkill -u $USER)
	echo "$com"
}

# Archive Extraction
extract(){
  if [ -f "$1" ] ; then
    case $1 in
	*.tar)       tar xf $1    ;;
	*.tar.xz)    tar xf $1    ;;
	*.tar.bz2)   tar xjf $1   ;;
	*.tbz2)      tar xjf $1   ;;
	*.tar.gz)    tar xzf $1   ;;
	*.tgz)       tar xzf $1   ;;
	*.tar.zst)   tar xaf $1   ;;
	*.bz2)       bunzip2 $1   ;;
	*.gz)        gunzip $1    ;;
	*.zip)       unzip $1     ;;
	*.rar)       unrar x $1   ;;
	*)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"	
  fi 
}

### Server Managing Command
alias x='ssh root@[IP]'
alias proxy='ssh -N -D 1080 root@194.116.190.35'

alias web='cd /var/www/html'


### ALIASES
# Change directory aliases
alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias pd='cd "$OLDPWD"'
alias cl='clear'

# Alias's to modified commands
alias ebrc='nvim ~/.bashrc'
alias da='date "+%Y-%m-%d %B %A %T"'
alias rm='rm -rf'
alias cp='cp'
alias mv='mv'
alias mkdir='mkdir -p'
alias ping='ping -c 10'
alias hosts='sudo vim /etc/hosts'
alias vi='nvim'

# Changing "ls" to "exa"
alias la='exa -alh --color=always --group-directories-first' # show all files (hidden/visible)
alias law='exa -a --color=always --group-directories-first' # wide view visible files
alias l='exa -lh --color=always --group-directories-first' # show visible files
alias l.='exa -a | egrep "^\."' # show dotfiles
alias lrec='exa -lRh --color=always --group-directories-first' # recursive ls
alias lf="exa -l | egrep -v '^d'" # files only
alias ldir="exa -l | egrep '^d'" # directories only

# Alias's for multiple directory listing commands
alias lsize='ls -lSrh --color=always --group-directories-first' # sort by size
alias ldate='ls -ltrh --color=always --group-directories-first' # sort by date
alias labc='ls -lap --color=always --group-directories-first' #alphabetical sort

# color
alias grep="grep --color=always"
alias ls='ls --color=auto'

# change shell
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

# error messages
alias error-report="journalctl -p 3 -xb"

# custom
alias find='find . | grep '
alias ps="ps aux | grep "
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"
alias checkcommand="type -t"
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"


### PROGRAMS.d
export QTWEBENGINE_CHROMIUM_FLAGS="--no-sandbox"	# Anki
eval "$(starship init bash)"				# Starship
#PS1='[\u@\h \W]\$'					# (Starship)Prompt

alias firefox='./programs/firefox/firefox'
alias suspend='systemctl suspend'
alias bat='batcat'
#. "$HOME/.cargo/env"



### Scrcpy (Android Screen)                                                                                       
alias pscreen='scrcpy --max-fps=30'


### PROXY COMMANDS
alias sshes='sshuttle --dns --to-ns=1.1.1.1 -r root@194.36.174.89 0/0 -x 194.36.174.89 --no-latency-control'
alias v2oxy='sudo ~/programs/nekoray/nekoray_core run --config=config.json -format=json'
alias v2oxy2='sudo ~/programs/nekoray/nekoray_core run -config=http.json -format=json'

