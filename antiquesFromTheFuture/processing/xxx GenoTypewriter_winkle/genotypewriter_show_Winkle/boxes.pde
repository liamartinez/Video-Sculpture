class Boxes {

  int whichCase; 
  int topColorBG, topColorText, bottomColorBG, bottomColorText; 
  
  float infoBoxWidth, infoBoxStart; 

  Boxes () {
  } 

  void drawBoxes (int whichCase_) {

    whichCase = whichCase_; 

    stroke (0); 
    strokeWeight (2); 
    line (0, startSectionThree, width, startSectionThree); 
    infoBoxWidth = width/ 3.5; 
    infoBoxStart = width - infoBoxWidth; 
    
    textAlign (CENTER); 

    switch (whichCase) {

    case 1:   
    
    stroke (255); 
    strokeWeight (3); 
    line (0, startSectionTwo+alphabet.boxHeight, width, startSectionTwo+alphabet.boxHeight); 
    noStroke(); 
      
    topColorBG = 0;
    topColorText = 255; 
  
    bottomColorBG = 255;
    bottomColorText = 0;   
      
    break; 
    
    case 2: 
    
    stroke (255); 
    strokeWeight (3); 
    line (0, height - alphabet.boxHeight, width, height - alphabet.boxHeight); 
    noStroke(); 

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
    
    stroke (0); 
    
    fill(topColorBG); 
    arc(width/2, startSectionThree, width/3, width/3, PI, TWO_PI);
    
    if (whichCase != 3) {
    //left rectangle
    rect (0, startSectionTwo+alphabet.boxHeight, (width/items.length)*3, (startSectionThree-startSectionTwo)-alphabet.boxHeight); 
    //right rectangle
    rect (infoBoxStart, startSectionTwo+alphabet.boxHeight, infoBoxWidth, (startSectionThree-startSectionTwo)-alphabet.boxHeight); 
    fill(topColorText); 
    textSize (20); 
    text ("select", ((width/items.length)*3)/2, (startSectionTwo+alphabet.boxHeight) + 30); 
    textSize (150); 
    text ("1", ((width/items.length)*3)/2, (startSectionTwo+alphabet.boxHeight) + 170); 
    }
    
    fill(bottomColorBG); 
    arc(width/2, startSectionThree, width/3, width/3, 0, PI);
    
    if (whichCase != 3) {
    //left rectangle
    rect (0, startSectionThree, (width/items.length)*3, startSectionThree-startSectionTwo-alphabet.boxHeight);     
    //right triangle
    if (whichCase != 3) rect (infoBoxStart, startSectionThree, infoBoxWidth, (startSectionThree-startSectionTwo)-alphabet.boxHeight); 
    fill(bottomColorText); 
    textSize (20); 
    text ("select", ((width/items.length)*3)/2, startSectionThree + (startSectionThree-startSectionTwo-alphabet.boxHeight) - 30); 
    textSize (150); 
    text ("2", ((width/items.length)*3)/2, startSectionThree + 150); 
    }

    noStroke();
  }
}

