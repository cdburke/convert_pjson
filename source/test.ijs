NB. test pjson
NB. all match results should be 1

load 'convert/pjson'

cocurrent 'pjson'

val=. 1;(,1);1 0 1;1 3 7;1 3.3 7;(,'a');'hello'
1: echo enc val
val -: dec enc val

dict=. (;:'items sales prices'),.(;:'nut bold cam cog');6 8 0 3;10 20 15 20
1: echo enc dict
dict -: dec enc dict

NB. single character is returned as list
val=. 'a';,'a'
1: echo enc val
0 1 -: val=dec enc val

NB. char matrix is encoded in rows:
(<"1 A) -: dec enc A=. 'anne',:'bert'

NB. _ __ and _. are encoded as null:
'[1,2,null,3,null,null]' -: enc 1 2 _ 3 __ _.

NB. false,true,null are decoded to 0,1,NULL
(10 0 1,NULL,11) -: dec '10,false,true,null,11'

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
  }
]
)

1: echo dec A
1: echo enc dec A
(dec A) -: dec enc dec A

NB. dictionary rank-2 boxed array
B=. }: (0 : 0)   NB. remove last LF
{
"aa":1,
"bb":2,
"cc":3,
"dd":4
}
)

B -: enc A=. (1;2;3;4),.~'aa';'bb';'cc';'dd'
A -: dec B

NB. non-dictionary rank-2 boxed array
'[[0,1,2,3],[4,5,6,7],[8,9,10,11]]' -: enc <"0 i. 3 4
  
'[[[0],[1],[2],[3]],[[4],[5],[6],[7]],[[8],[9],[10],[11]]]' -: enc <&.> <"0 i. 3 4

'[[1,"aa"],[2,"bb"],[3,"cc"],[4,"dd"]]' -: enc A=. (1;2;3;4),.'aa';'bb';'cc';'dd'
A -: dec enc A
