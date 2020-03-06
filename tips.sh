#!/bin/bash

set -o nounset
set -o errexit

#set -x

. ./libShell/echo_color.lib

show_bsp_layer_func()
{
    echoG "Create a custom bsp layer:"
    echo '$cd <fsl-community-bsp directory>'
    echo '$source setup-environment <reference boards. eg: wandboard>'
    echo '$cd <fsl-community-bsp directory>/source'
    echo 'yocto-layer create <bsp-custom>'
    echo 'or'
    echo 'yocto-layer create meta-bsp-<bsp-custom>'
    echo ""
}

show_debug_func()
{
    echoG 'Search for specific recipes on the configured layers, 
    with the preferred version appearing first:'
    echo '$ bitbake-layers show-recipes "<package_name>"'
    echo ""
    echoG 'Search on recipe or package names, description and install files 
    in the context of developing recipes metadata with regular expression 
    in dependency cache:'
    echo '$ devtool search <regular expression>'
    echoY "To use devtool, the environment needs to be previously set up, 
    and the shared state cache populated:"
    echo "$ cd /opt/yocto/fsl-community-bsp"
    echo "$ source setup-environment wandboard"
    echo "$ bitbake <target-image>"
    echo "$ devtool search gdb 
    Loaded 2323 entries from dependency cache. 
    perl Perl scripting language 
    shared-mime-info Shared MIME type database and specification 
    bash-completion Programmable Completion for Bash 4 
    glib-2.0 A general-purpose utility library 
    python The Python Programming Language 
    gdbm Key/value database library with extensible hashing 
    gcc-runtime Runtime libraries from GCC"
    echo ""
    echoG "Dumpping BitBake's the global environment:"
    echo "$ bitbake -e | grep -w <key word>"
    echo ""
    echoG "To locate the source directory for a specific package recipe use:"
    echo "$ bitbake -e <name of package recipe> | grep ^S="
    echo ""
    echoG "To locate the working directory for a package or image recipe:"
    echo "$ bitbake -e <target> | grep ^WORKDIR="
    echo ""
    echoG "Start development shell:"
    echo "$ bitbake -c devshell <target>"
    echo "or"
    echo "$ bitbake -c devpyshell <target>"
    echo ""
    echoG "To list all the tasks available for a given recipe:"
    echo '$ bitbake -c listtasks <target>'
    echo ""
    echoG "To recreate the error, you can force a build with the following:"
    echo "$ bitbake -f <target>"
    echo ""
    echoG "Ask BitBake to force-run only a specific task:"
    echo '$ bitbake -c <task> -f <target>'
    echo "eg:"
    echo '$ bitbake -c compile -f <target>'
    echo ""
    echoG "Ask BitBake to clean a specific recipe:"
    echo '$ bitbake -c clean <target>'
    echo ""
    echoG "Print the current and provided versions of packages:"
    echo "$ bitbake --show-versions"
    echo ""
    echoG "To see an overview of pulled-in dependencies:"
    echo "$ bitbake -v <target>"
    echo ""
    echoG "To analyze what dependencies are pulled in by a package:"
    echo "$ bitbake -g <target>"
    echo "To omit dependencies from glibc:"
    echo "$ bitbake -g <target> -I glibc"
    echoY "Once the preceding commands have been run, 
    we get the following files in the current directory:"
    echo "    pn-buildlist: This file shows the list of packages that would be built by the given target 
    recipes-depends.dot: This file shows the dependencies between recipes 
    task-depends.dot: This file shows the dependencies between tasks"
    echo ""
    echoG "To convert the .dot files to postscript files (.ps):"
    echo "$ dot -Tps filename.dot -o outfile.ps"
    echo ""
    echoG "To convert the .dot files to png files:"
    echo "$ dot -Tpng filename.dot -o outfile.png"
    echo ""
    echoG "Ask BitBake to display it graphically with the dependency explorer:"
    echo "$ bitbake -g -u taskexp <target>"
    echo ""
    echoG "To check errors from the community itself:"
    echo "http://errors.yoctoproject.org"
    echo ""
    echoG "Submit your own build failure to the database to help the community debug the problem.
    To do so, you may use the report-error class. Add the following to your conf/local.conf file:"
    echo 'INHERIT += "report-error"'
    echoY "Note: The error information is stored under tmp/log/error-report under the build
    directory, but you can set a specific location with the ERR_REPORT_DIR variable.
    When the error reporting tool is activated, a build error will be captured in a file in the
    error-report folder. The build output will also print a command to send the error log to
    the server:"
    echo '$ send-error-report ${LOG_DIR}/error-report/error-report_${TSTAMP}'
    echoY "When this command is executed, it will report back with a link to the upstream error."
    echo ""
}

