class Item {

  String name; 
  String prefix; 
  String suffix; 
  String description;
  
  //float locX, locY; 

  Item () {
  }

  void displayName (float locX, float locY, boolean blinkOn) {
    textSize (50); 
    
    if (blinkOn) {
    if (frameCount % 100 < 50) {
        fill(0);      
        text (name, locX, locY);
    } 
    } else {
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
}

