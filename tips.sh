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
    echoC "Get Yocto cookbook 2nd codes:"
    echo "https://github.com/PacktPublishing/Embedded-Linux-Development-Using-Yocto-Proje
ct-Cookbook-Second-Edition"
    echo "https://github.com/PacktPublishing/"
    echo "https://github.com/yoctocookbook2ndedition"
    echo ""
    echoC "Get poky:"
    echo "http://git.yoctoproject.org/cgit/cgit.cgi/poky/"
    echo ""
    echoC "Get bitbake:"
    echo "http://git.openembedded.org/bitbake/"
    echo ""
    echoC "Get OpenEmbedded-core metadata:"
    echo "http://git.openembedded.org/openembedded-core/"
    echo ""
    echoC "Get official Yocto Project documentation:"
    echo " http://www.yoctoproject.org/docs/"
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


