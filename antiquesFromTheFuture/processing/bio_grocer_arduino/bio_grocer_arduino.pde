//google code
SimpleSpreadsheetManager sm;
String sUrl = "0AurJ3F3c5fapdGJJZVlsNklsUFVMWW5BNDlTZE05eGc"; 
String googleUser = "typewritergenie";
String googlePass = "gen0type";

//serial
import processing.serial.*;
Serial myPort;        
float last, interval; 
boolean firstContact = false; 

int inByte;  //values from arduino
int initVal; //calibrated initial value
int bigSwitch; //switchpin

Item[] items = new Item[40]; //array size
int dial; 
int chosenOne, chosenTwo;

//visuals
PImage [] bottoms = new PImage[items.length];
PImage [] tops = new PImage[items.length];
PImage logo; 

PFont didot;
PFont didotItalic;

int locOneX, locOneY; 
int heightFactor; 

int state; 

int isItOn, wasItOn; 

int factorForward, factorBackward; 
int oldDial, newDial; 
int lastDial; 
boolean forward; 

int randomItem; 
int itemOneX, itemOneY;
int itemTwoX, itemTwoY; 

//--------------------------------------------------------------------------------
void setup () {
  size (800, 480); 
  

  //get data from the google doc with the titles as string
  String[] names = getNumbers("name");
  String[] prefixes = getNumbers("prefix"); 
  String[] suffixes = getNumbers ("suffix"); 
  String[] descriptions = getNumbers ("description"); 
  String[] price = getNumbers ("price"); 

  println(Serial.list());
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
  initVal = 0;
  last = millis(); 

  smooth(); 
  didot = loadFont ("Didot-48.vlw");   
  didotItalic = loadFont ("Didot-Italic-48.vlw"); 
  textFont(didot, 48); 
  logo = loadImage ("geno_logo.jpg"); 

  for (int i = 0; i < items.length; i++) {
    tops[i] = loadImage ("top_" + i + ".jpg");
    bottoms[i] = loadImage ("bot_" + i + ".jpg");
  }
  

  for (int i = 0; i < items.length; i++) {
    items[i] = new Item();
    items[i].name = names[i]; 
    items[i].prefix = prefixes[i]; 
    items[i].suffix = suffixes[i]; 
    items[i].description = descriptions[i]; 
    items[i].price = float(price[i]); 
    items[i].picTop = tops[i]; 
    items[i].picBot = bottoms[i]; 
    println (i+ " " + items[i].name);
  }

  state = 0; 
  dial = 0; 
  locOneX = width/3-100;
  locOneY = height/3;
  chosenOne = 0; 
  chosenTwo = 0;

  isItOn = 0; 
  wasItOn = 0; 

  factorForward = 5;
  factorBackward = 5;  
  interval = 500;
  heightFactor = 63; 

  randomItem = int(random(0, items.length));
}

//--------------------------------------------------------------------------------

void draw () {
  background (255); 
  imageMode (CORNER); 
  image (logo, 0,0); 

  //image (items[dial].picTop, 0, 0);
  setInit(); //set initial rotation value 

  println ("initvalue is " + initVal + " inbyte is " + inByte); 

  theDial();
  println ("dial number " + dial); 
  theSwitch (); 

  imageMode (CENTER); 
  displayState();
}


//--------------------------------------------------------------------------------
void displayState () {

  switch (state) {

  case 0:  
    //choose the first
    textAlign (CENTER); 

    //animateDial(height/2 - heightFactor, true);  //the height is the only variable you need to change
    //lastDial = dial; 
    
    //items[randomItem].displayName (width/2, height/2 + 15, false); 
    items[dial].displayPicTop (width/2, (height/2 - heightFactor) +60 , true); 
    items[dial].displayName (width/2 - 200,  (height/2-5) +60 , true); 
    
    items[randomItem].displayPicBot (width/2, (height/2 + heightFactor) + 60, false); 
    items[randomItem].displayName (width/2 + 200, (height/2+30) + 60, false); 

    break; 

  case 1:
    //first chosen, choose the second
    //items[chosenOne].displayName (width/2, height/2 - 15, false); 
    items[chosenOne].displayPicTop (width/2 - 200, (height/2 - heightFactor) + 60, false); 
    //animateDial(height/2 + heightFactor, false); 
    items[dial].displayPicBot (width/2 + 200, (height/2 + heightFactor) + 60, true); 

    break; 

  case 2: 
    //first chosen, second chosen
    //items[chosenOne].displayName (width/2, height/2 - 15, false); 
    //items[chosenTwo].displayName (width/2, height/2 + 15, false); 

    items[chosenOne].displayPicTop (width/2 - 200, (height/2 - heightFactor) + 60, false); 
    items[chosenTwo].displayPicBot (width/2 + 200, (height/2 + heightFactor) + 60, false); 

    textAlign (LEFT); 
    text ("hit the lever to continue", locOneX, locOneY + 300); 

    break;

  case 3:
    //last page

    textSize (20); 
    textAlign (CENTER); 
    text (items[chosenOne].name + " : " + items[chosenOne].price, locOneX, locOneY - 60);
    text (items[chosenTwo].name + " : " + items[chosenTwo].price, locOneX, locOneY - 30); 
    textAlign (LEFT); 
    text ("you got a " + items[chosenOne].prefix + items[chosenTwo].suffix, locOneX, locOneY+30); 
    text ("total cost: " + (items[chosenOne].price + items[chosenTwo].price), locOneX, locOneY+60); 
    text ("it is " + items[chosenOne].description + " and " + items[chosenTwo].description, locOneX, locOneY+90); 

    dial = int(random (0, items.length)); 
    break;
  }
}


