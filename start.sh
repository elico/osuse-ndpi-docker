#!/usr/bin/env bash

set -x

if [ "$1" == "no-cache" ]; then
  docker build --no-cache -t osuse:leap .
else
  docker build -t osuse:leap .
fi

rm ./destdir -rf

docker run -i -t -v `pwd`:/build/ osuse:leap

cd destdir
tar cvfJ xt_ndpi.tar.xz ./*
tar tvf xt_ndpi.tar.xz
cd -

set +x
