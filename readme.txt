This is a json encoder/decoder and is loaded into the pjson locale.

The main functions are enc and dec:

   enc_pjson_ 1 2 3;'hello'
[[1,2,3],"hello"]

   dec_pjson_ enc_pjson_ 1 2 3;'hello'
┌─────┬─────┐
│1 2 3│hello│
└─────┴─────┘

See demo folder for examples.

encoding:

* a 2-column matrix of key, value pairs is encoded to an object

* otherwise, arguments should have rank < 2, and are encoded to numbers, strings and arrays

* 0 1 are encoded to 0 1

* 'a' and ,'a' are both encoded to "a"

* 4 and ,4 are encoded to 4 and [4] respectively

decoding:

* objects are decoded to 2-column matrices of key, value pairs

* false true are decoded to 0 1
