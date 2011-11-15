

Item[] items = new Item[8]; 
int dial; 
int chosenOne, chosenTwo;

PFont font; 
int locOneX, locOneY; 

int state; 



void setup () {
  size (500, 500); 

  smooth(); 
  font = loadFont ("SansSerif-48.vlw"); 
  textFont(font, 48); 

  String[] input = loadStrings("groceries.csv");
  for (int i = 0; i < items.length; i++) {
    items[i] = new Item();
    String[] splits = input[i].split(",");
    items[i].name = splits[0]; 
    items[i].prefix = splits[1]; 
    items[i].suffix = splits[2]; 
    items[i].description = splits[3]; 
    println (i+ " " + items[i].name);
  }

  state = 0; 
  dial = 0;
  locOneX = width/3;
  locOneY = height/3;
  chosenOne = 0; 
  chosenTwo = 0;
}


void draw () {
  background (255); 


  switch (state) {

  case 0:  
    items[dial].displayName (locOneX, locOneY, true); 
    break; 

  case 1:
    items[chosenOne].displayName (locOneX, locOneY, false); 
    items[dial].displayName (locOneX + 100, locOneY, true); 
    break; 

  case 2: 
    items[chosenOne].displayName (locOneX, locOneY, false); 
    items[chosenTwo].displayName (locOneX + 100, locOneY, false); 
    
    //combine the prefixes and suffixes
    text ("yay " + items[chosenOne].prefix + items[chosenTwo].suffix + "!!", locOneX, locOneY+30); 
    text ("it " + items[chosenOne].description + " and " + items[chosenTwo].description, locOneX, locOneY+60); 

  }
}


void keyPressed () {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      if (dial < (items.length-1)) {    //if dial is at the max number  
        dial ++;
      } 
      else {
        dial = 0; // loopback to 0
      }
    }
    if (keyCode == LEFT) {
      if (dial != 0) { // if dial is at 0
        dial --;
      } 
      else {
        dial = (items.length-1); //loopback to the max
      }
    }
    if (keyCode == UP) {
      state = 1;
    }
  }
}


void mousePressed () {

  if (state < 2) {
    state ++;
  } 
  else {
    state = 0;
  }

  switch (state) {
  case 0: 
    chosenOne = 0; 
    chosenTwo = 0; 
    break; 

  case 1:
    chosenOne = dial; 
    break;

  case 2:
    chosenTwo = dial;
    break;
  }
}

