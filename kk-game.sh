#!/bin/sh

HOME=`pwd`

cmd() {
    echo "\033[0;1m$1\033[m"
    $1
}

clone(){
    
    PROJ=$1
    TAG=$2

    if [ -d $PROJ ] ; then
        cmd "cd $PROJ"
        cmd "git checkout $TAG"
        cmd "git pull"
        cmd "cd .."
    else
        cmd "git clone https://github.com/hailongz/$PROJ.git"
        cmd "cd $PROJ"
        cmd "git checkout $TAG"
        cmd "cd .."
    fi

}

build() {

    PROJ=$1

    cmd "cd $PROJ/demo"

    cmd "./gradlew clean"

    cmd "./gradlew assembleRelease"

    cmd "cd $HOME"

}

aar() {
    PROJ=$1
    M=$2
    NAME=$3

    if [ ! -d "bin" ]; then
        cmd "mkdir bin"
    fi

    cmd "cp $PROJ/$M/build/outputs/aar/$M-release.aar bin/$NAME.aar"

}

armeabi() {

    PROJ=$1
    M=$2

    if [ ! -d "bin" ]; then
        cmd "mkdir bin"
    fi

    cmd "cp -r $PROJ/$M/build/intermediates/cmake/release/obj/armeabi bin/"

}

armeabi_so() {

    PROJ=$1
    M=$2
    LIB=$3

    if [ ! $LIB ]; then
        LIB=$M
    fi

    if [ ! -d "bin" ]; then
        cmd "mkdir bin"
    fi

    cmd "cp -r $PROJ/$M/build/intermediates/cmake/release/obj/armeabi/lib${LIB}.so bin/armeabi/lib${LIB}.so"

}

armeabi_libs() {

    PROJ=$1
    M=$2
    LIB=$3

    if [ ! $LIB ]; then
        LIB=$M
    fi

    if [ ! -d "bin" ]; then
        cmd "mkdir bin"
    fi

    cmd "cp -r $PROJ/$M/build/intermediates/jniLibs/release/armeabi/lib${LIB}.so bin/armeabi/lib${LIB}.so"

}

clone kk-app feature_game
clone kk-duktape feature_game
clone kk-http master
clone kk-image master
clone kk-observer master
clone kk-script master
clone kk-view feature_game
clone kk-websocket master
clone kk-storage master
clone kk-unity feature_game

build kk-unity

aar kk-unity kk-app kk-unity-`date +%Y%m%d`
armeabi kk-unity kk-app

aar kk-unity kk-game kk-game-`date +%Y%m%d`
armeabi_so kk-unity kk-game
armeabi_libs kk-unity kk-game event
