#!/bin/bash
git tag -l | grep -E "^[0-9]+.[0-9]+.[0-9]+$" > f1
git fetch --tags upstream
git tag -l | grep -E "^[0-9]+.[0-9]+.[0-9]+$" > f2

echo "print f1"
cat f1
echo "print f2"
cat f2

tags=$(comm -13 f1 f2)
rm f1 f2

for tag in $tags; do
    branch=$( echo $tag | rev | cut -d. -f2- | rev )
    git checkout tetrate-release-$branch
    git merge $tag
    git tag tetrate-test-$tag
    git push orgin tetrate-release-$branch --tags
done

git push --tags origin