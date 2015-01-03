#!/bin/bash
if [ -z "$1" ]
then
  echo No tag provided to patch
  exit 1;
fi
patch_feat=${1#v}
patch_feat=${patch_feat%.*.*}
echo Patching feature: $patch_feat with tag: $1
git for-each-ref --shell --format="%(refname:short)" refs/tags |
while read entry;
do
  tag=${entry#\'tags\/}
  tag=${tag#\'}
  tag=${tag%\'}
  feat=${tag#v}
  feat=${feat%.*.*}
  echo patching $patch_feat onto $feat
  if [[ "$feat" -le "$patch_feat" ]]
  then
    continue
  fi
  patch=${tag#v*.*.}
  new_patch=$[patch+1]
  pre_ver=${tag%.*}
  new_ver=$pre_ver.$new_patch
  if GIT_DIR=/path/to/repo/.git git rev-parse $new_ver >/dev/null 2>&1
  then
    continue
  fi
  git rebase $tag --preserve-merges
  echo "Creating new Tag: $new_ver"
  git tag -a $new_ver -m "Patched from $patch_tag"
done
