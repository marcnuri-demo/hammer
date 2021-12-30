#!/bin/sh

echo "Hammering a nail ($0)"

END_OF_YEAR=$(date -d "$(date '+%Y')/12/31")
LATEST_COMMIT=$(git log -n 1 --pretty=format:"%H")

sed -i '$d' "$0"
echo "# $LATEST_COMMIT" >> "$0"

git add hammer.sh
git commit --fixup="$LATEST_COMMIT"
EDITOR=true git rebase -i --autosquash "$LATEST_COMMIT~1"
GIT_COMMITTER_DATE="$END_OF_YEAR" git commit --amend --no-edit --date "$END_OF_YEAR"
git push origin main -f
# 160159e49831a9a6d0955130197f69b666749f62
