#!/bin/bash

WORKDIR=$(cd $(dirname $0); pwd)
cd $WORKDIR
docker build -t koduki/sqljudge .

cd $WORKDIR/problem
docker build -t koduki/sqljudge-worker .

cd $WORKDIR/problem/0001
docker build -t koduki/sqljudge-0001 .
docker run -it -v $WORKDIR/problem/0001:/var/docs koduki/pandoc question.md -o question.html

cd $WORKDIR/problem/0002
docker build -t koduki/sqljudge-0002 .
docker run -it -v $WORKDIR/problem/0002:/var/docs koduki/pandoc question.md -o question.html
