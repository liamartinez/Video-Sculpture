class StripeBorder {

  int boxHeight; 

  StripeBorder () {
    boxHeight = 30;
  }

  void drawStripeBorder(int startY ) {

    int boxHeight = 30; 

    //draw black
    fill (0); 
    rect (0, startY, width, boxHeight); 

    //draw red middle
    fill (255, 0, 0); 
    rect (0, startY + (boxHeight/3), width, boxHeight/3);
  }
}

