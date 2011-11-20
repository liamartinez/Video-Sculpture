class Item {

  String name; 
  String prefix; 
  String suffix; 
  String description;
  float price;
  int xPos, yPos; 
  int xPosExit, yPosexit;
  int xPosExitBack, xPosBack; 

  //float locX, locY; 

  Item () {
    xPos = 0;
    yPos = 0;
    xPosExit = width/2; 
    xPosExitBack = width/2;
    xPosBack = width;
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

  void animateEntry () {
    fill(255, 0, 0); 
    text (name, xPos, height/2); 
    if (xPos < width/2) {
      xPos = xPos + 10;
    }
  }

  void animateExit () {

    fill (255, 0, 0);
    text (name, xPosExit, height/2); 

    if (xPosExit < width) {
      xPosExit = xPosExit + 10;
    }
  }
  
    void animateEntryBackward () {
    fill(255, 0, 0); 
    text (name, xPosBack, height/2); 
    if (xPosBack > width/2) {
      xPosBack = xPosBack - 10;
    }
  }
  
    void animateExitBackward () {

    fill (255, 0, 0);
    text (name, xPosExitBack, height/2); 

    if (xPosExitBack > 0) {
      xPosExitBack = xPosExitBack - 10;
    }
  }
  
}

