#!/usr/bin/env bash

<<<<<<< HEAD
docker build -t osuse:leap .
=======
set -x

if [ "$1" == "no-cache" ]; then
  docker build --no-cache -t osuse:leap .
else
  docker build -t osuse:leap .
fi
>>>>>>> d95b4504ed65e86511c541d3e9587270c99d6c80

rm ./destdir -rf

docker run -i -t -v `pwd`:/build/ osuse:leap

cd destdir
tar cvfJ xt_ndpi.tar.xz ./*
tar tvf xt_ndpi.tar.xz
cd -
<<<<<<< HEAD
=======

set +x
>>>>>>> d95b4504ed65e86511c541d3e9587270c99d6c80
