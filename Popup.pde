class Popup {
 
  PImage imageDisplay;
  String textDisplay;
  TextBox textBox;
  
  boolean insideDecode = false;
  boolean insideEncode = false;
  boolean insideSave = false;
  boolean insideBack = false;
  
  boolean first = true;
  ErrorType error = ErrorType.NONE;
  
  Popup(){
    
  }
  
  void displayMain()
  {
    if(error == ErrorType.NOT_PNG)
    {
      showMessageDialog(null,"Invalid file extension. File needs to be .PNG!");
      io.openPNG();
      error =  ErrorType.NONE;
    }
    if(error == ErrorType.NOT_TXT)
    {
      showMessageDialog(null,"Invalid file extension. File needs to be .TXT!");
      io.openTXT();
      error =  ErrorType.NONE;
    }
    pushMatrix();
    translate(width/2,height/2);
    rectMode(CENTER);
    stroke(255);
    noFill();
    rect(0,0,300,200);
    fill(255);
    textAlign(CENTER);
    textFont(font);
    text("DO YOU WISH TO:",0,-30);
    
    if((mouseX > 210) && (mouseX < 289) && (mouseY > 254)  && (mouseY < 285))
    { 
      fill(color(255,255,255,100));
      cursor(HAND);
      insideEncode = true;
    } else
    { 
      noFill();
      insideEncode = false; 
    }
    rect(-50,20,80,30);
    
    if((mouseX > 310) && (mouseX < 389) && (mouseY > 254)  && (mouseY < 285))
    { 
      fill(color(255,255,255,100));
      cursor(HAND);
      insideDecode = true;
    } else
    { 
      noFill();
      insideDecode = false;
    }
    rect(50,20,80,30);
    
    if(!((mouseX > 210) && (mouseX < 289) && (mouseY > 254)  && (mouseY < 285)) && !((mouseX > 310) && (mouseX < 389) && (mouseY > 254)  && (mouseY < 285))){ 
    cursor(ARROW);}
    
    
    fill(255);
    textFont(fontSmall);
    text("ENCODE",-50,25);
    text("DECODE",50,25);
    popMatrix();  
  }
  
  
  void displayImage()
  {
    if(error == ErrorType.NOT_PNG_SAVE)
    {
      showMessageDialog(null,"Invalid file extension. File needs to be .PNG!");
      io.outputPNG();
      error =  ErrorType.NONE;
    }
    
    rectMode(NORMAL);
    textAlign(CENTER,CENTER);
    if((mouseX > 5) && (mouseX < 80) && (mouseY > 5) && (mouseY < 40))
    {
    fill(color(255,255,255,100));
    insideBack = true;
    } else
    {
    noFill();
    insideBack = false;
    }
    rect(5,5,75,35);
    fill(255);
    textFont(fontSmall);
    text("BACK",40,18);
    
    pushMatrix();
    translate(width/2,height/2);
    
    //Displaying image
    rectMode(CENTER);
    fill(255);
    imageMode(CENTER);
    
    if(imageDisplay.width < 200){
      rect(-100,0,imageDisplay.width+10,imageDisplay.width+10);
      image(imageDisplay,-100,0);
    } else{
     rect(-100,0,210,210);
     if(first){
     imageDisplay.resize(200,200); 
     first = false;
     }
     image(imageDisplay,-100,0);
    }
    
    textAlign(CENTER);
    fill(255);
    textFont(font);
    text("Preview:",-100,-120);
    
    //Displaying stats
    text("Stats:",150,-120);
    textFont(fontSmall);
    text("Eplapsed Time: "+statsImg.time/1000+" sec",150,-90);
    text("Image Size: "+statsImg.imageSize+"x"+statsImg.imageSize+" pixels",150,-70);
    float fileSize = statsImg.fileSize;
    //Display file size in bytes
    if(fileSize < 1024){
      text("File Size: "+round(fileSize)+" bytes",150,-50);
    } // Display in KiloBytes
    else if (fileSize > 1024 && fileSize < 1024*1024)
    {
      text("File Size: "+round(fileSize/1024)+" KB",150,-50);
    } else // Display in MegaBytes
    {
      text("File Size: "+round((fileSize/1024)/1024)+" MB",150,-50);
    }
    popMatrix();
    
    textAlign(CENTER,CENTER);
    stroke(255);
    strokeWeight(1);
    if((mouseX > 412) && (mouseX < 487) && (mouseY > 212) && (mouseY < 247))
    {
    fill(color(255,255,255,100));
    insideSave = true;

    } else
    {
    noFill();
    insideSave = false;

    }
    rect(450,230,75,35);
    fill(255);
    textFont(fontSmall);
    text("SAVE",450,228);
    
    if(((mouseX > 412) && (mouseX < 487) && (mouseY > 212) && (mouseY < 247)) || ((mouseX > 5) && (mouseX < 80) && (mouseY > 5) && (mouseY < 40) ))
    {
      cursor(HAND);
    }
    else
    {
     cursor(ARROW); 
    }
  }
  
  void displayText()
  {

    if(error == ErrorType.NOT_TXT_SAVE)
    {
      showMessageDialog(null,"Invalid file extension. File needs to be .TXT!");
      io.outputTXT();
      error =  ErrorType.NONE;
    }
    rectMode(NORMAL);
    textAlign(CENTER,CENTER);
    stroke(255);
    strokeWeight(1);
    if((mouseX > 5) && (mouseX < 80) && (mouseY > 5) && (mouseY < 40))
    {
    fill(color(255,255,255,100));
    insideBack = true;
    } else
    {
    noFill();
    insideBack = false;
    }
    rect(5,5,75,35);
    fill(255);
    textFont(fontSmall);
    text("BACK",40,18);
    

 
    if(first)
    {
      textBox = new TextBox(190,275,300,380);
      textBox.setBackCol(color(255,255,255));
      textBox.setEdgeCol(color(255,255,255,0));
      textBox.setFont(fontSmall);
      
      textBox.text = textDisplay;

      first = false;
    }
    rectMode(CENTER);
    noStroke();
    fill(255);
    rect(190,275,310,390);
    textBox.draw();
 
    pushMatrix();
    translate(width/2,height/2);
    
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    imageMode(CENTER);
    
    fill(255);
    textFont(font);
    text("Preview:",-110,-195);
    
    //Displaying stats
    text("Stats:",170,-100);
    textFont(fontSmall);
    text("Eplapsed Time: "+statsTxt.time/1000+" sec",170,-70);
    text("Text Size: "+statsTxt.textSize+" characters",170,-50);
    float fileSize = statsTxt.fileSize;
    //Display file size in bytes
    if(fileSize < 1024){
      text("File Size: "+round(fileSize)+" bytes",170,-30);
    } // Display in KiloBytes
    else if (fileSize > 1024 && fileSize < 1024*1024)
    {
      text("File Size: "+round(fileSize/1024)+" KB",170,-30);
    } else // Display in MegaBytes
    {
      text("File Size: "+round((fileSize/1024)/1024)+" MB",170,-30);
    }

    popMatrix();
    
    stroke(255);
    strokeWeight(1);
    if((mouseX > 430) && (mouseX < 510) && (mouseY > 250) && (mouseY < 288))
    {
    fill(color(255,255,255,100));
    insideSave = true;

    } else
    {
    noFill();
    insideSave = false;

    }
    rect(470,270,75,35);
    fill(255);
    textFont(fontSmall);
    text("SAVE",470,268);
    
    if(((mouseX > 430) && (mouseX < 510) && (mouseY > 250) && (mouseY < 288)) || ((mouseX > 5) && (mouseX < 80) && (mouseY > 5) && (mouseY < 40)))
    {
      cursor(HAND);
    }
    else if(popup.textBox.isInside(mouseX+(popup.textBox.getSize().x/2), mouseY+(popup.textBox.getSize().y/2)))
    {
     cursor(TEXT); 
    } else
    {
    cursor(ARROW);
    }
  }
}
