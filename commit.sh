set -xe

need_ci=${1:-false}

git add .

if $need_ci
then
  git commit -m 'script'
else
  git commit -m 'script [skip ci]'
fi

git push
