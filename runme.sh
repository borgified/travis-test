#!/usr/bin/env bash
set -e

COLOR_RESET='\033[0m'
COLOR_MAGENTA='\033[0;35m'
COLOR_CYAN='\033[0;36m'
MYREPO=${HOME}/workdir/${TRAVIS_REPO_SLUG}
AUTOBRANCH=testing/mybranch${VERSION}

rm -rf ${MYREPO}
mkdir -p ${MYREPO}
git clone https://${CI_USER_TOKEN}@github.com/${TRAVIS_REPO_SLUG} ${MYREPO}
cd ${MYREPO}
git checkout -b ${AUTOBRANCH}
echo "test ${VERSION}" >> version
git config user.email "borgified@gmail.com"
git config user.name "borgified"
git commit -a -m "a"
echo "we committed"
git push https://${CI_USER_TOKEN}@github.com/${TRAVIS_REPO_SLUG} ${AUTOBRANCH}
PR_URL=$(hub pull-request --no-edit)
echo -e "${COLOR_CYAN}ATTENTION:${COLOR_RESET} review and merge ${PR_URL} to continue..."
