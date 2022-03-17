#!/bin/bash

set -x

cd C:\\Source\\climbjio\\dev
flutter build web --web-renderer html --base-href /Qibaoooo.github.io --web-port 5000
echo -e '===>flutter build web DONE\n\n'

rsync -av --exclude='index.html' build/web/ ../.
echo -e '===>rsync DONE\n\n'

set +x

echo 'check please. enter to exit'
read anything -x

# cd build/web/
# python -m http.server 8083 &
# cd ../../