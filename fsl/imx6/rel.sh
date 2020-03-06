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

REL_HOME_DIR=${PWD}

custom_rel_fs_qt_func()
{

    ORG_VERSION=$1
    if [ ${ORG_VERSION} == "4.1.15" ]
    then
        echoY "Customizing fs..."
        sed -i "s/^galcore/#galcore/" rootfs/etc/modules-load.d/galcore.conf
        sed -i "s/^nfsd/#nfsd/" rootfs/etc/modules-load.d/nfsd.conf

        cat rootfs/etc/modules-load.d/galcore.conf
        cat rootfs/etc/modules-load.d/nfsd.conf

        cp ${REL_HOME_DIR}/configs/automount/usb-mount@.service rootfs/etc/systemd/system/
        cp ${REL_HOME_DIR}/configs/automount/usb-mount.sh rootfs/usr/bin/
        cp ${REL_HOME_DIR}/configs/automount/99-local.rules rootfs/etc/udev/rules.d/
    elif [ ${ORG_VERSION} == "4.19.35" ]
    then
        echoY "Customizing fs..."
    else
        echoY "Customizing fs..."
    fi
    
}

rel_fs_qt_func()
{
    BUILD_DIR=$1

    ORG_VERSION=$2
    if [ ${ORG_VERSION} == "4.1.15" ]
    then
        ORGFS_PATH="/yocto/${BUILD_DIR}/tmp/deploy/images/imx6qsabresd/fsl-image-qt5-imx6qsabresd.tar.bz2"
    elif [ ${ORG_VERSION} == "4.19.35" ]
    then
        ORGFS_PATH="/yocto/${BUILD_DIR}/tmp/deploy/images/imx6qsabresd/imx-image-full-imx6qsabresd.tar.bz2"
    else
        echoR "Unsupported version: ${ORG_VERSION}"
        exit 1
    fi

    pushd /yocto
    mkdir -p rel_6q

    pushd rel_6q

    ORGFS_REAL_NAME=$(readlink ${ORGFS_PATH})
    ORGFS_REAL_PATH=$(readlink -f ${ORGFS_PATH})

    TARGETFS_NAME="${BUILD_DIR}-${ORG_VERSION}-${ORGFS_REAL_NAME/.bz2/.gz}"
    echoC "Target name:${TARGETFS_NAME}"
    TMP_STR=${ORGFS_REAL_NAME##*-}
#    TARGETFS_DATA=${TMP_STR%%.*}
#	echoC "Target name:${TARGETFS_DATA}"

    rm -rf rootfs
    mkdir -p rootfs

    tar -jxf ${ORGFS_REAL_PATH} -C rootfs/

    custom_rel_fs_qt_func ${ORG_VERSION}

    tar -zcf ${TARGETFS_NAME} rootfs

    rm -rf rootfs

    popd

    popd
}

rel_sdk_qt_func()
{
    BUILD_DIR=$1
    GRAPHICAL_BACKEND=$2
    ORG_VERSION=$3


    if [ ${ORG_VERSION} == "4.1.15" ]
    then
        ORGFS_PATH="/yocto/${BUILD_DIR}/tmp/deploy/images/imx6qsabresd/fsl-image-qt5-imx6qsabresd.tar.bz2"
        ORGSDK_PATH="/yocto/${BUILD_DIR}/tmp/deploy/sdk/fsl-imx-${GRAPHICAL_BACKEND}-glibc-x86_64-fsl-image-qt5-cortexa9hf-neon-toolchain-4.1.15-2.1.0.sh"
    elif [ ${ORG_VERSION} == "4.19.35" ]
    then
        ORGFS_PATH="/yocto/${BUILD_DIR}/tmp/deploy/images/imx6qsabresd/imx-image-full-imx6qsabresd.tar.bz2"
        ORGSDK_PATH="/yocto/${BUILD_DIR}/tmp/deploy/sdk/fsl-imx-${GRAPHICAL_BACKEND}-glibc-x86_64-imx-image-full-cortexa9hf-neon-toolchain-4.19-warrior.sh"
    else
        echoR "Unsupported version: ${ORG_VERSION}"
        exit 1
    fi


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
    echoY "./rel.sh <target> <version> [args...]"
    echo ""
    echoY "Supported targets:"
    echo "[ fs_fb_qt, fs_x11_qt, sdk_fb_qt, sdk_x11_qt ]"
    echoY "Supported versions:"
#    echo "[ fs_fb_qt, fs_x11_qt, sdk_fb_qt, sdk_x11_qt ]"
    echo "[ 4.1.15, 4.19.35 ]"
}

is_root_func

[ $# -lt 2 ] && echoR "Invalid args count:$#" && usage_func && exit 1

case $1 in
    "fs_fb_qt")
        echoY "Releasing $1 $2 ..."
        ORG_VERSION=$2
        rel_fs_qt_func ${BUILD_DIR_6Q_FB} ${ORG_VERSION}
        ;;
    "fs_x11_qt")
        echoY "Releasing $1 $2 ..."
        ORG_VERSION=$2
        rel_fs_qt_func ${BUILD_DIR_6Q_X11} ${ORG_VERSION}
        ;;
    "sdk_fb_qt")
        echoY "Releasing $1 $2 ..."
        ORG_VERSION=$2
        rel_sdk_qt_func ${BUILD_DIR_6Q_FB} ${GRAPHICAL_BACKEND_FB} ${ORG_VERSION}
        ;;
    "sdk_x11_qt")
        echoY "Releasing $1 $2 ..."
        ORG_VERSION=$2
        rel_sdk_qt_func ${BUILD_DIR_6Q_X11} ${GRAPHICAL_BACKEND_X11} ${ORG_VERSION}
        ;;
    *) echoR "Unknow targets: $1"
        usage_func
esac

