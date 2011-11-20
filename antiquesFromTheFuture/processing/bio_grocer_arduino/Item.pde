class Item {

  String name; 
  String prefix; 
  String suffix; 
  String description;
  float price;
  int xPos, yPos; 
  int xPosExit, yPosexit;
  int xPosExitBack, xPosBack; 
  int disappear; 

  //float locX, locY; 

  Item () {
    xPos = 0;
    yPos = 0;
    xPosExit = width/2; 
    xPosExitBack = width/2;
    xPosBack = width;
    disappear = 100; 
    textAlign (CENTER);
  }

  void displayName (float locX, float locY, boolean blinkOn) {
    textSize (30); 

    if (blinkOn) {
      if (frameCount % 100 < 50) {
        fill(0);  
        text (name, locX, locY);
      }
    } 
    else {
      fill(0);  
      text (name, locX, locY);
    }
  }

  String getSuffix () {
    return suffix;
  }

  String getPrefix () {
    return prefix;
  }

  void animateEntry (int heightVar) {
    // --> this way
    fill(255, 0, 0); 
    text (name, xPos, heightVar); 
    if (xPos < width/2) {
      xPos = xPos + 10;
    }
  }

  void animateExit (int heightVar) {
    // --> this way
    fill (255, 0, 0);
    text (name, xPosExit, heightVar); 

    if (xPosExit < width + disappear) {
      xPosExit = xPosExit + 10;
    }
  }

  void animateEntryBackward (int heightVar) {
    // <-- this way  
    fill(255, 0, 0); 
    text (name, xPosBack, heightVar); 
    if (xPosBack > width/2) {
      xPosBack = xPosBack - 10;
    }
  }

  void animateExitBackward (int heightVar) {
    // <-- this way 
    fill (255, 0, 0);
    text (name, xPosExitBack, heightVar); 

    if (xPosExitBack > 0 - (disappear * 2 )) {
      xPosExitBack = xPosExitBack - 10;
    }
  }
}

