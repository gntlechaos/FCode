import static javax.swing.JOptionPane.*;
enum State
{
   REST,
   ENCODING,
   DECODING,
   ENCODED,
   DECODED
}
enum ErrorType 
{
  NONE,
  NOT_TXT,
  NOT_PNG,
  NOT_TXT_SAVE,
  NOT_PNG_SAVE
}
  
FCODE fcode;
IOHandler io;
State currentState = State.REST; 
PImage background;
PFont font;
PFont fontSmall;
PFont fontMini;

PImage image;
String text;


StatsImage statsImg;
StatsText statsTxt;

Popup popup;

void setup()
{
  size(600,500, P2D);
  pixelDensity(displayDensity());
  background = loadImage("background.png");
  font = createFont("arial.ttf",20);
  fontSmall = createFont("arial.ttf",14);
  fontMini = createFont("arial.ttf",8);
  io = new IOHandler();
  popup = new Popup();
  fcode = new FCODE();
}

void draw()
{

  imageMode(CENTER);
  image(background, width/2,height/2);
  
  //Draw selection popup
  if(currentState == State.REST)
  {
    popup.displayMain();
  }
  
  //Encoding
  if(currentState == State.ENCODING)
  {
   cursor(WAIT);
   popup.imageDisplay = fcode.encode(text);
   cursor(ARROW);
   currentState = State.ENCODED;
  }
    //Encoded
  if(currentState == State.ENCODED)
  {
   popup.displayImage();
   
  }
  
  //Decoding
  if(currentState == State.DECODING)
  {
   cursor(WAIT);
   popup.textDisplay = fcode.decode(image);
   cursor(ARROW);
    currentState = State.DECODED;
  }
  
  //Decoded
 if(currentState == State.DECODED)
  {
   popup.displayText();
  }


}

void mouseClicked(){
   
  if(popup.insideEncode && currentState == State.REST)
  {
    io.openTXT();
  }
  if(popup.insideDecode && currentState == State.REST)
  {
    io.openPNG();
  }
  if(popup.insideBack && (currentState == State.DECODED || currentState == State.ENCODED ))
  {
    currentState = State.REST;
    popup.first = true;
  }
  if(popup.insideSave && currentState == State.DECODED)
  {
    io.outputTXT();
  }
  if(popup.insideSave && currentState == State.ENCODED)
  {
    io.outputPNG();
  }
}

void mouseWheel(MouseEvent event)
{
  if(currentState == State.DECODED){
    if (popup.textBox.isInside(mouseX+(popup.textBox.getSize().x/2), mouseY+(popup.textBox.getSize().y/2)))
    {
      popup.textBox.scroll(event.getCount()*1600/frameRate);
    }
  }
}


int nextPerfectSquareSide(int N) 
{ 
  int nextN = (int)Math.floor(Math.sqrt(N)) + 1; 

  return nextN; 
} 
