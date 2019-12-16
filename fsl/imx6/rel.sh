#!/bin/bash

set -o nounset
set -o errexit

#set -x

. ../../libShell/echo_color.lib
. ../../libShell/sysEnv.lib

GRAPHICAL_BACKEND_FB="fb"
GRAPHICAL_BACKEND_X11="x11"

BUILD_DIR_6Q_FB="6q_${GRAPHICAL_BACKEND_FB}"
BUILD_DIR_6Q_X11="6q_${GRAPHICAL_BACKEND_X11}"
#BUILD_DIR_6Q_X11="build_x11"

custom_rel_fs_qt_func()
{
	sed -i "s/^galcore/#galcore/" rootfs/etc/modules-load.d/galcore.conf
	sed -i "s/^nfsd/#nfsd/" rootfs/etc/modules-load.d/nfsd.conf

	cat rootfs/etc/modules-load.d/galcore.conf
	cat rootfs/etc/modules-load.d/nfsd.conf
}

rel_fs_qt_func()
{
    BUILD_DIR=$1

    ORGFS_PATH="/yocto/${BUILD_DIR}/tmp/deploy/images/imx6qsabresd/fsl-image-qt5-imx6qsabresd.tar.bz2"

    pushd /yocto
    mkdir -p rel_6q

    pushd rel_6q

    ORGFS_REAL_NAME=$(readlink ${ORGFS_PATH})
    ORGFS_REAL_PATH=$(readlink -f ${ORGFS_PATH})

    TARGETFS_NAME="${BUILD_DIR}-${ORGFS_REAL_NAME/.bz2/.gz}"
    echoC "Target name:${TARGETFS_NAME}"
    TMP_STR=${ORGFS_REAL_NAME##*-}
#    TARGETFS_DATA=${TMP_STR%%.*}
#	echoC "Target name:${TARGETFS_DATA}"

    rm -rf rootfs
    mkdir -p rootfs

    tar -jxf ${ORGFS_REAL_PATH} -C rootfs/

    custom_rel_fs_qt_func

    tar -zcf ${TARGETFS_NAME} rootfs

    rm -rf rootfs

    popd

    popd
}

rel_sdk_qt_func()
{
    BUILD_DIR=$1
    GRAPHICAL_BACKEND=$2

    ORGFS_PATH="/yocto/${BUILD_DIR}/tmp/deploy/images/imx6qsabresd/fsl-image-qt5-imx6qsabresd.tar.bz2"
    ORGSDK_PATH="/yocto/${BUILD_DIR}/tmp/deploy/sdk/fsl-imx-${GRAPHICAL_BACKEND}-glibc-x86_64-fsl-image-qt5-cortexa9hf-neon-toolchain-4.1.15-2.1.0.sh"

    pushd /yocto
    mkdir -p rel_6q

    pushd rel_6q

    ORGFS_REAL_NAME=$(readlink ${ORGFS_PATH})
    TMP_STR=${ORGFS_REAL_NAME##*-}
    TARGETFS_DATE=${TMP_STR%%.*}

    TMP_STR=${ORGSDK_PATH##*/}
    TARGETSDK_NAME="${TARGETFS_DATE}-${TMP_STR}"

    cp ${ORGSDK_PATH} ${TARGETSDK_NAME}

    popd

    popd
}


usage_func()
{
    echoY "./rel.sh <cmd> <target>"
    echo ""
    echoY "Supported cmds:"
    echo "[ rel ]"
    echoY "Supported targets:"
    echo "[ fs_fb_qt, fs_x11_qt, sdk_fb_qt, sdk_x11_qt ]"
}

is_root_func

[ $# -lt 2 ] && echoR "Invalid args count:$#" && usage_func && exit 1

case $1 in
    "rel") 
        if [ $2 == "fs_fb_qt" ]
        then
            echoY "Releasing $2 ..."
            rel_fs_qt_func ${BUILD_DIR_6Q_FB}
        elif [ $2 == "fs_x11_qt" ]
        then
            echoY "Releasing $2 ..."
            rel_fs_qt_func ${BUILD_DIR_6Q_X11}
        elif [ $2 == "sdk_fb_qt" ]
        then
            echoY "Releasing $2 ..."
            rel_sdk_qt_func ${BUILD_DIR_6Q_FB} ${GRAPHICAL_BACKEND_FB}
        elif [ $2 == "sdk_x11_qt" ]
        then
            echoY "Releasing $2 ..."
            rel_sdk_qt_func ${BUILD_DIR_6Q_X11} ${GRAPHICAL_BACKEND_X11}
        else
            echoY "rel command supported targets:"
            echo "[ fs_fb_qt, fs_x11_qt ]"
        fi
        ;;
    *) echoR "Unknow cmd: $1"
        usage_func
esac

