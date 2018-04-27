NB. test pjson
NB. all match results should be 1

load 'convert/pjson'

cocurrent 'pjson'

val=. 1;(,1);1 0 1;1 3 7;1 3.3 7;(,'a');'hello'
enc val
val -: dec enc val

dict=. (;:'items sales prices'),.(;:'nut bold cam cog');6 8 0 3;10 20 15 20
enc dict
dict -: dec enc dict

NB. single character is returned as list
val=. 'a';,'a'
enc val
0 1 -: val=dec enc val

NB. char matrix is encoded in rows:
(<"1 A) -: dec enc A=. 'anne',:'bert'

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
  }
]
)

dec A
enc dec A
(dec A) -: dec enc dec A
