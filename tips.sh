#!/bin/bash

set -o nounset
set -o errexit

#set -x

. ./libShell/echo_color.lib

get_resources_func()
{
    echoC "Yocto's ORG:"
    echo "https://www.yoctoproject.org/"
    echo ""
    echoC "Get Yocto release:"
    echo "http://downloads.yoctoproject.org/releases/"
    echo ""
}

tips_help_func()
{
    echoY "Usage: ./tips.sh <tips>"
    echoC "Supported tips:"
    echo '001) [ resource ] Tips for obtain resources of Yocto.'
}

[ $# -lt 1 ] && tips_help_func && exit

case $1 in
    "resource") echoY '001) [apt]            Tips for apt* commands.'
        get_resources_func
        ;;
    *) echo "Unknown command:"
        tips_help_func 
        ;;
esac


