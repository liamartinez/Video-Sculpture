SimpleSpreadsheetManager sm;
//String sUrl = "t6mq_WLV5c5uj6mUNSryBIA";

String sUrl = "0AurJ3F3c5fapdGJJZVlsNklsUFVMWW5BNDlTZE05eGc"; 
String googleUser = "sushionthego";
String googlePass = "tortor07185";


import processing.serial.*;

Serial myPort;        
float last, interval; 

int inByte; 
int initVal; 


Item[] items = new Item[8]; 
int dial; 
int chosenOne, chosenTwo;

PFont font; 
int locOneX, locOneY; 

int state; 


//--------------------------------------------------------------------------------
void setup () {
  size (500, 500); 
  
   String[] names = getNumbers("name");
   println (names); 
   String[] prefixes = getNumbers("prefix"); 
   println (prefixes); 
   String[] suffixes = getNumbers ("suffix"); 
   println (suffixes); 
   String[] descriptions = getNumbers ("description"); 
   println (descriptions); 
   

  println(Serial.list());
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  initVal = 0;
  last = millis(); 
  interval = 500;

  smooth(); 
  font = loadFont ("SansSerif-48.vlw"); 
  textFont(font, 48); 

  String[] input = loadStrings("groceries.csv");
  for (int i = 0; i < items.length; i++) {
    items[i] = new Item();
    String[] splits = input[i].split(",");
    items[i].name = names[i]; 
    items[i].prefix = prefixes[i]; 
    items[i].suffix = suffixes[i]; 
    items[i].description = descriptions[i]; 
    //items[i].suffix = splits[2]; 
    //items[i].description = splits[3]; 
    //items[i].name = splits[0]; 
    //items[i].prefix = splits[1]; 
    println (i+ " " + items[i].name);
  }

  state = 0; 
  dial = 0;
  locOneX = width/3;
  locOneY = height/3;
  chosenOne = 0; 
  chosenTwo = 0;
}

//--------------------------------------------------------------------------------

void draw () {
  background (255); 
  setInit(); //set initial rotation value 
  
  println (inByte);
  
  while (millis() -last > interval) {  // while the current timer is greater than interval
    if (inByte == (initVal + 5)) {     // if the rotation is this much over initial value
      if (dial < (items.length-1)) {    //if dial is at the max number  
        dial ++;                        //go up the dial
      } 
      else {
        dial = 0;                       // loopback to 0
      }
      println ("plus 5");  
      last = millis();                  //reset the timer
    }
    else if (inByte == (initVal - 3)) { // if the rotation is this much less than initial value
      if (dial != 0) {                  // if dial is at 0
        dial --;                        // go down the dial
      } 
      else {
        dial = (items.length-1);       //loopback to the max
      }
      println ("minus 3");
      last = millis();                  //reset the timer
    }
  }



  switch (state) {
  
  // 1st item select mode  
  case 0:  
    items[dial].displayName (locOneX, locOneY, false); //blink dictated by true/false
    break; 
    
  //1st item chosen, 2nd item select mode 
  case 1:
    items[chosenOne].displayName (locOneX, locOneY, false); 
    items[dial].displayName (locOneX + 100, locOneY, false); 
    break; 
    
  //both items selected
  case 2: 
    items[chosenOne].displayName (locOneX, locOneY, false); 
    items[chosenTwo].displayName (locOneX + 100, locOneY, false); 

    //combine the prefixes and suffixes
    text ("yay " + items[chosenOne].prefix + items[chosenTwo].suffix + "!!", locOneX, locOneY+30); 
    text ("it " + items[chosenOne].description + " and " + items[chosenTwo].description, locOneX, locOneY+60);
  }
}

//--------------------------------------------------------------------------------

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

//--------------------------------------------------------------------------------

int serialEvent (Serial myPort) {
  // get the byte:
  inByte = myPort.read(); 

  return inByte;
}

//--------------------------------------------------------------------------------

//set initial value if timer is after 3 seconds from startup
void setInit () {
  if ((millis() > 3000) && (initVal == 0)) {
    initVal = inByte;
    dial = 0; 
  }
}

//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------

