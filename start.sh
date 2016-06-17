#!/usr/bin/env bash

docker build -t osuse:leap .

rm ./destdir -rf

docker run -i -t -v `pwd`:/build/ osuse:leap

cd destdir
tar cvfJ xt_ndpi.tar.xz ./*
tar tvf xt_ndpi.tar.xz
cd -
