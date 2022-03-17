#!/bin/bash

set -x

cd C:\\Source\\climbjio\\dev

flutter build web

# cd build/web/
# python -m http.server 8083 &
# cd ../../

rsync -av --exclude='index.html' build/web/ ../.