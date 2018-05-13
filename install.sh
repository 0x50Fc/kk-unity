#!/bin/sh

PWD=`pwd`

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

    cmd "cd $PWD"

}

clone kk-app master
clone kk-duktape master
clone kk-http master
clone kk-image master
clone kk-observer master
clone kk-script master
clone kk-view master
clone kk-websocket master
clone kk-unity master

build kk-unity
