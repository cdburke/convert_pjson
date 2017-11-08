cocurrent 'pjson'
fmt=: ,@(8!:2)
sep=: }.@;@:(','&,each)
sepfmt=: ' ' -.~ }.@,@(',' ,. >@{.@(8!:1)@,.)
bc=: '{' , '}' ,~ ]
bk=: '[' , ']' ,~ ]

ESC=: _2[\(CR;'\n';LF;'\r';TAB;'\t';'"';'\"';'\';'\\';'/';'\/')
decesc=: rplc&(1|."1 ESC)
encesc=: rplc&ESC
remq=: ]`(}.@}:)@.('"' = {.)
isboxed=: 0 < L.
ischar=: 2=3!:0
isscalar=: 0 = #@$
true=: 1
false=: 0
Null=: $0
cutcommas=: 3 : 0
y=. ',',y
m=. ~:/\y='"'
m=. *./ (m < y=','), 0 = _2 +/\ @ (-/)\ m <"1 '{}[]'=/y
m <@dltb;._1 y
)
dec=: 3 : 0
dec1 dltb ' ' (y I.@:e. TAB,CRLF)} y
)
dec1=: 3 : 0
if. 0=#y do. '' return. end.
select. {. y
case. '{' do. dec_object y
case. '[' do. dec_array y
case. '"' do. decesc }.}:y
case. do. dec_num y
end.
)
dec_array=: 3 : 0
y=. dltb }.}:y
if. 0=#y do. '' return. end.
if. -. y +./@:e. '"{[' do. ,dec_num y return. end.
dec1 each cutcommas y
)

dec_num=: 3 : 0
f=. 'false' I.@:E. y
t=. 'true' I.@:E. y
if. (0<#f) +. 0<#t do.
  n=. (,f +/ 1 2 3 4),,t +/ 1 2 3
  y=. (<<<n) { '1' t} '0' f} y
end.
0 ". ' ' (I.y=',')} y
)
dec_object=: 3 : 0
y=. }.}:y
if. 0=#y do. '' return. end.
dec_object1 &> a: -.~ cutcommas y
)
dec_object1=: 3 : 0
n=. y i. ':'
k=. remq dltb n {. y
v=. dec1 dltb (n+1) }. y
k;<v
)
enc=: 3 : 0
if. 1<#$y do.
  enc_dict y
elseif. isboxed y do.
  bk sep enc each y
elseif. ischar y do.
  enc_char y
elseif. do.
  enc_num y
end.
)
enc_char=: dquote @ encesc
enc_num=: bk @ sepfmt`fmt @. isscalar
enc_dict=: 3 : 0
'rank>2 argument not supported' assert 2 = #$y
'rank 2 argument must be a dictionary' assert (2 = {:$y) > 0 e. ischar &> {."1 y
key=. '"' ,each ({."1 y) ,each <'":'
val=. enc each {:"1 y
rep=. ;key,.val ,each <',',LF
bc (_2}.rep),LF
)
cocurrent 'base'
