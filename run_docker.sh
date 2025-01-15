#!/bin/bash
PWD=$(pwd)

. ${PWD}/.myconfig.sh
STATALIC="$(pwd)/stata.lic.${VERSION}"
# Adjust for docker1 on BioHPC
dockerbin=$(which docker1)
[[ -z $dockerbin ]] && dockerbin=$(which docker)

# Search elsewhere
[[ ! -f $STATALIC ]] && STATALIC="$(pwd)/.stata.lic"
[[ ! -f $STATALIC ]] && STATALIC="$(find $HOME/Dropbox/ -name stata.lic.$VERSION | tail -1)"
# Still empty? Exit
[[ ! -f  $STATALIC ]] && echo "No stata.lic file found" && exit 1

$dockerbin pull $dockerrepo

$dockerbin run \
   -v "${STATALIC}":/usr/local/stata/stata.lic \
   -v $WORKSPACE:/project \
   -w /project \
   --rm \
   -it \
   --user statauser \
   --entrypoint /bin/bash \
   $dockerrepo
