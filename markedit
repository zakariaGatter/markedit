#!/bin/bash 

CONF_DIR="$HOME/.config"

FILE_GATE="$CONF_DIR/file-gate"

[ -f "$FILE_GATE" ] || touch $FILE_GATE

[ -z "$EDITOR" ] && EDITOR="vim"

F_G_VERSION_="20-05-2018"

F_G_USAGE () {
echo "
    MARK EDIT ($F_G_VERSION_)
    Written by Zakaria Barkouk (zakaria.gatter@gmail.com)

    Mark your file To easy Access

OPTS :       
        ea          Add Mark File
        er          Remove Mark File
        es          Show All Mark File's
        em          Edit Mark File 
        ee          change or Edit Exist Mark 

EXAMPLE :  
        ea bashrc ~/.bashrc     ( add 'bashrc' Mark with out sudo Permision )
        ea _ bashrc ~/.bashrc   ( add 'bashrc' Mark with sudo Permision )
        em bashrc               ( Edit to 'bashrc' Mark)
        er bashrc ...           ( Remove 'bashrc' Mark and suport multi Delete)
        ee bashrc               (Edit Exist mark like change the mark name or File) 

File    :   FILE_GATE=\"~/.config/file_gate\"
"
return 0
}

# Change or Edit Exist mark 
ee () {
    [ "$1" = "help" -o -z "$1" ] && { F_G_USAGE && return 0 }

_E_CHECK=$(grep -w --color=never "^$1" $FIlE_GATE)
_SE_CHECK=$(grep -w --color=never "^_$1" $FILE_GATE)

if [ -z "$E_CHECK" -a -z "$SE_CHECK" ]; then 
    echo "X - [ $1 ] dosen't Exist"
fi 

[ -n "$E_CHECK" ] && {
    echo "$_E_CHECK" > /tmp/file_edit
    
    bash -c "$EDITOR /tmp/file_edit"

    sed -i "s:$_E_CHECK::g" $FILE_GATE

    cat /tmp/file_edit >> $FILE_GATE
}

[ -n "$_SE_CHECK" ] && {
    echo "$_SE_CHECK" > /tmp/dir_edit
    
    bash -c "$EDITOR /tmp/file_edit"

    sed -i "s:$_SE_CHECK::g" $FILE_GATE

    cat /tmp/file_edit >> $FILE_GATE
}

unset _SE_CHECK _E_CHECK 
}

#Add new mark 
ea () {
[ "$1" = "help" -o -z "$1" ] && { F_G_USAGE && return 1 }
[ "$#" -lt "2" ] && { echo " $0 : no enough argument " && return 1}

[ "$1" = "_" ] && {
    _S_CHECK_=$(grep -w --color=never "^_$2" $FILE_GATE)

    [ -n "$_S_CHECK_" ] && {
        echo "X - [ $2 ] Already Exist "
        return 1
    } || {
        [ -f "$3" ] && {
            echo "_$2 = $3" >> $FILE_GATE
            echo "[ $2 ] Added "
        } || {
            echo "X - [ $(basename $3) ] : Invalid or None Exist File "
            return 1
        }
    }
} || {
    _CHECK_=$(grep -w --color=never "^$1" $FILE_GATE)
    
    [ -n "$_CHECK_" ] && {
        echo "X - [ $1 ] Already Exist "
        return 1
    }||{
        [ -f "$2" ] && {
            echo "$1 = $2" >> $FILE_GATE
            echo "[ $1 ] Added"
        } ||{
            echo "X - [ $(basename $2) ] : Invalid or None Exist File "
            return 1
        }
    }
}

unset _CHECK_ _S_CHECK_
}

#remove mark 
er (){
[ "$1" = "help" ] && { F_G_USAGE && return 1 }

D_DEP=0

for E in ${@} ; do 
    _SD_CHECK_=$(grep -w --color=never "^_$E" $FILE_GATE)
    _D_CHECK_=$(grep -w --color=never "^$E" $FILE_GATE)

    [ -z "$_SD_CHECK_"  -a -z "$_D_CHECK_" ] && {
        echo "X - [ $E ] Deosn't Exist "
        D_DEP=$(( $D_DEP + 1 ))
    } || {
        sed -i "/_$E = */d" $FILE_GATE
        sed -i "/$E = */d" $FILE_GATE
        echo "[ $E ] Deleted "
    }
done 

[ "$D_DEP" -eq 0 ] || return 1

unset D_DEP _SD_CHECK_ _D_CHECK_
}

#show marks 
es () {
[ "$1" = "help" ] && { F_G_USAGE && return 1 }
echo "Mark Edit :"
cat $FILE_GATE | column -t | sort -u
}

#edit mark 
em () {
_SE_CHECK_=$(grep -w --color=never "^_$1" $FILE_GATE)
_E_CHECK_=$(grep -w --color=never "^$1" $FILE_GATE)

[ -z "$_SE_CHECK_" -a -z "$_E_CHECK_" ] && {
    echo "X - [ $1 ] Deosn't Exist "
    return 1
}

[ -n "$_E_CHECK_" ] && {
    E_FILE=$(echo "$_E_CHECK_" | cut -d= -f2-)

    bash -c "$EDITOR $E_FILE"
}

[ -n "$_SE_CHECK_" ] && {
    SE_FILE=$(echo "$_SE_CHECK_" | cut -d= -f2-)

    bash -c "sudo $EDITOR $SE_FILE"
}

unset _SE_CHECK_ _E_CHECK_
}

# AUTO COMPLITION  for zsh 
function F_G_complete_zsh {
    if [[ "$(cat "${FILE_GATE}" | wc -l)" -gt 0 ]];then 
	reply=($(cut -d= -f1 $FILE_GATE | sed -e "s:_::g"))
    fi
}

# Auto completion for bash 
function F_G_complete_bash {
    local curw
    COMPREPLY=()
    curw=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=($(compgen -W "$(cut -d= -f1 $FILE_GATE | sed -e "s:_::g")" -- $curw))
    return 0
}

#exec the completion 
if [ $ZSH_VERSION ]; then
    compctl -K F_G_complete_zsh em
    compctl -K F_G_complete_zsh er
    compctl -K F_G_complete_zsh ee
else
    shopt -s progcomp
    complete -F F_G_complete_bash em
    complete -F F_G_complete_bash er
    complete -F F_G_complete_bash ee
fi
