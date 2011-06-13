export HISTCONTROL=ignoredups
export HISTSIZE=100000
export HISTFILESIZE=100000

#http://forums.macosxhints.com/showthread.php?t=82501
# see mail control leopard
# for ctrl-o working:q
stty discard '^-'

alias imag-portforwarding='ssh -N -f -Y -L2525:mail2-id.imag.fr:25  claferri@navajo.imag.fr sleep 60 >& /dev/null'

if [ -f /opt/local/etc/bash_completion ]; then
  . /opt/local/etc/bash_completion
fi

export PATH=~/bin:$PATH
export MANPATH=~/man/:/opt/local/share/man:$MANPATH

##
# DELUXE-USR-LOCAL-BIN-INSERT
# (do not remove this comment)
##
echo $PATH | grep -q -s "/usr/local/bin"
if [ $? -eq 1 ] ; then
    PATH=$PATH:/usr/local/bin
    export PATH
fi

##
# Your previous /Volumes/Data/claferri/.profile file was backed up as /Volumes/Data/claferri/.profile.macports-saved_2009-09-15_at_14:32:57
##

# MacPorts Installer addition on 2009-09-15_at_14:32:57: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


if [ "$PS1" != "" ]
then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
	PS2='Prog. level: '

	export HOSTNAME=`hostname`
	export WHOAMI=`whoami`
	export LC_TYPE=iso_8859_1
	
	TERMINAL=`tty`
	ignoreeof=4
	MAILCHECK=60

    	# enable color support of ls and also add handy aliases
    	if [ "$TERM" != "dumb" ] && [ "$HOSTNAME" != "graup" ]; then
          eval `gdircolors -b`
          alias bash_config='vim ~/.bashrc'
          alias rm='grm'
	  alias startx='ssh-agent startx'
          alias ls='gls --color=auto --group-directories-first'
	  alias pd='pushd'
	  #alias vim='gvim'
          alias dir='ls --color=auto --format=vertical'
          alias vdir='ls --color=auto --format=long'
	  alias l='ls -CF --group-directories-first'
	  alias la='ls -a --group-directories-first'
	  alias ll='ls -l --group-directories-first'
	  alias m=more
	  alias d='display'
	  alias grep='grep --exclude=TAGS --exclude=tags --exclude=*~ --exclude=*svn-base --color -n'
	  alias ssh='ssh -A'
          alias ssh='ssh'
          alias aptud='sudo aptitude update'
          alias aptug='sudo aptitude upgrade'
          alias apts='sudo aptitude search'
          alias apti='sudo aptitude install'
          alias mount='sudo mount'
	fi

	clean()
	{
		rm -f \#* .*~ *~
		rm -f core*
	}

	display ()
	{
        	if [ $# -eq 1 ]
        	then
                	export DISPLAY=$1":0.0" 
        	else
                	echo "usage: display nom-de-terminal"
        	fi
	}
fi

    	# enable programmable completion features (you don't need to enable
    	# this, if it's already enabled in /etc/bash.bashrc).
    	if [ -f /etc/bash_completion ]; then
    	  . /etc/bash_completion
    	fi

if [ "$TERM" != "linux" ] && [ "$TERM" != "sun" ] && [ "$TERM" != "vt220" ];then
    PROMPT_COMMAND='echo -ne "\033]0;${WHOAMI}@${HOSTNAME}: ${PWD}\007"'
    export PROMPT_COMMAND
fi 
ignoreeof=1

export LS_COLORS="no=00:fi=00:di=00;33:ln=00;36:pi=40;33:so=00;35:do=00;35:bd=40;33;00:cd=40;33;00:or=40;31;00:ex=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.deb=00;31:*.rpm=00;31:*.jar=00;31:*.jpg=00;35:*.jpeg=00;35:*.gif=00;35:*.bmp=00;35:*.pbm=00;35:*.pgm=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.tiff=00;35:*.png=00;35:*.mov=00;35:*.mpg=00;35:*.mpeg=00;35:*.avi=00;35:*.fli=00;35:*.gl=00;35:*.dl=00;35:*.xcf=00;35:*.xwd=00;35:*.ogg=00;35:*.mp3=00;35:*.wav=00;35:"

#####################
# PROMPT COLORATION #
#####################

export NONE="\[\033[0m\]"    # unsets color to term's fg color
  
# regular colors
export K="\[\033[0;30m\]"    # black
export R="\[\033[0;31m\]"    # red
export G="\[\033[0;32m\]"    # green
export Y="\[\033[0;33m\]"    # yellow
export B="\[\033[0;34m\]"    # blue
export M="\[\033[0;35m\]"    # magenta
export C="\[\033[0;36m\]"    # cyan
export W="\[\033[0;37m\]"    # white
				        
# emphasized (bolded) colors
export EMK="\[\033[1;30m\]"
export EMR="\[\033[1;31m\]"
export EMG="\[\033[1;32m\]"
export EMY="\[\033[1;33m\]"
export EMB="\[\033[1;34m\]"
export EMM="\[\033[1;35m\]"
export EMC="\[\033[1;36m\]"
export EMW="\[\033[1;37m\]"


export PS1="${C}\!-\#(\j)${NONE} \u@${G}\H${NONE}:\w \n${R}\$>${NONE} "


