#!/bin/bash
PWD=$(pwd)
dockerbin=$(which docker1 2>/dev/null)
[[ -z $dockerbin ]] && dockerbin=$(which docker)
[[ -z $dockerbin ]] && exit 2

. ${PWD}/.myconfig.sh
STATALIC="$(pwd)/stata.lic.${VERSION}"
# Search elsewhere
[[ ! -f $STATALIC ]] && STATALIC="$(find $HOME/Dropbox/ -name stata.lic.$VERSION | tail -1)"
# Still empty? Exit
[[ ! -f  $STATALIC ]] && echo "No stata.lic file found" && exit 1

$dockerbin pull $dockerrepo

$dockerbin run \
   -v "${STATALIC}":/usr/local/stata/stata.lic \
   -v $WORKSPACE:/project \
   --rm \
   -it \
   --user statauser \
   --entrypoint /bin/bash \
   $dockerrepo
