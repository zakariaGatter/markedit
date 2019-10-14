#!/bin/zsh

#----------------------#
# MAKE EDIT CACHE FILE #
#----------------------#{{{
MARKEDIT_CACHE="$HOME/.cache/markedit.cache"
# }}}

#--------------#
# HELP DIALOG  #
#--------------#{{{
_usage_(){
echo -e "
MARK EDIT
Written by Zakaria Barkouk (zakaria.gatter@gmail.com)

Mark your file To easy Access

OPTS :
    ea          Add Mark File
    er          Remove Mark File
    es          Show All Mark File's
    em          Edit Mark File
    ee          change or Edit Exist Mark

EXAMPLE :
    ea bashrc ~/.bashrc     ( add 'bashrc' Mark with out sudo Permission )
    ea _ bashrc ~/.bashrc   ( add 'bashrc' Mark with sudo Permission )
    em bashrc               ( Edit 'bashrc' Mark )
    sudo em bashrc 			( Edit 'bashrc' Mark with sudo )
    er bashrc ...           ( Remove 'bashrc' Mark and support multi Delete )
    ee bashrc               (Edit Exist mark like change the mark name or File )
"
}
#}}}

#--------------#
# ADD NEW MARK #
#--------------#{{{
ea(){
local mark file root

[ "$#" -lt "2" -o "$#" -gt "3" ] && { _usage_; return; }

if [ "$1" = "_" ]; then
    root="$1"
    mark="$2"
    file="$3:P"
else
    mark="$1"
    file="$2:P"
fi

# check if the mark alredy exist
check=$(awk -F ";" '/^'"$mark"' /{print $1}' "$MARKEDIT_CACHE")

if [ -n "$check" ]; then
    echo -e "[X] - $mark mark already exist"
else
    test -f "$file"  || { echo -e "[X] - $file No such File" ; return 0 ; }

    if [ -n "$root" ]; then
		echo -e "[+] - $mark Added"
		echo "$mark ; $file ; root" >> "$MARKEDIT_CACHE"
    else
		echo -e "[+] - $mark Added"
		echo "$mark ; $file " >> "$MARKEDIT_CACHE"
    fi
fi
}
# }}}

#-------------#
# DELETE MARK #
#-------------#{{{
er(){
[ -z "$1" ] && { _usage_; return; }
local i check

for i in "$@"; do
    check=$(awk -F ";" '/^'"$i"' /{print $1}' "$MARKEDIT_CACHE")

    if [ -z "$check" ]; then
		echo -e "[X] - $i none exist mark"
    else
		sed -i "/^$i /d" $MARKEDIT_CACHE
		echo -e "[-] - $i Deleted "
    fi
done
}
# }}}

#--------------#
# JUMB TO MARK #
#--------------#{{{
em(){
[ -z "$1" -o "$#" -gt 1 ] && { _usage_; return; }
local mark file root check

mark="$1"
check=$(awk -F ";" '/^'"$1"' /{print $1}' "$MARKEDIT_CACHE")
file=$(awk -F ";" '/^'"$1"' /{print $2}' "$MARKEDIT_CACHE")
root=$(awk -F ";" '/^'"$1"' /{print $3}' "$MARKEDIT_CACHE")

EDITOR=${EDITOR:-vim}

if [ -z "$check" ]; then
    echo -e "[X] - $mark none exist mark"
else
    if [ -n "$root" ]; then
		if [ "$UID" -n 0 ]; then
			echo -e "[X] - $mark Permission denied"
			exit 1
		else
			eval "$EDITOR $file"
		fi
    else
		eval "$EDITOR $file"
    fi
fi
}
# }}}

#------------#
# SHOW MARKS #
#------------#{{{
es(){
local check

if [ -z "$1" ]; then
    column -t -s ';' "$MARKEDIT_CACHE"
else
    for i in "$@"; do
		check=$(awk -F ";" '/^'"$i"' /{print $0}' "$MARKEDIT_CACHE")

		if [ -z "$check" ]; then
			echo -e "[X] - $i None exist Mark"
		else
			echo -e "$check" | column -t -s ';'
		fi
    done
fi
}# }}}

#-------------#
# EDIT A MARK #
#-------------#{{{
ee(){
[ -z "$1" -o "$#" -gt 1 ] && { _usage_; return; }
local check

check=$(awk -F ";" '/^'"$1"' /{print $0}' "$MARKEDIT_CACHE")

if [ -z "$check" ]; then
    echo -e "[X] - $1 None exist Mark"
else
    # delete the mark
    sed -i "/$check/d" $MARKGATE_CACHE

    # edit the mark with zle
    vared check

    # rewrite the mark
    echo $check >> "$MARKEDIT_CACHE"
fi

}
# }}}

#---------------------------#
# AUTO COMPLITION  FOR ZSH  #
#---------------------------#{{{
function _complete_zsh {
    if [[ "$(grep -c ".*" $MARKEDIT_CACHE)" -gt 0 ]];then
		reply=($(awk -F ';' '{print $1" -- "$2}' "$MARKEDIT_CACHE"))
    fi
}
# }}}

#----------------------#
# EXEC THE COMPLETION  #
#----------------------#{{{
compctl -K _complete_zsh em
compctl -K _complete_zsh er
compctl -K _complete_zsh ee
compctl -K _complete_zsh es
#}}}

# vim: ft=sh
