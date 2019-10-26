#!/bin/zsh

#----------------------#
# MAKE EDIT CACHE FILE #
#----------------------#{{{
_me_cache_="$HOME/.cache/markedit"
# }}}

#--------------#
# HELP DIALOG  #
#--------------#{{{
_me_usage_(){
\cat <<- HELP
[MARKEDIT] Mark your file To easy Access

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
HELP
}
#}}}

#--------------#
# ADD NEW MARK #
#--------------#{{{
ea(){
local mark file root

[ "$#" -lt "2" -o "$#" -gt "3" ] && { _me_usage_; return; }

if [ "$1" = "_" ]; then
    root="$1" mark="$2" file="$3:P"
else
    mark="$1" file="$2:P"
fi

# check if the mark alredy exist
check=$(\awk -F ";" '/^'"$mark"' /' $_me_cache_ 2> /dev/null)

if [ -n "$check" ]; then
    echo -e "[X] $mark: mark already exist"
else
    test -f "$file"  || { echo -e "[X] $file: No such File" ; return 0 ;}

    if [ -n "$root" ]; then
		echo -e "[+] $mark: Added"
		echo "$mark ; $file ; root" >> $_me_cache_
    else
		echo -e "[+] $mark: Added"
		echo "$mark ; $file " >> $_me_cache_
    fi
fi
}
# }}}

#-------------#
# DELETE MARK #
#-------------#{{{
er(){
[ -z "$1" ] && { _me_usage_; return; }
local i check

for i in $@; do
    check=$(\awk -F ";" '/^'"$i"' /' $_me_cache_ 2> /dev/null)

    if [ -z "$check" ]; then
		echo -e "[X] $i: none exist mark"
    else
		sed -i "/^$i /d" $_me_cache_
		echo -e "[-] $i: Deleted "
    fi
done
}
# }}}

#--------------#
# JUMB TO MARK #
#--------------#{{{
em(){
[ -z "$1" -o "$#" -gt 1 ] && { _me_usage_; return; }
local mark

read -A mark < <(\awk -F ";" '/^'"$1"' /{print $1" "$2" "$3}' $_me_cache_ 2> /dev/null)

EDITOR=${EDITOR:-vim}

if [ -z "${mark[1]}" ]; then
    echo -e "[X] $1: none exist mark"
else
    if [ -n "${mark[3]}" ]; then
		if [ "$UID" -ne 0 ]; then
			echo -e "[X] $1: Permission denied"
			exit 1
		else
			eval "$EDITOR ${mark[2]}"
		fi
    else
		eval "$EDITOR ${mark[2]}"
    fi
fi
}
# }}}

#------------#
# SHOW MARKS #
#------------#{{{
es(){
if [ -z "$1" ]; then
    column -t -s ';' "$_me_cache_"
else
    for i in "$@"; do
		local check=$(\awk -F ";" '/^'"$i"' /{print $0}' $_me_cache_ 2> /dev/null)

		if [ -z "$check" ]; then
			echo -e "[X] $i: None exist Mark"
		else
			echo -e "$check" | column -t -s ';'
		fi
    done
fi
}
# }}}

#-------------#
# EDIT A MARK #
#-------------#{{{
ee(){
[ -z "$1" -o "$#" -gt 1 ] && { _me_usage_; return; }
local check=$(\awk -F ";" '/^'"$1"' /' $_me_cache_ 2> /dev/null)

if [ -z "$check" ]; then
    echo -e "[X] $1: None exist Mark"
else
    # delete the mark
    sed -i "/^$1 /d" $_me_cache_

    # edit the mark with zle
    vared check

    # rewrite the mark
    echo $check >> "$_me_cache_"
fi

}
# }}}

#---------------------------#
# AUTO COMPLITION  FOR ZSH  #
#---------------------------#{{{
function _complete_zsh {
    if [[ "$(wc -l < $_me_cache_)" -gt 0 ]];then
		reply=( $(\awk -F ';' '{print $1}' $_me_cache_) )
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
