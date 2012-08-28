class AlphabetIndicator {

  int locationY;
  int currentLetter; 
  String[] alphabet = {
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
  }; 

  int boxHeight; 

  AlphabetIndicator () {

    boxHeight = 70;
  }

  void drawAlphabet (int currentLetter_, int locationY_) {

    int roundNum = (currentLetter_/alphabet.length);
    currentLetter = currentLetter_ - (roundNum*currentLetter); 
    println (currentLetter_ + " divided by " + roundNum + " equals " + currentLetter); 

    locationY = locationY_; 
    
    textAlign (CORNER); 

    fill (0);   
    rect (0, locationY, width, boxHeight);  

    for (int i = 0; i < alphabet.length; i++) {
      if  (i == currentLetter) {
        fill (255, 0, 0); 
        textSize (40);
        rect ((i*(width/26)) - ((width/26)/4), locationY + boxHeight/8, width/26, boxHeight/8); 
      } 
      else {
        fill (255); 
        textSize (30);
      }
      text (alphabet[i], (width/26) * i, locationY + (boxHeight-boxHeight/4));
    }
  }
  
  
  String getLetter(int currentLetter_) {

    return alphabet[currentLetter]; 
    
  }
  
}

