#!/bin/bash

set -x

echo '=========build========='
cd C:\\Source\\climbjio\\dev

flutter build web

# cd build/web/
# python -m http.server 8083 &
# cd ../../

echo '=========rsync========='
rsync -av --exclude='index.html' build/web/ ../.

set +x
echo 'check please. enter to exit'
read anything