class Item {

  String name; 
  String prefix; 
  String suffix; 
  String description;
  int xPos, yPos; 
  int xPosExit, yPosexit;

  //float locX, locY; 

  Item () {
    xPos = 0;
    yPos = 0;
    xPosExit = width/2 - 10; 
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
    text (name, xPos, width/2); 
    if (xPos < width/2) {
      xPos = xPos + 10;
    }
  }

  void animateExit () {

    fill (255, 0, 0);
    text (name, xPosExit, width/2); 

    if (xPosExit < width) {
      xPosExit = xPosExit + 10;
    }
  }
}

