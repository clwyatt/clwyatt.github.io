#!/bin/sh
# publish current main branch

# make sure I am in the toplevel working directory, else exit
DIR=`basename ${PWD}`

if test "$DIR" = "clwyatt.github.io"; then
    echo "Publishing clwyatt.github.io"
else
    echo "Not in correct directory. Exiting."
    exit 1
fi

# if not on main branch, else exit
BRANCH=`git rev-parse --abbrev-ref HEAD`

if test "$BRANCH" = "main"; then
    echo "Using branch main"
else
    echo "Not in main branch. Exiting."
    exit 1 
fi

# get commit
COMMIT=`git rev-parse HEAD`
echo "Publishing" ${COMMIT}
			   
# stash any local changes
git stash push --include-untracked

# render to docs
quarto render

# commit new docs
git add docs
MESSAGE="Publishing ${COMMIT}"

git commit -m "${MESSAGE}"

# push to GH
git push

# unstash
git stash pop

