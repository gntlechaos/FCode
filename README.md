# FCode
Processing based java application to encode .txt files into .png images and vice-versa

## Initial Ideas
The idea behind this project is to experiment with different ways by which data (text in this case) can be shared. Also, it is a way of protecting it from immediate recognition, that makes this useful for those in need of an extra layer of laziness-proof security (even though it doesn't grant any type of cryptography (yet), it makes it harder to decode if you don't already know this specific application). It is also meant to be a different way of storing and sharing large texts in a different format, as some social media have character limits or simply don't let you share .txt's or documents that aren't images.

## How it works
The basic premise of this program is that the Unicode [Basic Latin](https://www.ssec.wisc.edu/~tomw/java/unicode.html#x0000) + [Latin-1-Supplement](https://www.ssec.wisc.edu/~tomw/java/unicode.html#x0080) characters can be represented by the decimal range of 0 - 255, and so are the RGBA colours of the pixels in a PNG image. So basically we encode each character to one of the RGBA channels of a pixel at a time. So an **X** by **Y** pixels image can store up to ```4*(X*Y)``` characters.

![The image shows how eight characters are encoded in the RGBA colors of two pixels](https://github.com/gntlechaos/FCode/blob/master/ProjectImages/scheme.png?raw=true)

Based on that premise, the characters are encoded in the following order: first all red values in all pixels, then all green values and so on. All the values that aren't used to store any data are set to 255, but this can be changed by altering the ```final int nullCharCode = 255;``` variable in the FCode class.

![The image shows how a 36 characters text can be stored in a 3 by 3 pixels image ](https://github.com/gntlechaos/FCode/blob/master/ProjectImages/scheme2.png?raw=true)

## How it looks (screenshots)

### Startup Window
![Startup Window](https://github.com/gntlechaos/FCode/blob/master/ProjectImages/Screenshot%202.png?raw=true)

### Encoding Text
![Encode Text](https://github.com/gntlechaos/FCode/blob/master/ProjectImages/Screenshot%203.png?raw=true)

### Decoding Image
![Decode Image](https://github.com/gntlechaos/FCode/blob/master/ProjectImages/Screenshot%201.png?raw=true)
