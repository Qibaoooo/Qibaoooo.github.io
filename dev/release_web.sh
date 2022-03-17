#!/bin/bash

set -x

bh='/Qibaoooo.github.io/'

cd C:\\Source\\climbjio\\dev
flutter build web --web-renderer html --no-sound-null-safety
echo -e '===>flutter build web DONE\n\n'

rsync -av build/web/ ../.
echo -e '===>rsync DONE\n\n'

set +x

echo 'check please. enter to exit'
read anything -x

# cd build/web/
# python -m http.server 8083 &
# cd ../../
# /c/tools/flutter/bin/flutter run -d chrome --web-renderer html --web-port 5000 --no-sound-null-safety
