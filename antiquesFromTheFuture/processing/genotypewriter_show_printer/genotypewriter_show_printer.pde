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

Item[] items = new Item[40]; //array size
String[] verbs = new String [5];

int dial; 
int chosenOne, chosenTwo;

//visuals
PImage [] bottoms = new PImage[items.length];
PImage [] tops = new PImage[items.length];
PImage logo; 
PImage receipt; 
PImage coupon; 
int dottedStartX, dottedEndX, dottedStartY, dottedEndY; 
int wordSize, wordLeading, wordDist; 

PFont didot;
PFont didotItalic;
PFont didotBold; 

int locOneX, locOneY; 
int heightFactor; 

int state; 

int isItOn, wasItOn; 

int factorForward, factorBackward; 
int oldDial, newDial; 
int lastDial; 
boolean forward; 
boolean switchHit = true; 

int randomItem; 
int itemOneX, itemOneY;
int itemTwoX, itemTwoY; 

//--------------------------------------------------------------------------------
void setup () {
  size (610, 370); 
  smooth(); 

  fs = new FullScreen(this); 
  // enter fullscreen mode
  //fs.enter(); 

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

  logo = loadImage ("geno_logo.jpg"); 
  receipt = loadImage ("geno_receipt.jpg"); 
  coupon = loadImage ("genotypus.jpg"); 

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
    items[i].price = price[i]; 
    items[i].picTop = tops[i]; 
    items[i].picBot = bottoms[i]; 
    items[i].action = actions[i]; 
    println (i+ " " + items[i].name);
  }

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

  factorForward = 9;
  factorBackward = 9;  
  interval = 600; //time allowed between changes

  // randomItem = int(random(0, items.length)); //move this somewhere else - remember condom
}

//--------------------------------------------------------------------------------

void draw () {
  background (255); 

  setInit(); //set initial rotation value 


  //println ("initvalue is " + initVal + " inbyte is " + inByte); 

  theDial();
  theSwitch (); 


  displayState();
}


//--------------------------------------------------------------------------------
void displayState () {

  switch (state) {

  case 0:  
    //choose the first

    textAlign (CENTER);
    textFont(didot, 48); 
    imageMode (CORNER);  
    image (logo, 0, 0, width, height/3);

    imageMode (CENTER); 
    items[dial].displayPicTop (width/2, (height/2 - heightFactor) +60, true); 
    items[dial].displayName (width/2 - 200, (height/2-5) +60, true); 

    //items[randomItem].displayPicBot (width/2, (height/2 + heightFactor) + 60, false); 
    //items[randomItem].displayName (width/2 + 200, (height/2+30) + 60, false); 

    textAlign (LEFT); 
    textSize (25); 
    text ("Use the DIAL to pick a thing. Then hit the LEVER", locOneX-50, locOneY + 250); 
    break; 

  case 1:

    textAlign (CENTER);
    imageMode (CORNER);
    image (logo, 0, 0, width, height/3);

    imageMode (CENTER);
    items[chosenOne].displayPicTop (width/2, (height/2 - heightFactor) +60, false); 
    items[chosenOne].displayName (width/2 - 200, (height/2-5) +60, false); 

    items[dial].displayPicBot (width/2, (height/2 + heightFactor) + 60, true); 
    items[dial].displayName (width/2 + 200, (height/2+30) + 60, true); 

    textAlign (LEFT); 
    textSize (25); 
    text ("Pick another thing, then hit the lever.", locOneX-50, locOneY + 250); 

    break; 

  case 2: 

    textAlign (CENTER);
    imageMode (CORNER);
    image (logo, 0, 0, width, height/3);

    imageMode (CENTER);
    items[chosenOne].displayPicTop (width/2, (height/2 - heightFactor) +60, false); 
    items[chosenOne].displayName (width/2 - 200, (height/2-5) +60, false); 

    items[chosenTwo].displayPicBot (width/2, (height/2 + heightFactor) + 60, false); 
    items[chosenTwo].displayName (width/2 + 200, (height/2+30) + 60, false); 

    textAlign (LEFT); 
    textSize (30); 
    text ("Hit the lever to get your receipt", locOneX-50, locOneY + 250); 

    break;

  case 3:
    //last page
    dottedStartX = 280; 
    dottedStartY = 140; 
    dottedEndX = 560; 
    wordSize = 15; 
    wordLeading = 20; 
    wordDist = 20; 

    textAlign (LEFT);

    imageMode (CORNER);
    image (receipt, 0, 0);
    textSize (wordSize); 

    text (items[chosenOne].name, dottedStartX, dottedStartY);
    text (items[chosenTwo].name, dottedStartX, dottedStartY + wordDist); 
    text ("Style Fee", dottedStartX, dottedStartY + wordDist*2); 

    text ("Coupon Code", dottedStartX, dottedStartY + wordDist*4); 
    imageMode (CENTER);
    image (coupon, dottedStartX + 140, dottedStartY + (wordDist*4)-5); 
    imageMode (CORNER);

    textFont(didotItalic, wordSize); 
    textLeading (wordLeading); 
    textAlign (CENTER);
    text ("..................................", dottedStartX, dottedStartY + wordDist*5, 240, 500);
    textAlign (LEFT);
    textFont(didotBold,15); 
    text ("Our deepest Congratulations! It’s a " + items[chosenOne].prefix + items[chosenTwo].suffix + "!", dottedStartX, dottedStartY + wordDist*6, 240, 500); 
    //textFont(didotItalic, wordSize); 
    // text ("     It is " + items[chosenOne].description + " and " + items[chosenTwo].description + ", and will probably " + verbs[0] + " " + items[chosenOne].action + " and " + items[chosenTwo].action + " with you.", dottedStartX,  dottedStartY + wordDist*8, 240, 500); 
    text ("     It is " + items[chosenOne].description + " and " + items[chosenTwo].description, dottedStartX, dottedStartY + wordDist*8, 240, 500); 

    textFont(didotItalic, wordSize - 3); 
    //text (" Your pup will arrive in approx. 5 minutes in your local bio tube repository.", dottedStartX, dottedStartY + wordDist*13, 240, 500); 

    //textLeading (wordLeading-5); 
    //text (" Need faster imprinting? Register today with our DNA play for quick impression between pup & parent. Also look for our new intelligence plus GenoTypewriter coming out next fall with a full featured intelligence augmenter! Upload your intelligence into your next " + items[chosenOne].prefix + items[chosenTwo].suffix + "!", dottedStartX, dottedStartY + wordDist*13, 240, 500); 
    textAlign(RIGHT); 
    textFont(didotItalic, wordSize); 
    text ( " .................  $ " + items[chosenOne].price, dottedStartX + 240, dottedStartY);
    text ( " .................  $ " + items[chosenTwo].price, dottedStartX + 240, dottedStartY + wordDist); 
    text (  " ..........................  $ " + "% 10.00", dottedStartX + 240, dottedStartY  + wordDist*2); 
    text ("Total $" + (items[chosenOne].price + items[chosenTwo].price), 620, dottedStartY + wordDist*5); 

    dial = int(random (0, items.length)); 


    //prepare the text for the printer
    header = "******GENOTYPEWRITER*********"; 
    congrats = "Our deepest Congratulations!"; 
    combo = "It’s a " + items[chosenOne].prefix + items[chosenTwo].suffix + "!"; 
    product1 = items[chosenOne].name + " .........  $ " + items[chosenOne].price;
    product2 = items[chosenTwo].name + " .........  $ " + items[chosenTwo].price;
    //total = " ....... Total $" + (items[chosenOne].price + items[chosenTwo].price); 
    description = "     It is " + items[chosenOne].description + " and " + items[chosenTwo].description + "." ;
    verbage = "It will enjoy " + items[chosenOne].action + " and " + items[chosenTwo].action + " with you.";
    thanks = " Your pup will arrive in approx. 5 minutes in your local bio tube repository.";

    if (printed) {
      printed = false; 
      thermalPrintString(header + (char)'\n' + congrats + (char)'\n' + combo + (char)'\n'+ product1 + (char)'\n' + product2 + (char)'\n' +description + (char)'\n' + verbage + (char)'\n'+ thanks);
    }

    break;
  }
}



