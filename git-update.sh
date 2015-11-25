#!/bin/bash

echo git add $1
echo git commit -m \"$2\"
echo git push origin master

git add $1
commit_command="git commit -m \"$2\""
echo $commit_command
eval $commit_command
git push origin master

