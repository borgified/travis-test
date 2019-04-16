#!/usr/bin/env bash

set -e

COLOR_RESET='\033[0m'
COLOR_MAGENTA='\033[0;35m'
COLOR_CYAN='\033[0;36m'
MYREPO=${HOME}/workdir/${TRAVIS_REPO_SLUG}
#AUTOBRANCH=testing/mybranch${VERSION}
#GITHUB_USER=borgified

rm -rf ${MYREPO}
mkdir -p ${MYREPO}
git clone https://${GITHUB_TOKEN}@github.com/${TRAVIS_REPO_SLUG} ${MYREPO}
cd ${MYREPO}
git tag "v${VERSION}"
git push --tags
echo "do cocoapods stuff"
