NB. test pjson
NB. all match results should be 1
NB. 0!:2<'test.ijs'

load 'convert/pjson'

cocurrent 'pjson'

val=. 1;(,1);1 0 1;1 3 7;1 3.3 7;(,'a');'hello'
echo enc val
val -: dec enc val

dict=. (;:'items sales prices'),.(;:'nut bold cam cog');6 8 0 3;10 20 15 20
echo enc dict
dict -: dec enc dict

NB. single character is returned as list
val=. 'a';,'a'
echo enc val
0 1 -: val=dec enc val

NB. char matrix is encoded in rows:
(<"1 A) -: dec enc A=. 'anne',:'bert'

NB. _ __ and _. are encoded as null:
'[1,2,null,3,null,null]' -: enc 1 2 _ 3 __ _.

'' -: dec 'null'
(,0) -: dec '[null]'
(,<,0) -: dec '[[null]]'
0 0 -: dec '[null,null]'

NB. false,true,null are decoded to 0,1,NULL
(10 0 1,({.NULL),11) -: dec '10,false,true,null,11'

NB. null for string array
('ab';'';'cd';'';'')-:dec '["ab",null,"cd",null,null]'

NB. decode typical json data:
A=. 0 : 0
[
  {
    "animation": false,
    "title": {display: true, text: "my plot"},
    "ytics": [0,5,10,15]
  }, {
    "animation": true,
    "title": {display: true, format: "e2", text: "my plot2"},
    "ytics": [2,3.5,5,6.5]
  }, {
    "animation": true,
    "title": {display: true, format: null, text: "no plot"},
    "ytics": [5,3.5,null,0]
  }
]
)

echo dec A
echo enc dec A
(dec A) -: dec enc dec A

echo dec A
echo enc dec A
(dec A) -: dec enc dec A

NB. escape
A -: dec enc A=.  'a\"';'b"b\';'c"df/e';'h/'
A -: dec enc A=. 2 2$ 'a\"';'b"b\';'c"df/e';'h/'

NB. dictionary
NB. json string and object always rank-1
A -:&:(,&.>) dec enc A=. _2]\'a';23;'b';'x';'c';<<'asdf'
