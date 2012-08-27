class Boxes {

  int whichCase; 
  int topColorBG, topColorText, bottomColorBG, bottomColorText; 

  Boxes () {
  } 

  void drawBoxes (int whichCase_) {

    whichCase = whichCase_; 

    stroke (0); 
    strokeWeight (2); 
    line (0, startSectionThree, width, startSectionThree); 
    
    textAlign (CENTER); 

    switch (whichCase) {

    case 1:   
      
    topColorBG = 0;
    topColorText = 255; 
  
    bottomColorBG = 255;
    bottomColorText = 0;   
      
    break; 
    
    case 2: 

    topColorBG = 255;
    topColorText = 0; 
  
    bottomColorBG = 0;
    bottomColorText = 255;   
      

    break; 
    
    case 3:

    topColorBG = 255;
    topColorText = 0; 
  
    bottomColorBG = 255;
    bottomColorText = 0;   
          
    break;       

    }
    
    fill(topColorBG); 
    arc(width/2, startSectionThree, width/3, width/3, PI, TWO_PI);
    rect (0, startSectionTwo+alphabet.boxHeight, (width/items.length)*3, (startSectionThree-startSectionTwo)-alphabet.boxHeight); 
    fill(topColorText); 
    textSize (20); 
    text ("select", ((width/items.length)*3)/2, (startSectionTwo+alphabet.boxHeight) + 30); 
    textSize (150); 
    text ("1", ((width/items.length)*3)/2, (startSectionTwo+alphabet.boxHeight) + 170); 
    
    fill(bottomColorBG); 
    arc(width/2, startSectionThree, width/3, width/3, 0, PI);
    rect (0, startSectionThree, (width/items.length)*3, startSectionThree-startSectionTwo-alphabet.boxHeight);     
    fill(bottomColorText); 
    textSize (20); 
    text ("select", ((width/items.length)*3)/2, startSectionThree + (startSectionThree-startSectionTwo-alphabet.boxHeight) - 30); 
    textSize (150); 
    text ("2", ((width/items.length)*3)/2, startSectionThree + 150); 

    noStroke();
  }
}

