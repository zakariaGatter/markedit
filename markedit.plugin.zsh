# Zakaria [Gatter] Barkouk
# For more script and linux tools please visit "https://www.github.com/zakariaGatter"

# # # # Color # # # #
BRed='\e[1;31m'     #
BGreen='\e[1;32m'   #
BYellow='\e[1;33m'  #
BBlue='\e[1;34m'    #
BWhite='\e[1;37m'   #
# # # # # # # # # # #
Off='\e[0m'         #
# # # # # # # # # # #

#----------------------#
# Set Config File NAME #
#----------------------#
[ -z "$MARKEDIT_FILE" ] && export MARKEDIT_FILE="mark_edit"

#-----------------#
# Set Config File #
#-----------------#
export _MARKEDIT_FILE="$HOME/.$MARKEDIT_FILE"

#----------------------------#
# Check if the File is Exict #
#----------------------------#
[ ! -e "$_MARKEDIT_FILE" ] && touch "$_MARKEDIT_FILE"

#---------------#
# MARK EDIT ADD #
#---------------#
function editadd () {
    # Check if there is to many argulent
    [ "$#" -gt "3" ] && echo -e "${BYellow} ==>${BWhite} MARK_EDIT : To Many Argument ${Off}" && return
    [ "$#" -lt "2" ] && echo -e "${BYellow} ==>${BWhite} MARK_EDIT : Please set the mark and the file name ${Off}" && return

if [ "$1" = "sudo" ];then 
    S_add_chack=$(cat "$_MARKEDIT_FILE" | grep -w "^$2" | cut -d "=" -f2)

    # Check if the file argument Empty
    if [ -n "$2" ] && [ -z "$3" ];then
        echo -e "${BYellow} ==>${BWhite} MARK_EDIT : No File Set ${Off}" && return
    # Check if the Name is Already Exict
    elif [ "$2" = "$S_add_check" ];then
        echo -e "${BBlue} ==>${BWhite} MARK_EDIT : [${BRed}${1}${BWhite}] is Already Exict ${Off}" && return
    # Check if the File is Exict
    elif [ -f "$3" ];then
        echo -e "sudo=${2}=${3}" >> "$_MARKEDIT_FILE"
        echo -e "${BBlue} -->${BWhite} MARK_EDIT : [${BGreen}${2}${BWhite}] Saved ${Off}" && return
    else
        # Is the File Deosn't Exict Echo This
        echo -e "${BYellow} ==>${BWhite} MARK_EDIT : [${BRed}${3}${BWhite}] This File Deosn't Exict ${Off}" && return
    fi

else
    # Locate your Add name
    Add_check=$(cat "$_MARKEDIT_FILE" | grep -w "$1" | cut -d "=" -f1)

    # Check if the file argument Empty
    if [ -n "$1" ] && [ -z "$2" ];then
        echo -e "${BYellow} ==>${BWhite} MARK_EDIT : No File Set ${Off}" && return
    # Check if the Name is Already Exict
    elif [ "$1" = "$Add_check" ];then
        echo -e "${BBlue} ==>${BWhite} MARK_EDIT : [${BRed}${1}${BWhite}] is Already Exict ${Off}" && return

    # Check if the File is Exict
    elif [ -f "$2" ];then
        echo -e "${1}=${2}" >> "$_MARKEDIT_FILE"
        echo -e "${BBlue} -->${BWhite} MARK_EDIT : [${BGreen}${1}${BWhite}] Saved ${Off}" && return
    else
        # Is the File Deosn't Exict Echo This
        echo -e "${BYellow} ==>${BWhite} MARK_EDIT : [${BRed}${2}${BWhite}] This File Deosn't Exict ${Off}" && return
    fi
fi
}

