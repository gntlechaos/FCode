public class IOHandler
{
  
  void openTXT(){
    selectInput("Select a .txt file to encode", "handleText",null, this);
  }
  
  float calculateFileSize(String path)
  {
  File f = new File(path);
  float fileSizeInBytes = f.length();
  f = null;
  return fileSizeInBytes;
  }
  
  public void handleText(File textFile)
  {
    if(textFile != null)
    {
      String textPath = textFile.getAbsolutePath();
      if(textPath.endsWith(".txt"))
      {
      text = join(loadStrings(textPath),"\n");
      currentState = State.ENCODING;  
      }
      else
      {
      popup.error = ErrorType.NOT_TXT;
      }
    }
  }
  
  void openPNG(){
    selectInput("Select a .png file to decode", "handleImage", null, this);
  }
  
  
  public void handleImage(File imageFile)
  {
   if(imageFile != null)
   {
      String imagePath = imageFile.getAbsolutePath();
     if(imagePath.endsWith(".png"))
     {
     image = loadImage(imagePath);
     currentState = State.DECODING;  
     } else
     {
       popup.error = ErrorType.NOT_PNG;
     }
   }
  }
  
  void saveTempFile(PImage img)
  {
    img.save(sketchPath("tempImg.png"));
  }
  
  void saveTempFile(String txt)
  {
    saveStrings(sketchPath("tempTxt.txt"),split(txt,"\n"));
  }
  
  void outputTXT()
  {
    selectOutput("Select where to save your .TXT file!", "saveTXT",new File("decodedText.txt"),this);
  }
  
  public void saveTXT(File outputFile)
  {
    println(outputFile.exists());
    if(outputFile.getAbsolutePath().endsWith(".txt"))
    {
      if(outputFile.exists())
      {
        outputFile.delete();
      }
      File text = new File(sketchPath("tempTxt.txt"));
      text.renameTo(outputFile);
    } else
    {
      popup.error = ErrorType.NOT_TXT_SAVE;
    }
  }

   void outputPNG()
  {
    selectOutput("Select where to save your .PNG file!", "savePNG",new File("encodedImage.png"),this);
  }
  
  public void savePNG(File outputFile)
  {
    if(outputFile.getAbsolutePath().endsWith(".png"))
    {
      if(outputFile.exists())
      {
        outputFile.delete();
      }
      File text = new File(sketchPath("tempImg.png"));
      text.renameTo(outputFile);
    } else
    {
      popup.error = ErrorType.NOT_PNG_SAVE;
    }
  }
  
}
