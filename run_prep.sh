#!/usr/bin/env bash
set -e

# this script expects the following environment variables defined in travis job settings
# GITHUB_TOKEN - github api token with repo permissions (display value in build log setting: OFF)
# GITHUB_USER - github username that GITHUB_TOKEN is associated with (display value in build log setting: ON)

COLOR_RESET='\033[0m'
COLOR_MAGENTA='\033[0;35m'
COLOR_CYAN='\033[0;36m'
MYREPO=${HOME}/workdir/${TRAVIS_REPO_SLUG}
AUTOBRANCH=${GITHUB_USER}/prepareRelease${VERSION}

function prep_workspace {
  mkdir -p ${MYREPO}
  git clone -b ${TRAVIS_BRANCH} https://${GITHUB_TOKEN}@github.com/${TRAVIS_REPO_SLUG} ${MYREPO}
  cd ${MYREPO}
  git checkout -b ${AUTOBRANCH}
}

function do_stuff {
  echo "test ${VERSION}" >> version
}

function push_changes {
  git config user.email "optibot@users.noreply.github.com"
  git config user.name "${GITHUB_USER}"
  git commit -a -m "auto_branch_$VERSION"
  git push https://${GITHUB_TOKEN}@github.com/${TRAVIS_REPO_SLUG} ${AUTOBRANCH}
  PR_URL=$(hub pull-request --no-edit -b ${TRAVIS_BRANCH})
  echo -e "${COLOR_CYAN}ATTENTION:${COLOR_RESET} review and merge ${COLOR_CYAN}${PR_URL}${COLOR_RESET}"
  echo "then to release to cocoapods use Travis CI's Trigger build with the following payload:"
  echo -e "${COLOR_MAGENTA}env:${COLOR_RESET}"
  echo -e "${COLOR_MAGENTA}  - RELEASE=true${COLOR_RESET}"
  echo "im on ${TRAVIS_BRANCH}"
}

function main {
  prep_workspace
  do_stuff
  push_changes
}

main