//--------------------------------------------------------------------------------

void theSwitch () {

  isItOn = bigSwitch; 

 // if (switchHit) {
    switchHit = false; 
    if (isItOn != wasItOn) {
      wasItOn = isItOn;
      println ("SWITCH"); 
      if (isItOn == 1) {
        if (state < 3) {
          state ++;
        } 
        else {
          state = 0;
           switchHit = true; 
        }
      }
   // }
  }




  switch (state) {
  case 0: 
    chosenOne = -1; 
    chosenTwo = -1;   
    switchHit = true; 

    break; 

  case 1:

    if (chosenOne == -1) {
//chosenOne = dial;

/*
            if (dial > 0) {
              chosenOne = dial-1;
            } else {
              chosenOne = items.length-1;
          }
          
*/

if (dial < items.length-1) {
  chosenOne = dial+1;
} else {
  chosenOne = 0; 
}
      
    } 
    switchHit = true;
    break;

  case 2:




    //thermalPrintString(wawa + wawa); 
    
    if (chosenTwo == -1) {
      //chosenTwo = dial;   
   /*
                   if (dial > 0) {
            chosenTwo = dial-1;
          } else {
            chosenTwo = items.length-1;
          }   
          
      */
      
      if (dial < items.length-1) {
  chosenTwo = dial+1;
} else {
  chosenTwo = 0; 
}
     
    } 
    printed = true;
    switchHit = true; 
    break;
  }
}

//--------------------------------------------------------------------------------
void theDial () {

  if (millis () -last > interval) {  // while the current timer is greater than interval
    println (inByte); 
    if (inByte > (initVal + factorForward)) {     // if the rotation is this much over initial value
      //if ((inByte - initVal) > factorForward) {
      println("********************************************things are changing"); 
      println ("dial is: " + dial + items[dial].name); 
      last = millis();                  //reset the timer
      if (dial < (items.length-1)) {    //if dial is at the max number  
        dial ++;        //go up the dial
        println ("dial from inside                  " + dial); 
        println ("                                   move forward");
      } 
      else {
        dial ++;        //go up the dial
        println ("dial from inside                  " + dial); 
        dial = 0;                       // loopback to 0
        println ("                                   move forward");
      }
      //forward = true;
    }
    if (inByte < (initVal - factorBackward)) { // if the rotation is this much less than initial value
      //if ((initVal - inByte) > factorBackward) {

      println ("dial is: " + dial); 
      println ("***************backwards is happening"); 
      last = millis();                  //reset the timer
      if (dial != 0) {                  // if dial is at 0
        dial --;                        // go down the dial
        println ("                                         move backward");
      } 
      else {
        dial = (items.length-1);       //loopback to the max
        println ("                                         move backward");
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
        //print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t"); 
        //println();
      }
      if (sensors.length > 1) {     
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
  println (mouseX + ","+ mouseY);
}

void mousePressed() {


  thermalPrintString("Congratulations! You pressed the mouse.");
}
//------------------------------------------------------------------------------

void keyPressed () {
  if (key == 'f') {
    fs.enter();
  } 
  else if (key == 'r') {

    state = 0;
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

