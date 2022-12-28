#!/usr/bin/env bash

my_readlink() {
    TARGET_FILE=$1
    pushd `dirname ${TARGET_FILE}` > /dev/null
    TARGET_FILE=`basename ${TARGET_FILE}`

    # Iterate down a (possible) chain of symlinks
    while [ -L "$TARGET_FILE" ]; do
        TARGET_FILE=`readlink ${TARGET_FILE}`
        cd `dirname ${TARGET_FILE}`
        TARGET_FILE=`basename ${TARGET_FILE}`
    done

    # Compute the canonicalized name by finding the physical path
    # for the directory we're in and appending the target file.
    PHYS_DIR=`pwd -P`
    RESULT=${PHYS_DIR}/${TARGET_FILE}
    echo ${RESULT}
    popd > /dev/null
}

DIR="$(dirname $(my_readlink "$0"))/.."
pushd "${DIR}" > /dev/null

source ${DIR}/src/boot.sh

COMMAND="${1:-}"
UNKNOWN_CMD=0

if [ ! -f ${SRC_DIR}/commands/${COMMAND}.sh ]; then
    UNKNOWN_CMD=1
    display_error "Undefined command \"${COMMAND}\"."
    echo ""
fi

source "${SRC_DIR}/commands/${COMMAND}.sh"
RETCODE=$?

if [ ${UNKNOWN_CMD} -eq 1 ]; then
    RETCODE=1
fi

exit $RETCODE