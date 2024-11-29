#!/bin/bash
PWD=$(pwd)

. ${PWD}/.myconfig.sh

docker pull $dockerrepo

if [[ $? == 1 ]]
then
  ## maybe it's local only
  docker image inspect $dockerrepo> /dev/null
  [[ $? == 0 ]] && BUILD=no
fi

docker run \
   -v $WORKSPACE:/project \
   --rm \
   -it \
   --user statauser \
   --entrypoint /bin/bash \
   $dockerrepo