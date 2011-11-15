class Item {

  String name; 
  String prefix; 
  String suffix; 
  String description;
  
  //float locX, locY; 

  Item () {
  }

  void displayName (float locX, float locY, boolean blinkOn) {
    textSize (15); 
    
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
  
  
  
/*
  void blinkName (boolean on) {
    if (on) {
      if (frameCount % 100 < 50) {

        fill(0);
        textAlign(CENTER);
        text("YOU WIN!", width/2, height/2);
      }
    }
  }

*/
  String getSuffix () {
    return suffix;
  }

  String getPrefix () {
    return prefix;
  }
}

