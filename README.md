# Enigma

Three "runner" files provide access to primary functions:  

`encrypt.rb` may be run as:  

```
ruby encrypt.rb <File_to_encrypt.txt> <File_to_write_encrypted_message.txt>  
```  

`decrypt.rb` may be run as:
```
ruby decrypt.rb <Encrypted_file.txt> <File_to_write_decrypted_message.txt> key date
```

Where `key` is a five digit number used for the encryption, and `date` is the date used for encryption in the format `DDMMYY`  

`crack.rb` may be run as:
```
ruby crack.rb <Encrypted_file.txt> <File_to_write_decrypted_message.txt>  date
```
