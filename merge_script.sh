#!/bin/sh
set -eux

git fetch

for i in `seq 1 2`
do
    BRANCH="sandbox${i}"
    git co $BRANCH
    git br
    git pull
    git merge origin/master --no-edit && true
    if [ $? -eq 1 ]
    then
        echo "conflict ${BRANCH}"
        git status
        git co --ours hoge.txt
        git add hoge.txt
        GIT_EDITOR=true git merge --continue
        git push --set-upstream origin ${BRANCH}
    fi
    git push --set-upstream origin ${BRANCH}
    echo "merged to ${BRANCH}"
done