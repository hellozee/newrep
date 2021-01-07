#!/bin/bash
git remote add upstream https://github.com/beepitybop/newrep
git fetch --tags origin
git tag -l | grep -E "^[0-9]+.[0-9]+.[0-9]+$" > f1
git fetch --tags upstream
git tag -l | grep -E "^[0-9]+.[0-9]+.[0-9]+$" > f2

git config --global user.name "github-actions[bot]"
git config --global user.email "41898282+github-actions[bot]@users.noreply.github.com"

echo "print f1"
cat f1
echo "print f2"
cat f2

tags=$(comm -13 f1 f2)
rm f1 f2

for tag in $tags; do
    branch=$( echo $tag | rev | cut -d. -f2- | rev )
    git checkout -b tetrate-release-$branch origin/tetrate-release-$branch
    git merge $tag
    git tag tetrate-test-$tag
    git push origin tetrate-release-$branch --tags
done

git push --tags origin