#!/bin/bash

set -o nounset
set -o errexit

#set -x

. ./libShell/echo_color.lib

show_toaster_usage_func()
{
    echoG "Setup running environment:"
    echo "$ sudo apt-get install python3-pip"
    echo "$ pip3 install --user -r /opt/yocto/poky/bitbake/toaster-requirements.txt"
    echo ""
    echoG "How to start Toaster:"
    echo "$ cd /opt/yocto/poky"
    echo "$ source oe-init-build-env"
    echo "$ source toaster start"
    echo "or"
    echo "source toaster start webport=<IP>:<PORT>"
    echo ""
    echoG "How to stop  Toaster:"
    echo "source toaster stop"
    echo ""
    echoG "The version of Django that Toaster uses is specified on:"
    echo "/opt/yocto/poky/bitbake/toaster-requirements.txt"
    echo ""
    echoG "The backend configuration is done in:"
    echo "/opt/yocto/poky/bitbake/lib/toaster/toastermain/settings.py"
    echo ""
    echoG "The initial state of the database is created from a set of fixtures (data dumps) under:"
    echo "/opt/yocto/poky/bitbake/lib/toaster/orm/fixtures"
    echo ""
}

show_reop_usage_func()
{
    echoG "Instructions to use the repo tool:"
    echo "    Including using repo with proxy servers, can be 
    found in the Android documentation at:"
    echo "    https://source.android.com/setup/downloading"
    echo ""

}

bitbake_working_flow_parsing_func()
{
    echoC 'Parsing flow of bitbake:'
    echoG "(1) Configuration:"
    echo "    bblayers.conf"
    echo "        conf/layer.conf"
    echo "            meta/conf/bitbake.conf"
    echo "                conf/site.conf, conf/auto.conf, conf/local.conf"
    echo "                    conf/machine/machine.conf"
    echo "                        conf/distro/distro.conf"
    echoG "(2) Metadata:"
    echo "    Recipes"
    echo "        .bb"
    echo "        .bbappend"
}

bitbake_working_flow_cooking_func()
{
    echoC 'Cooking flow of bitbake:'
    echoG "(1) Build:"
    echo "    Fetch"
    echo "        Patch"
    echo "            Configure"
    echo "                Compile" 
    echoG "(2) Package:"
    echo "    RPM    IPK    DEB"
    echo "    QUAULITY ASSURANCE"
    echo "    TARGET IMAGES && SDK"
}

bitbake_working_flow_func()
{
    bitbake_working_flow_parsing_func
    bitbake_working_flow_cooking_func
}

show_fsl_layers_info_func()
{
    echoG "meta-freescale:"
    echo "    This is the community layer that supports NXP reference 
    designs. It has a dependency on OpenEmbedded-Core. Machines in this layer 
    will be maintained even after NXP stops active development on them. You can 
    download meta-freescale from its Git repository at 
    http://git.yoctoproject.org/cgit/cgit.cgi/meta-freescale/.
    
    The meta-freescale layer provides both the i.MX6 Linux kernel and the U-Boot 
    source either from NXP's or from FSL community BSP maintained repositories 
    using the following links: 
        NXP's Linux kernel Git repository: 
        http://git.freescale.com/git/cgit.cgi/imx/linux-imx.git/ 
        FSL community Linux kernel Git 
        repository: https://github.com/Freescale/linux-fslc.git 
        NXP's U-Boot Git repository: 
        http://git.freescale.com/git/cgit.cgi/imx/uboot-imx.git/ 
        FSL community U-Boot Git 
        repository: https://github.com/Freescale/u-boot-fslc.git"
    echo ""

    echoG "meta-freescale-3rdparty:"
    echo "    This layer adds support for other communitymaintained boards, 
    for example, the Wandboard. To download the layer's 
    content, you may visit: 
    https://github.com/Freescale/meta-freescale-3rdparty/."
    echo ""

    echoG "meta-freescale-distro:"
    echo "    This layer adds a metadata layer for demonstration 
    target images. To download the layer's content, you may visit:
    https://github.com/Freescale/meta-freescale-distro."
    echo ""

    echoG "meta-fsl-bsp-release:"
    echo "    This is an NXP-maintained layer that is used in the 
    official NXP software releases. It contains modifications to 
    both meta-freescale and meta-freescale-distro. It is not part of 
    the community release but can be accessed at: 
    http://git.freescale.com/git/cgit.cgi/imx/meta-fsl-bsp-release.git/."
    echo ""

    echoG "See also:"
    echo "    For more information, refer to the FSL community BSP 
    web page available at:
    http://freescale.github.io/ 
    NXP's official support community can be accessed at:
    https://community.nxp.com/"
    echo ""

}

