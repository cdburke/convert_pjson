NB. build

mkdir_j_ '~Addons/convert/pjson/demo'
mkdir_j_ '~addons/convert/pjson/demo'

writesourcex_jp_ '~Addons/convert/pjson/source/source';'~Addons/convert/pjson/pjson.ijs'

'~addons/convert/pjson/pjson.ijs' fcopynew '~Addons/convert/pjson/pjson.ijs'

f=. 3 : 0
('~Addons/convert/pjson/',y) fcopynew '~Addons/convert/pjson/source/',y
('~addons/convert/pjson/',y) fcopynew '~Addons/convert/pjson/source/',y
)

f 'manifest.ijs'
f 'readme.txt'
f 'demo/demo1.ijs'
f 'demo/demo2.ijs'
