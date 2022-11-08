#!/bin/sh
set -e

# Tell GitHub Pages not to run Jekyll
touch .nojekyll

[ -n "$INPUT_CNAME" ] && echo "$INPUT_CNAME" > CNAME

echo -e "$hr\nDEPLOYMENT\n$hr"
echo -e "\nDeploying to ${GITHUB_REPOSITORY} on branch ${BRANCH}"
echo -e "Deploying to https://github.com/${GITHUB_REPOSITORY}.git\n"

REMOTE_REPO="https://${ACTOR}:${TOKEN}@github.com/${GITHUB_REPOSITORY}.git" && \
  git init && \
  git config user.name "${ACTOR}" && \
  git config user.email "${ACTOR}@users.noreply.github.com" && \
  git add . && \
  git commit -m "jekyll build from Action ${GITHUB_SHA}" && \
  git push --force $REMOTE_REPO master:$BRANCH && \
# apt update -y && apt install -y yum && yum install psmisc && fuser -k .git ||
  rm -rf .git && \
  cd ..

exit $?