// ------------------------------------------------------------------------------

void animateDial (int heightVar_, boolean onTop_) {

  //if the dial is going forward do this
  if (forward == true) {
    items[dial].animateEntry( heightVar_, onTop_); 
    if ((dial-1) > 0) {              
      items[dial-1].animateExit( heightVar_, onTop_ );
    } 
    else {
      items[items.length-1].animateExit( heightVar_, onTop_); //if the dial is less than 0, then loopback to the end
    }
    //println ("forward!");
  } 
  //if the dial is going backwards do this
  else {
    items[dial].animateEntryBackward( heightVar_, onTop_); 
    if ((dial + 1) < items.length-1) { 
      items[dial+1].animateExitBackward( heightVar_, onTop_);
    } 
    else {
      items[0].animateExitBackward( heightVar_, onTop_);      //if the dial is greater than the maximum, loop back to the beginning
    }
    //println ("backward");
  }
}

//--------------------------------------------------------------------------------

void theSwitch () {

  isItOn = bigSwitch; 

  if (isItOn != wasItOn) {
    if (isItOn == 1) {
      if (state < 3) {
        state ++;
      } 
      else {
        state = 0;
      }
    }
  }

  wasItOn = isItOn;

  switch (state) {
  case 0: 
    chosenOne = -1; 
    chosenTwo = -1;    
    break; 

  case 1:
    if (chosenOne == -1) {
      chosenOne = dial;
    } 
    break;

  case 2:
    if (chosenTwo == -1) {
      chosenTwo = dial;
    } 
    break;
  }
}

//--------------------------------------------------------------------------------
void theDial () {

  while (millis () -last > interval) {  // while the current timer is greater than interval
    if (inByte > (initVal + factorForward)) {     // if the rotation is this much over initial value
      //if ((inByte - initVal) > factorForward) {
      if (dial < (items.length-1)) {    //if dial is at the max number  
        dial ++;        //go up the dial
        println ("                                   move forward");
      } 
      else {
        dial = 0;                       // loopback to 0
        println ("                                   move forward");
      }
      // last = millis();                  //reset the timer
      forward = true;
    }
    else if (inByte < (initVal - factorBackward)) { // if the rotation is this much less than initial value
      //if ((initVal - inByte) > factorBackward) {
      if (dial != 0) {                  // if dial is at 0
        dial --;                        // go down the dial
        println ("                                         move backward");
      } 
      else {
        dial = (items.length-1);       //loopback to the max
        println ("                                         move backward");
      }
      forward = false;
      // last = millis();                  //reset the timer
    }
    last = millis();                  //reset the timer
  }
}


//-------------------------------------------------------------------------------
// this is from tom igoe's second serial lab
void serialEvent(Serial myPort) { 
  // read the serial buffer:
  String myString = myPort.readStringUntil('\n');
  // if you got any bytes other than the linefeed:
  if (myString != null) {
    myString = trim(myString);
    // if you haven't heard from the microncontroller yet, listen:
    if (firstContact == false) {
      if (myString.equals("hello")) { 
        myPort.clear();          // clear the serial port buffer
        firstContact = true;     // you've had first contact from the microcontroller
        myPort.write('A');       // ask for more
      }
    } 
    // if you have heard from the microcontroller, proceed:
    else {
      int sensors[] = int(split(myString, ','));
      for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
        //print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t"); 
        println();
      }
      if (sensors.length > 1) {
        inByte = sensors[0]; 
        bigSwitch = sensors[1];
      }
    }
    myPort.write("A");
  }
}


//--------------------------------------------------------------------------------

//set initial value if timer is after 3 seconds from startup
void setInit () {
  if ((millis() > 8000) && (initVal == 0)) {
    initVal = inByte;
    dial = randomItem;
  }
}

//--------------------------------------------------------------------------------