show_yocto_config_func()
{
    echoG "Check pocky version of current Yocto Project."
    echo "Value DISTRO_CODENAME in /<BSP-DIR>/sources/poky/meta-yocto/conf/distro/poky.conf"
    echo ""
    echoG 'Configure a pre-mirror:'
    echo 'For example, add the following to your conf/local.conf file:'
    echo 'INHERIT += "own-mirrors"'
    echo 'SOURCE_MIRROR_URL = "http://example.com/my-source-mirror"'
    echo ""
    echoG "Configure the build server to prepare tarballs of the Git 
    directories to avoid having to perform Git operations from upstream servers:"
    echo 'BB_GENERATE_MIRROR_TARBALLS = "1"'
    echoY 'Note:This setting in your conf/local.conf file will affect the build performance,
    but this is usually acceptable in a build server.'
    echoY 'Note:In order to test this setup, you may check to see whether a build is 
    possible just by using the pre-mirrors with the following:'
    echo 'BB_FETCH_PREMIRRORONLY = "1"'
    echo ""
    echoG 'Configure an NFS share drive to be shared among the development team:'
    echo 'Add the following to your conf/local.conf configuration file:'
    echo 'SSTATE_MIRRORS ?= "file://.* file:///nfs/local/mount/sstate/PATH"'
    echo ""
    echoG 'Configure shared state cache sharing via HTTP:'
    echo 'Add the following to your conf/local.conf configuration file:'
    echo 'SSTATE_MIRRORS ?= "file://.* http://example.com/some_path/sstate-cache/PATH"'
    echo ""
    echoG 'Add package-management feature to your root filesystem:'
    echo "Add the following line to your project's conf/local.conf file:"
    echo 'EXTRA_IMAGE_FEATURES += "package-management"'
    echo ""
    echoG "Run the simplest PR server locally on your host system:"
    echo 'To do this, you add the following to your conf/local.conf file:'
    echo 'PRSERV_HOST = "localhost:0"'
    echoY "Note: The PR server is not enabled by default. The packages generated without a PR
    server are consistent with each other but offer no update guarantees for a system that is
    already running."
    echo ""
    echoG 'Run a single instance of the PR server by running the following command:'
    echo '$ bitbake-prserv --host <server_ip> --port <port> --start'
    echoY "Note: And you will update the project's build configuration to use the centralized PR server,
    editing conf/local.conf as follows:"
    echo 'PRSERV_HOST = "<server_ip>:<port>"'
    echo ""
    echoG 'To enable build history:'
    echo 'Add the following to your conf/local.conf file:'
    echo 'INHERIT += "buildhistory"'
    echo ""
    echoG 'To enable the storage of build history in a local Git repository:'
    echo 'Add the following line to the conf/local.conf configuration file as well:'
    echo 'BUILDHISTORY_COMMIT = "1"'
    echoY 'Note: Configure Git repository location for buildhistory:
    Set the BUILDHISTORY_DIR variable, which by default is set to 
    a buildhistory directory on your build directory.'
    echo ""
    echoG  'Configure build history tracks changes:'
    echo "Track only image changes, add the following to your conf/local.conf:"
    echo 'BUILDHISTORY_FEATURES = "image"'
    echoY 'Note: By default, buildhistory tracks changes to packages, images, and SDKs.'
    echo ""
    echoG 'Configure build history tracks specific files:'
    echo 'The files need to be added with the BUILDHISTORY_IMAGE_FILES variable 
    in your conf/local.conf file, as follows:'
    echo 'BUILDHISTORY_IMAGE_FILES += "/path/to/file"'
    echoY 'Note: By default, this includes only /etc/passwd and /etc/groups, 
    but it can be used to track any important files, such as security certificates.'
    echo ""
    echoG 'Enable the collection of statistics'
    echo 'Your project needs to inherit the buildstats class by
    adding it to USER_CLASSES in your conf/local.conf file:'
    echo 'USER_CLASSES ?= "buildstats"'
    echoY 'Note: You can configure the location of these statistics with 
    the BUILDSTATS_BASE variable, and by default it is set to the buildstats 
    folder in the tmp directory under the build directory (tmp/buildstats).'



}

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
    echoC "More information and a user manual for the dnf utility can be found at:"
    echo "http://dnf.readthedocs.io/en/latest/index.html"
    echo ""
    echoC "The GNUPG documentation can be accessed at:"
    echo "https://www.gnupg.org/documentation/"
    echo ""
    echoC "To check errors from the community itself:"
    echo "http://errors.yoctoproject.org"
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
    echo '008) [ cfg ]             Tips for configuration of build.'
    echo '009) [ debug ]           Tips for debuging of build.'
    echo '010) [ bspLayer ]        Tips for maintaining bsp layer(Including create, modify, and any other usage).'
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
    "cfg") echoY '008) [ cfg ]             Tips for configuration of build.'
        show_yocto_config_func
        ;;
    "debug") echoY '009) [ debug ]           Tips for debuging of build.'
        show_debug_func
        ;;
    "bspLayer") echoY '010) [ bspLayer ]        Tips for maintaining bsp layer(Including create, modify, and any other usage).'
        show_bsp_layer_func
        ;;
    *) echo "Unknown command:"
        tips_help_func 
        ;;
esac


