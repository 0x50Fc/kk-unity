#!/bin/sh

HOME=`pwd`

cmd() {
    echo "\033[0;1m$1\033[m"
    $1
}

TAG=`date +"%Y%m%d"`

tag(){
    
    PROJ=$1
    BRANCH=$2

    if [ -d $PROJ ] ; then
        cmd "cd $PROJ"
        cmd "git checkout $BRANCH"
        cmd "git pull"
    else
        cmd "git clone https://github.com/hailongz/$PROJ.git"
        cmd "cd $PROJ"
        cmd "git checkout $BRANCH"
    fi

    cmd "git tag $TAG"
    cmd "git push --tags"
    cmd "cd .."
}

if [ ! $1 == "" ];then
    TAG=$1
fi

echo "TAG: $TAG"

tag kk-app master $TAG
tag kk-duktape master $TAG
tag kk-http master $TAG
tag kk-image master $TAG
tag kk-observer master $TAG
tag kk-script master $TAG
tag kk-view master $TAG
tag kk-websocket master $TAG
tag kk-storage master $TAG
tag kk-unity master $TAG
