#!/bin/bash
UPSTREAM_REPO="https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/istio/istio.git"
git fetch --tags upstream
git push --tags origin