show_fsl_yocto_info_func()
{
    echoG "To list the hardware boards supported by the different layers, we may run:"
    echo "    $ ls sources/meta-freescale*/conf/machine/*.conf"
    echo ""
    echoG "And to list the newly introduced target images, use the following:"
    echo "    $ ls sources/meta-freescale*/recipes*/images/*.bb"
    echo "    $ ll sources/meta-fsl-bsp-release/imx/meta-sdk/recipes-*/images/*.bb"
    echo ""
}

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
    echo "http://www.yoctoproject.org/docs/"
    echo ""
    echoC "Get layers for Yocto project:"
    echo "http://layers.openembedded.org/"
    echo ""
    echoC 'Get freescale community layer "meta-freescale":'
    echo 'http://git.yoctoproject.org/cgit/cgit.cgi/meta-freescale/'
    echo ""
    echoC 'Discussion on freescale community layer "meta-freescale":'
    echo 'https://lists.yoctoproject.org/listinfo/meta-freescale'
    echo ""
    echoC 'Get Linux kernel and U-boot in freescale community layer "meta-freescale":'
    echo "    The meta-freescale layer provides both the i.MX6 Linux kernel and the U-Boot
    source either from NXP's or from FSL community BSP maintained repositories
    using the following links:"
    echoG "    NXP's Linux kernel Git repository:"
    echo "    http://git.freescale.com/git/cgit.cgi/imx/linux-imx.git/"
    echoG "    FSL community Linux kernel Git:"
    echo "    repository: https://github.com/Freescale/linux-fslc.git"
    echoG "    NXP's U-Boot Git repository:"
    echo "    http://git.freescale.com/git/cgit.cgi/imx/uboot-imx.git/"
    echoG "    FSL community U-Boot Git:"
    echo "    repository: https://github.com/Freescale/u-boot-fslc.git"
    echo ""
    echoC 'Get freescale support layer(meta-freescale-3rdparty) for other community maintained boards:'
    echo 'https://github.com/Freescale/meta-freescale-3rdparty/'
    echo ""
    echoC "Get freescale demonstration images' layer(meta-freescale-distro):"
    echo 'https://github.com/Freescale/meta-freescale-distro'
    echo ""
    echoC "Get release layer(meta-fsl-bsp-release) that is used in the official NXP software releases:"
    echo 'http://git.freescale.com/git/cgit.cgi/imx/meta-fsl-bsp-release.git/'
    echo ""
    echoC "FSL community BSP web page:"
    echo 'http://freescale.github.io/'
    echo ""
    echoC "NXP's official support community:"
    echo 'https://community.nxp.com/'
    echo ""
    echoC "The FSL community BSP manifest can be accessed at:"
    echo "https://github.com/Freescale/fsl-community-bsp-platform/blob/rocko/default.xml"
    echo ""

}

setup_build_func()
{
    echoC "Setup Poky build directory:"
    echo '$ cd <Poky directory>'
    echo '$ source oe-init-build-env <build directory>'
    echo ""
    echoC "Start a build from scratch:"
    echo '$ cd <build directory>'
    echo '$ rm -Rf tmp sstate-cache'
    echo ""
    echoC 'Review the template configuration file that uses for creating the current build directory:'
    echo 'cat <build directory>/conf/templateconf.cfg'
    echo ""
    echoC "Specify different template configuration files to use for creating build directory:"
    echo 'TEMPLATECONF=meta-custom/config source oe-init-build-env <build-dir>'
    echo ""
    echoC "List all Poky default target images:"
    echo '$ cd <Poky directory>'
    echo '$ ls meta*/recipes*/images/*.bb'
    echo ""
    echoC "Specify MACHINE for an already configured project:"
    echo 'Change the variable MACHINE in <build directory>/conf/local.conf'
    echo ""
    echoC "Disable the -dbg packages that include debug symbols are not needed:"
    echo 'Make INHIBIT_PACKAGE_DEBUG_SPLIT = "1" in <build directory>/conf/local.conf'
    echo ""
    echoC "Test run your images on the QEMU emulator:"
    echo 'runqemu qemuarm core-image-minimal'
    echo ""
    echoC "Clean/Rebuild target:"
    echo "bitbake -f -c compile <target>"
    echo "bitbake <target>"
    echo ""
    echoC "Build the release notes in both HTML and PDF versions we do:"
    echo "$ cd /opt/yocto/fsl-community-bsp/sources/Documentation/release-notes"
    echo "$ make latexpdf singlehtml"
    echoY "Note: The documents can be found inside the build/latex and build/singlehtml directories."
    echo ""
}

tips_help_func()
{
    echoY "Usage: ./tips.sh <tips>"
    echoC "Supported tips:"
    echo '001) [ resource ]        Tips for obtain resources of Yocto.'
    echo '002) [ build ]           Tips for setup build environment.'
    echo '003) [ bbWorkFlow ]      Tips for show working flow of bitbake.'
    echo '004) [ fslLayers ]       Tips for show informations of the layers that FSL community BSP extends Poky with .'
    echo '005) [ fslInfo ]         Tips for show informations of current fsl Yocto project.'
    echo '006) [ repo ]            Tips for repo usage.'
    echo '007) [ toaster ]         Tips for toaster usage.'
}

[ $# -lt 1 ] && tips_help_func && exit

case $1 in
    "resource") echoY '001) [ resource ] Tips for obtain resources of Yocto.'
        get_resources_func
        ;;
    "build") echoY '002) [ build ] Tips for setup build environment.'
        setup_build_func
        ;;
    "bbWorkFlow") echoY '003) [ bbWorkFlow ]      Tips for show working flow of bitbake.'
        bitbake_working_flow_func
        ;;
    "fslLayers") echoY '004) [ fslLayers ]       Tips for show informations of the layers that FSL community BSP extends Poky with .'
        show_fsl_layers_info_func
        ;;
    "fslInfo") echoY '005) [ fslInfo ]         Tips for show informations of current fsl Yocto project.'
        show_fsl_yocto_info_func
        ;;
    "repo") echoY '006) [ repo ]            Tips for repo usage.'
        show_reop_usage_func
        ;;
    "toaster") echoY '007) [ toaster ]         Tips for toaster usage.'
        show_toaster_usage_func
        ;;
    *) echo "Unknown command:"
        tips_help_func 
        ;;
esac


