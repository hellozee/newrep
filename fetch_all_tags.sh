#!/bin/bash
git tag -l | grep -E "^[0-9]+.[0-9]+.[0-9]+$" > f1
git fetch --tags upstream
git tag -l | grep -E "^[0-9]+.[0-9]+.[0-9]+$" > f2

tags=$(comm -13 f1 f2)
rm f1 f2

for tag in $tags; do
    git checkout tetrate-release-$tag
    git merge $tag
    git tag tetrate-test-$tag
    git push orgin tetrate-release-$tag --tags
done

git push --tags origin