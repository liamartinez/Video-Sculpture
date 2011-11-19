class Item {

  String name; 
  String prefix; 
  String suffix; 
  String description;
  int xPos, yPos; 

  //float locX, locY; 

  Item () {
    xPos = 0;
    yPos = 0;
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
    fill(255, 255, 100); 
    text (name, xPos, height/2); 
    if (xPos < width/2) {
      xPos = xPos + 10;
    }
  }

  void animateExit () {

    fill (100, 255, 255);
    text (name, xPos, height/2); 

    if (xPos < width) {
      xPos = xPos + 10;
    }
  }
}

