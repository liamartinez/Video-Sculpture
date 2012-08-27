/*

 GenoTypewriter
 Lia Martinez && William Jennings
 
 ITP 2012
 
 */


//google code
SimpleSpreadsheetManager sm;
String sUrl = "0AurJ3F3c5fapdGJJZVlsNklsUFVMWW5BNDlTZE05eGc"; 
String googleUser = "typewritergenie";
String googlePass = "gen0type";

//fullscreen
import fullscreen.*; 
FullScreen fs; 

//serial
import processing.serial.*;
Serial myPort;        
float last, interval; 
boolean firstContact = false; 

//printer
String wawa; 
String header, congrats, product1, product2, combo, total, description, verbage, thanks;  
boolean printed; 

int inByte;  //values from arduino
int initVal; //calibrated initial value
int bigSwitch; //switchpin

Item[] items = new Item[26]; //array size
String[] verbs = new String [5];

int dial; 
int chosenOne, chosenTwo;

//visuals
PImage [] bottoms = new PImage[items.length];
PImage [] tops = new PImage[items.length];
PImage logo; 
PImage receipt; 
PImage coupon; 
PImage welcomePage;
PImage instructionsPage; 
PImage loadingPage; 
int dottedStartX, dottedEndX, dottedStartY, dottedEndY; 
int wordSize, wordLeading, wordDist; 
int loadingTimer; 
int next; 

int startSectionOne, startSectionTwo, startSectionThree; 
StripeBorder stripeBorder; 
AlphabetIndicator alphabet; 
Boxes boxes; 

PFont didot;
PFont didotItalic;
PFont didotBold; 

PFont futuraMedium; 

int locOneX, locOneY; 
int heightFactor; 

int state; 

int isItOn, wasItOn; 
int lastButtonState, buttonState;

int factorForward, factorBackward; 
int oldDial, newDial; 
int lastDial; 
boolean forward; 
boolean switchHit = true; 

boolean mouseOnly; 


int randomItem; 
int itemOneX, itemOneY;
int itemTwoX, itemTwoY; 

//--------------------------------------------------------------------------------
void setup () {
  //size (600, 360); 
  size (1280, 720); 
  smooth(); 

  fs = new FullScreen(this); 

  //get data from the google doc with the titles as string
  String[] names = getNumbers("name");
  String[] prefixes = getNumbers("prefix"); 
  String[] suffixes = getNumbers ("suffix"); 
  String[] descriptions = getNumbers ("description"); 
  String[] price = getNumbers ("price"); 
  String[]actions = getNumbers ("actions"); 

  verbs = getNumbers ("verbs"); 

  println(Serial.list());
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
  last = millis(); 

  didot = loadFont ("Didot-48.vlw");   
  didotItalic = loadFont ("Didot-Italic-48.vlw"); 
  didotBold = loadFont ("Didot-Bold-48.vlw"); 

  futuraMedium = loadFont ("Futura-Medium-48.vlw"); 

  logo = loadImage ("geno_logo.jpg"); 
  receipt = loadImage ("geno_receipt.jpg"); 
  coupon = loadImage ("genotypus.jpg"); 
  instructionsPage = loadImage("selection_screen.jpg"); 
  welcomePage = loadImage ("ad.jpg");
  loadingPage = loadImage ("startup_screen.jpg"); 

  //printer
  printed = false; 

  for (int i = 0; i < items.length; i++) {

    //load the pictures
    tops[i] = loadImage ("top_" + i + ".jpg");
    bottoms[i] = loadImage ("bot_" + i + ".jpg");

    //put them in the object
    items[i] = new Item();
    items[i].name = names[i]; 
    items[i].prefix = prefixes[i]; 
    items[i].suffix = suffixes[i]; 
    items[i].description = descriptions[i]; 
    //items[i].price = float(price[i]); 
    items[i].price = float(price[i]); 
    items[i].picTop = tops[i]; 
    items[i].picBot = bottoms[i]; 
    items[i].action = actions[i]; 
    println (i+ " " + items[i].name);
  }



  stripeBorder = new StripeBorder(); 
  alphabet = new AlphabetIndicator(); 
  boxes = new Boxes(); 
 
  initVal = 0; //calibrated value
  state = 0;   // level 
  dial = 0;    
  locOneX = width/3-100;
  locOneY = height/3;
  heightFactor = 63; 
  chosenOne = 0; 
  chosenTwo = 0;

  isItOn = 0; 
  wasItOn = 0; 
  lastButtonState = 0; 
  buttonState = 0; 

  factorForward = 2;
  factorBackward = 1;  
  interval = 800; //time allowed between changes
  mouseOnly = true; //when using unstable mechanics, make this false to compensate

    dial = 0; 

  println ("***************** GENOTYPEWRITER *********************");
  println ("Will Jennings & Lia Martinez");
  println ("f    enter fullscreen"); 
  println ("F    exit fullscreen");
  println ("r    reset selection");
  println ("m    toggle mouseOnly Mode (default is true)");
  println ("***************** GENOTYPEWRITER *********************");
}

