public class FCODE
{
//Defining some parameters
  final int minImageSize = 1;  //Images will always be squares 
  //Char slots avaliable using one RGBA channel
  final int charNumberThresholdInMin = (int) sq(minImageSize); 
  //Char slots avaliable using all RGBA channels
  final int maxCharNumberInMin = charNumberThresholdInMin * 4; 
  final int nullCharCode = 255;
  float initialTime = 0;

  
public String decode(PImage img)
{
  initialTime = millis();
  
  img.loadPixels();
//Checking image size & number of non-null characters
  int numberOfPixels = img.width * img.height;
  int usedPixels = 0;
  for(int i = 0; i < numberOfPixels; i ++)
  {
    color c = img.pixels[i];
    if(red(c) != nullCharCode) { usedPixels++; };
    if(green(c) != nullCharCode) { usedPixels++; };
    if(blue(c) != nullCharCode) { usedPixels++; };
    if(alpha(c) != nullCharCode) { usedPixels++; };
  }

//Creating char array
  char[] chars = new char[usedPixels];
  
//Decoding the info
  for(int i = 0; i < usedPixels; i++)
  {
    int currentPixel = i % numberOfPixels;
    
    if(i < numberOfPixels)
    {  
      chars[i] = char((int)red(img.pixels[currentPixel]));
    }
    else if (i < numberOfPixels*2)
    {
      chars[i] = char((int)green(img.pixels[currentPixel]));
    }
    else if (i < numberOfPixels*3)
    {
      chars[i] = char((int)blue(img.pixels[currentPixel]));
    }
    else 
    {
      chars[i] = char((int)alpha(img.pixels[currentPixel]));
    }
  }
  image.updatePixels();
  
//Reconstructing the string
  String text = new String(chars);
  
  io.saveTempFile(text);
  float fileSizeInBytes = io.calculateFileSize(sketchPath("tempTxt.txt"));

  float time = millis() - initialTime;
  statsTxt = new StatsText(time,usedPixels,fileSizeInBytes);
  return text;
  
}

public PImage encode(String text)
{
  initialTime = millis();
//Defining text to be encoded and related variables
  int textLength = text.length();
  
//Calculating image size & creating image
  int imageSize;
  if(textLength <= maxCharNumberInMin)
  {
    imageSize = minImageSize;
  } else 
  {
    
    if(IsPerfectSquare(ceil(textLength/ (float)4))){
      imageSize = (int)sqrt(ceil(textLength/ (float)4));
    } else {
    imageSize = nextPerfectSquareSide(ceil(textLength/ (float)4));
    }
  }
  PImage imageLocal = createImage(imageSize,imageSize,ARGB);
  
//Creating integer array -- Unnecessary loop 
  //int[] encodedIntText = new int[textLength];
  //for(int i = 0; i < textLength; i++)
  //{
  //  encodedIntText[i] = int(text.charAt(i));
  //}
  
//Loading the info in the image
  imageLocal.loadPixels();
  for(int i = 0; i < textLength; i++)
  {
    int currentPixel = i % (int)sq(imageSize);
    //println(ceil((i/ (float)textLength)*100) + "%");
    
    if(i < sq(imageSize))
    {
      imageLocal.pixels[i] = color(int(text.charAt(i)),nullCharCode,nullCharCode,nullCharCode);
     
    } 
    else if(i < sq(imageSize)*2)
    {
      imageLocal.pixels[currentPixel] = color(red(imageLocal.pixels[currentPixel]),int(text.charAt(i)),nullCharCode,nullCharCode);
      
    } 
    else if(i < sq(imageSize)*3)
    {
      imageLocal.pixels[currentPixel] = color(red(imageLocal.pixels[currentPixel]),green(imageLocal.pixels[currentPixel]),int(text.charAt(i)),nullCharCode);
    } else 
    {
      imageLocal.pixels[currentPixel] = color(red(imageLocal.pixels[currentPixel]),green(imageLocal.pixels[currentPixel]),blue(imageLocal.pixels[currentPixel]),int(text.charAt(i)));
  }
    
  }
  imageLocal.updatePixels();
  
  float time = millis() - initialTime;
  io.saveTempFile(imageLocal);
  float fileSizeInBytes = io.calculateFileSize(sketchPath("tempImg.png"));
  
  statsImg = new StatsImage(time,imageSize,fileSizeInBytes);
  return imageLocal;
  
}
}
