#!/bin/bash

echo git add $1
echo git commit -m \"$2\"
echo git push origin master

git add $1
git commit -m \"$2\"
git push origin master