//--------------------------------------------------------------------------------

void draw () {
  background (255); 

  if (!mouseOnly) {
    setInit(); //set initial rotation value 
    //println ("initvalue is " + initVal + " inbyte is " + inByte); 
    theDial();
  }

  theSwitch ();
  displayState();
}




//--------------------------------------------------------------------------------

void theSwitch () {


  isItOn = bigSwitch; 

  if (isItOn != wasItOn) {
    wasItOn = isItOn;

    if (isItOn == 0) {
      if (state < 4) {
        state ++;
      } 
      else {
        state = 1;
      }
    }
  }





  switch (state) {

  case 1: 
    chosenOne = -1; 
    chosenTwo = -1;   

    break; 

  case 2:

    if (chosenOne == -1) {
      println ("chosenOne " + chosenOne); 

      if (dial != 0) {       
        if (!mouseOnly) {
          chosenOne = dial;
          //chosenOne = dial+1; //use when broken
        } 
        else {
          chosenOne = dial;
        }
      } 
      else {
        chosenOne = 0;
      }
    } 

    break;

  case 3:
    if (chosenTwo == -1) {

      if (dial != 0 ) {
        if (!mouseOnly) {
          //chosenTwo = dial+1;
          chosenTwo = dial;
        } 
        else {
          chosenTwo = dial;
        }
      } 
      else {
        chosenTwo = 0;
      }
    } 
    printed = true;
    break;
  }
}

//--------------------------------------------------------------------------------
void theDial () {

  println ("                            " + (inByte - initVal));

  if (millis () -last > interval) {  // while the current timer is greater than interval
    //println (inByte); 
    if (inByte > (initVal + factorForward)) {     // if the rotation is this much over initial value
      //if ((inByte - initVal) > factorForward) {
      println ("dial is: " + dial + items[dial].name); 
      last = millis();                  //reset the timer
      if (dial < (items.length-1)) {    //if dial is at the max number  
        dial ++;        //go up the dial
      } 
      else {
        dial = 0;                       // loopback to 0
      }
      //forward = true;
    }
    if (inByte < (initVal - factorBackward)) { // if the rotation is this much less than initial value
      //if ((initVal - inByte) > factorBackward) {
      last = millis();                  //reset the timer

      if (dial != 0) {                  // if dial is at 0
        dial --;                        // go down the dial
      } 
      else {
        dial = (items.length-1);       //loopback to the max
      }
      //forward = false;
    }
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
        myPort.write(1);       // ask for more
      }
    } 
    // if you have heard from the microcontroller, proceed:
    else {
      int sensors[] = int(split(myString, ','));
      for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
        print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t"); 
        println();
      }
      if (sensors.length > 1) {
        //println ("dial: " + inByte + " switch:" + bigSwitch + " item:" + dial);      
        inByte = sensors[0];
        bigSwitch = sensors[1];
        //println (inByte);
      }
    }
    myPort.write(1);
  }
}
//-------------------------------------------------------------------------------


//set initial value if timer is after 3 seconds from startup
void setInit () {
  if ((millis() > 8000) && (initVal == 0)) {
    initVal = inByte;
    dial = randomItem;
  }
}

//--------------------------------------------------------------------------------

void mouseClicked () {
  //println (mouseX + ","+ mouseY);
}

//--------------------------------------------------------------------------------

void mousePressed() {  
  //thermalPrintString("Congratulations! You pressed the mouse.");

  if (state < 4) {
    state ++;
  } 
  else {
    state = 0;
  }
}
//------------------------------------------------------------------------------

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
  } 

  else if (key == 'f') {
    fs.enter();
  }   
  else if (key == 'F') {
    fs.leave();
  } 
  else if (key == 'r') {
    state = 1; //reset selection
  } 
  else if (key == 'm') {
    if (!mouseOnly) {
      mouseOnly = true;
    } 
    else {
      mouseOnly = false;
    }
  } 
  else if (key == ' ') {

    if (state < 4) {
      state ++;
    } 
    else {
      state = 0;
    }
  }
}
//--------------------------------------------------------------------------------
void thermalPrintString(String toPrint) {
  for (int i = 0; i < toPrint.length(); i++) {
    myPort.write((byte)toPrint.charAt(i));
  }
  //myPort.write((byte)'\n');
  myPort.write(9);
}





