#!/usr/bin/env bash 
#########################################
# created by: Silent-Mobius aka Alex M. Schapelle for Vaiolabs ltd.
# purpose: build script for class
# version: 0.8.11
# Copyright (C) 2024 Alex M. Schapelle and Vaiolabs ltd.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
set -o errexit
set -o pipefail
# set -x
#########################################
PROJECT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_NAME="$(basename $PROJECT)"
DEPENDENCY_ARRAY=(docker jq)
DOCKER="${DEPENDENCY_ARRAY[0]}"
JQ="${DEPENDENCY_ARRAY[1]}"
BUILD_IMAGE=generate-build
BUILD_IMAGE_VERSION=latest
NULL=/dev/null
SLEEP_TIME=1
. /etc/os-release

function main(){

    if [[ $EUID != 0  ]];then
    log "!" "Please Escalate permissions"
        exit 1
    fi 

    log "?" "dependency test: ${DEPENDENCY_ARRAY[@]}"
    if dependency_test;then
        log "+" "dependency check => succeeded"
    else
        log "!" "dependency check => failed"
        exit 1
    fi

    log "?" "checking build image status"
    if build_image_exists;then
        $DOCKER run -v $(pwd):/$PROJECT_NAME  $BUILD_IMAGE:$BUILD_IMAGE_VERSION
    else
        log "!" "image $BUILD_IMAGE not found, will try to build"
        if $DOCKER image build -t $BUILD_IMAGE:$BUILD_IMAGE_VERSION --build-arg BUILD_DIR=$PROJECT_NAME . ;then #> $NULL 2>&1;then
            log "+" "build successful - generating"
            $DOCKER run -v $(pwd):/$PROJECT_NAME  $BUILD_IMAGE:$BUILD_IMAGE_VERSION
        else
            log "!" "build failed - try manual debug"
        fi
    fi
}


function log(){
    level=${1^^}
    message=${2^}
    printf "{%s} [%s] => %s\n" $(date +%Y.%m.%d-%H:%M:%S) "$level" "$message" 
    sleep $SLEEP_TIME
}

function dependency_test(){
    if [[ -e $HOME/.local/$PROJECT_NAME ]];then
        return 0
    fi
    for tool in ${DEPENDENCY_ARRAY[@]}
        do
            if ! command -v $tool;then
                return 1
            fi
        done
    touch $HOME/.local/$PROJECT_NAME
    return 0
}

function build_image_exists(){
    if $DOCKER image ls | grep $BUILD_IMAGE > $NULL 2>&1;then
        return 0
    fi
    return 1
}

########
# Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
#######
main "$@"

