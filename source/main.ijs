NB. encode

fmtnum=: ,@(8!:2)
fmtnums=: ' ' -.~ }.@,@(',' ,. >@{.@(8!:1)@,.)
fmtint=: ,@('0'&(8!:2))
fmtints=: ' ' -.~ }.@,@(',' ,. >@{.@('0'&(8!:1))@,.)

sep=: }.@;@:(','&,each)
bc=: '{' , '}' ,~ ]
bk=: '[' , ']' ,~ ]

ESC=: _2[\(CR;'\n';LF;'\r';TAB;'\t';'"';'\"';'\';'\\';'/';'\/')
decesc=: rplc&(1|."1 ESC)
encesc=: rplc&ESC
remq=: ]`(}.@}:)@.('"' = {.)
isboxed=: 0 < L.
ischar=: 2=3!:0
isfloat=: 8=3!:0
isscalar=: 0 = #@$
quotes=: '"'&,@(,&'"')
true=: 1
false=: 0
Null=: $0

NB. =========================================================
cutcommas=: 3 : 0
y=. ',',y
m=. ~:/\y='"'
m=. *./ (m < y=','), 0 = _2 +/\ @ (-/)\ m <"1 '{}[]'=/y
m <@dltb;._1 y
)

NB. =========================================================
dec=: 3 : 0
dec1 dltb ' ' (y I.@:e. TAB,CRLF)} y
)

NB. =========================================================
dec1=: 3 : 0
if. 0=#y do. '' return. end.
select. {. y
case. '{' do. dec_object y
case. '[' do. dec_array y
case. '"' do. decesc }.}:y
case. do. dec_num y
end.
)

NB. =========================================================
dec_array=: 3 : 0
y=. dltb }.}:y
if. 0=#y do. $0 return. end.
if. -. y +./@:e. '"{[' do. ,dec_num y return. end.
dec1 each cutcommas y
)

NB. =========================================================
dec_num=: 3 : 0
f=. 'false' I.@:E. y
t=. 'true' I.@:E. y
if. (0<#f) +. 0<#t do.
  n=. (,f +/ 1 2 3 4),,t +/ 1 2 3
  y=. (<<<n) { '1' t} '0' f} y
end.
0 ". ' ' (I.y=',')} y
)

NB. =========================================================
dec_object=: 3 : 0
y=. }.}:y
if. 0=#y do. '' return. end.
dec_object1 &> a: -.~ cutcommas y
)

NB. =========================================================
dec_object1=: 3 : 0
n=. y i. ':'
k=. remq dltb n {. y
v=. dec1 dltb (n+1) }. y
k;<v
)

NB. =========================================================
enc=: 3 : 0
if. 1<#$y do.
  if. (2=#$y) *. ischar y do.
    enc <"1 y
  else.
    enc_dict y
  end.
elseif. isboxed y do.
  bk sep enc each y
elseif. ischar y do.
  enc_char y
elseif. isfloat y do.
  enc_num y
elseif. do.
  enc_int y
end.
)

NB. =========================================================
enc_char=: quotes @ encesc
enc_num=: bk @ fmtnums`fmtnum @. isscalar
enc_int=: bk @ fmtints`fmtint @. isscalar

NB. =========================================================
NB. enc_dict
NB. this encodes dicts where col 0 is char keys, and col 1 is values
enc_dict=: 3 : 0
'rank>2 argument not supported' assert 2 = #$y
'rank 2 argument must be a dictionary' assert (2 = {:$y) > 0 e. ischar &> {."1 y
key=. '"' ,each ({."1 y) ,each <'":'
val=. enc each {:"1 y
rep=. ;key,.val ,each <',',LF
bc LF,(_2}.rep),LF
)

NB. =========================================================
cocurrent 'base'
