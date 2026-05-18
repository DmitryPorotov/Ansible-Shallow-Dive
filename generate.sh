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
WORKDIR="$PROJECT/out"
THEME="${PROJECT}/99_misc/.theme/"
BUILD_DIR_ARRAY=($(ls $PROJECT|grep -vE "99_*|.git|README.md|Dockerfile|LICENSE|TODO.md|build.sh|generate.sh|$PROJECT_NAME.md|$PROJECT_NAME.html|$PROJECT_NAME.pdf|out|spell.txt"))
BUILD_TOOL=$(which darkslide)
BUILD_TOOL_VERSION=$(darkslide --version|awk '{print $2}')
DEPENDENCY_ARRAY=(darkslide weasyprint codespell) # single crucial point of failure for multi-type environments (Linux-Distro's,MacOS)
SLEEP_TIME=1
SPELLCHECK=$(which codespell)
NULL=/dev/null
. /etc/os-release


main(){
    if [[ ${#} -le 0 ]];then
        _help
    fi
    while getopts "bcht" opt
    do
        case $opt in
            b)
                log '+' 'Cleaning Up The Previous Builds' 
                    clean_up  
                log '+' "Building $PROJECT_NAME presentation" 
                    seek_all_md_files_and_write_to "$WORKDIR/$PROJECT_NAME.md"
                log '+' 'Converting Data     ' 
                    convert_data "$WORKDIR/$PROJECT_NAME.md" "$WORKDIR/$PROJECT_NAME.html"
                log '+' 'Converting HTML to PDF     ' 
                    convert_html_to_pdf "$WORKDIR/$PROJECT_NAME.html" "$WORKDIR/$PROJECT_NAME.pdf"
                ;;
            c) 
                log  '+' 'Cleaning Up The Previous Builds' 
                    clean_up
                ;;
            h) _help
                    exit 1
                ;;
            t)  
               log '+' 'Checking Spelling'
                    FOLDER_LIST=$(find  -name '*.md' |sort)
                    for folder in ${FOLDER_LIST}
                        do
                            codespell -I spell.txt "$folder"
                        done
                ;;
            *) _help
                ;;
        esac
    done

}

function log(){
    level=${1^^}
    message=${2^}
    printf "{%s} [%s] => %s\n" $(date +%Y.%m.%d-%H:%M:%S) "$level" "$message" 
    sleep $SLEEP_TIME
}

function _help() {
    log "?" "incorrect use"
    log "?" "please use ${0##./} \"-b\" for build and \"-c\" for clean up"
    log "?" "example: ${0##./} -c"
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

function clean_up(){
    if [[ -d $WORKDIR ]];then
       rm -rf $WORKDIR
    fi
    mkdir -p $WORKDIR
    for _dir in "${BUILD_DIR_ARRAY[@]}"
        do 
            ln -s "$PROJECT/$_dir" "$WORKDIR/$_dir"
        done
        chmod 777 -R $WORKDIR

}

function get_installer(){
    if [[ $ID == 'debian' ]] || [[ $ID == 'ubnutu' ]] || [[ $ID == 'linuxmint' ]];then
         INSTALLER=apt-get
    elif [[ $ID == 'redhat' ]] || [[ $ID == 'fedora' ]] || [[ $ID == 'rocky' ]];then
         INSTALLER=yum
    else  
        log '[!]' 'OS Not Supported' 
        log '[+]' 'Please Contact Instructor'
    fi
}

function get_build_tool(){
    if [[ -n $BUILD_TOOL ]];then
        BUILD_TOOL=$(which darkslide)
        BUILD_TOOL_VERSION=$($BUILD_TOOL --version | awk '{print $2}')
        if [[ $BUILD_TOOL_VERSION == '6.0.0' ]];then
            log '[!]' "Newer build tool detected"
            log "[+]" "Downgrade to version 5.1.0 for build to work" 
            log "[+]" "Or use docker branch to build inside docker "
            log "[+]" "Link to package: http://ftp.de.debian.org/debian/pool/main/p/python-darkslide/darkslide_5.1.0-1_all.deb"
            log "[+]" "In case package not avaible on that address check on : https://pkgs.org"
            
            exit 1
        fi
    elif ! which landslide &> $NULL ;then
        BUILD_TOOL=$(which landslide)
    else
        log '+ Dependency Missing: Trying To Fix   '
        for dep in "${DEPENDENCY_ARRAY[@]}"
            do
                printf "\n%s \n " "+ Trying To Install:  $dep"
                if ! sudo "${INSTALLER}" install -y "${dep}" 1>&2 2>&1 $NULL;then
                    log '[!]' 'Install Failed' 
                    log '[+]' 'Please Contact Instructor   '
                    exit 1
                fi
            done
        if which darkslide &> $NULL;then
            BUILD_TOOL=$(which darkslide)
        elif ! which darkslide &> $NULL ;then
            BUILD_TOOL=$(which landslide)
        fi
    fi

}

function seek_all_md_files_and_write_to() {
    IN=$1
    BUILD_WORKDIR_ARRAY=($(ls $WORKDIR|grep -vE "99_*|.git|Dockerfile|README.md|TODO.md|build.sh|generate.sh|$PROJECT_NAME.md|$PROJECT_NAME.html|$PROJECT_NAME.pdf|out|spell.txt"))
    find "${BUILD_WORKDIR_ARRAY[@]}" -name '*.md' | sort|xargs cat > $IN 2> $NULL

}

function convert_data() {
    IN=$1
    OUT=$2
        if [[ $ID == 'ubuntu' ]] || [[ $ID == 'linuxmint' ]];then
            ${BUILD_TOOL} -v  -t $THEME -x fenced_code,codehilite,extra,toc,smarty,sane_lists,meta,tables $IN -d $OUT
        elif [[ $ID == 'fedora' ]] || [[ $ID == 'rocky' ]];then
            ${BUILD_TOOL} -v  -t $THEME -x fenced_code,codehilite,extra,toc,smarty,sane_lists,meta,tables $IN -d $OUT
        else
            ${BUILD_TOOL} -v  -t $THEME -x fenced_code,codehilite,extra,toc,smarty,sane_lists,meta,md_in_html,tables $IN -d $OUT
        fi
}

function convert_html_to_pdf(){
    IN=$1
    OUT=$2
    # SED operation is required on darkslide version 6.0.0 + use older version of tool or user docker branch for making your life easier
    # sed -i 's#<link rel="stylesheet" href="file:///usr/lib/python3/dist-packages/darkslide/themes/default/css/base.css">##' $IN
    # sed -i 's#<link rel="stylesheet" href="file:///usr/lib/python3/dist-packages/darkslide/themes/default/css/theme.css">##' $IN
        weasyprint -v  $IN $OUT
}



#######
# Main
#######
main "$@"

# TODO - build script: wrap up in docker
