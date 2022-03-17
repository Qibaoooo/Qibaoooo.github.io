import re

PATH = '../index.html'
OLD_BH = "<base href=\"/\">"
NEW_BH = "<base href=\"/Qibaoooo.github.io/\">"
bhpattern = re.compile(OLD_BH)

f = open(PATH,'r')
lines = f.readlines()

f.close()

fw = open(PATH,'w')
for l in lines:
    m = bhpattern.search(l)
    if (m):
        l = l.replace(OLD_BH,NEW_BH)
    fw.write(l)

fw.close()