#------------------#
# MARK EDIT DELETE #
#------------------#
function editdel () {
    # check if there is to many argument
    [ "$#" -gt "1" ] && echo -e "${BYellow} ==>${BWhite} MARK_EDIT : To Many Argument ${Off}" && return
    [ "$#" -lt "1" ] && echo -e "${BYellow} ==>${BWhite} MARK_EDIT : Please set the mark name ${Off}" && return
    
    # If the first Argument non Empty
    if [ -n "$1" ];then
        # check if the name is exict
        Del_check=$(cat "$_MARKEDIT_FILE" | grep -w "$1" | cut -d "=" -f1)
        S_del_check=$(cat "$_MARKEDIT_FILE" | grep -w "$1" | cut -d "=" -f2)
        # if the name exict do this
        if [ "$1" = "$Del_check" ];then
            sed -i "/${1}/d" "$_MARKEDIT_FILE"
            sed -i '/^$/d' "$_MARKEDIT_FILE"
            echo -e "${BBlue} -->${BWhite} MARK_EDIT : [${BGreen}${1}${BWhite}] Deleted ${Off}"
        elif [ "$1" = "$S_del_check" ];then 
            sed -i "/^sudo=${1}*/d" "$_MARKEDIT_FILE"
            sed -i '/^$/d' "$_MARKEDIT_FILE"
            echo -e "${BBlue} -->${BWhite} MARK_EDIT : [${BGreen}${1}${BWhite}] Deleted ${Off}"
        else
            # if the name dosen't exict do this
            echo -e "${BYellow} ==>${BWhite} MARK_EDIT : [${BRed}${1}${BWhite}] Deosn't Exict ${Off}"
        fi
    else
        # if the argument are empty
        echo -e "${BYellow} ==>${BWhite} MARK_EDIT : Type The Mark You Want to Delete ${Off}"
    fi

}

#-----------#
# MARK Edit #
#-----------#
function editmark () {
    # check if there is to many argument
    [ "$#" -gt "1" ] && echo -e "${BYellow} ==>${BWhite} MARK_EDIT : To Many Argument ${Off}" && return
    [ "$#" -lt "1" ] && echo -e "${BYellow} ==>${BWhite} MARK_EDIT : Please Set the mark name ${Off}" && return
    
    # if the first Argument not empty
    if [ -n "$1" ];then
        # check if the name exict
        Edit_check=$(cat "$_MARKEDIT_FILE" | grep -w "$1" | cut -d "=" -f1 )
        S_edit_check=$(cat "$_MARKEDIT_FILE" | grep -w "$1" | cut -d "=" -f2 )

        Edit_file=$(cat "$_MARKEDIT_FILE" | grep -w "$1" | cut -d "=" -f2 )
        S_edit_file=$(cat "$_MARKEDIT_FILE" | grep -w "$1" | cut -d "=" -f3 )
        # if exict edit it
        if [ "$1" = "$Edit_check" ];then
            $EDITOR $Edit_file
        elif [ "$1" = "$S_edit_check" ];then 
            sudo $EDITOR $S_edit_file
        else
            # echo this if not exict
            echo -e "${BYellow} ==>${BWhite} MARK_EDIT : [${BRed}${1}${BWhite}] Deosn't Exict ${Off}"
        fi
    else
        # check if argument is empty
        echo -e "${BYellow} ==>${BWhite} MARK_EDIT : Type the Mark you Want to Edit ${Off}"
    fi
}

#-----------#
# Mark Show #
#-----------#
function editshow () {
    # check if u have any mark
	Show_check=$(cat $_MARKEDIT_FILE | wc -l )
	
    # do this if u dont have no marks
	if [ "$Show_check" = "0" ];then
		echo -e "\n${BWhite} MARK_EDIT : "
		echo -e "${BBlue} -->${BWhite} No Mark Set ${Off}"
	else
        # if u have marks show them
		echo -e "\n${BBlue} -->${BWhite} MARK_EDIT : Show Mark's \n"
		cat $_MARKEDIT_FILE | sed -e "s:^sudo=:* :" | column -t -s =
        echo -e "${Off}"
	fi
}

#-----------------#
# Auto Completion #
#-----------------#
_completemarkedit() {
    if [[ $(cat "${_MARKEDIT_FILE}" | wc -l) -gt 0 ]];then 
        reply=($(cat $_MARKEDIT_FILE | sed -e "s:^sudo=::" | cut -d "=" -f1))
    fi
}

compctl -K _completemarkedit editdel
compctl -K _completemarkedit editmark
