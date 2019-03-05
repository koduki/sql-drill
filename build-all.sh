#!/bin/bash

cd $(dirname $0)
docker build -t koduki/sqljudge .

cd problem
docker build -t koduki/sqljudge-worker .

cd 0001
docker build -t koduki/sqljudge-0001 .
docker run -it -v `pwd`:/var/docs koduki/pandoc question.md -o question.html
