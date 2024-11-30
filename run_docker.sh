#!/bin/bash
PWD=$(pwd)

. ${PWD}/.myconfig.sh
STATALIC="$(pwd)/stata.lic.${VERSION}"
# Search elsewhere
[[ -z $STATALIC ]] && STATALIC="$(find $HOME/Dropbox/ -name stata.lic.$VERSION | tail -1)"
# Still empty? Exit
[[ -z $STATALIC ]] && echo "No stata.lic file found" && exit 1

docker pull $dockerrepo

if [[ $? == 1 ]]
then
  ## maybe it's local only
  docker image inspect $dockerrepo> /dev/null
  [[ $? == 0 ]] && BUILD=no
fi

docker run \
   -v "${STATALIC}":/usr/local/stata/stata.lic \
   -v $WORKSPACE:/project \
   --rm \
   -it \
   --user statauser \
   --entrypoint /bin/bash \
   $dockerrepo
