NB. build

writesourcex_jp_ '~Addons/convert/pjson/source';'~Addons/convert/pjson/pjson.ijs'

mkdir_j_ '~addons/convert/pjson/demo'

f=. 3 : 0
('~addons/convert/pjson/',y) fcopynew '~Addons/convert/pjson/source/',y
)

f 'manifest.ijs'
f 'pjson.ijs'
f 'readme.txt'
f 'demo/demo1.ijs'
f 'demo/demo2.ijs'
