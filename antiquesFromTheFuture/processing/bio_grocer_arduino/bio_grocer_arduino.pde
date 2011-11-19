//google code
SimpleSpreadsheetManager sm;
String sUrl = "0AurJ3F3c5fapdGJJZVlsNklsUFVMWW5BNDlTZE05eGc"; 
String googleUser = "sushionthego";
String googlePass = "tortor07185";

//serial
import processing.serial.*;
Serial myPort;        
float last, interval; 
boolean firstContact = false; 

int inByte;  //values from arduino
int initVal; //calibrated initial value
int bigSwitch; //switchpin

Item[] items = new Item[25]; //array size
int dial; 
int chosenOne, chosenTwo;

PFont font; 
int locOneX, locOneY; 

int state; 

int isItOn, wasItOn; 

int factor; 
int oldDial, newDial; 

//--------------------------------------------------------------------------------
void setup () {
  size (500, 500); 

  //get data from the google doc with the titles as string
  String[] names = getNumbers("name");
  String[] prefixes = getNumbers("prefix"); 
  String[] suffixes = getNumbers ("suffix"); 
  String[] descriptions = getNumbers ("description"); 

  println(Serial.list());
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  initVal = 0;
  last = millis(); 
  interval = 500;

  smooth(); 
  font = loadFont ("SansSerif-48.vlw"); 
  textFont(font, 48); 

  for (int i = 0; i < items.length; i++) {
    items[i] = new Item();
    items[i].name = names[i]; 
    items[i].prefix = prefixes[i]; 
    items[i].suffix = suffixes[i]; 
    items[i].description = descriptions[i]; 
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

  myPort.bufferUntil('\n');
  
  factor = 5; 
}

//--------------------------------------------------------------------------------

void draw () {
  background (255); 

  setInit(); //set initial rotation value 

  theSwitch (); 
  theDial(); 

  displayState(); 
  println ("state is " + state + " chosenOne is " + chosenOne + " chosenTwo is " + chosenTwo); 
  
  
}


//--------------------------------------------------------------------------------
 void displayState () {
 switch (state) {

  case 0:  
    items[dial].displayName (locOneX, locOneY, true); 
    items[dial].animateEntry(); 

    break; 

  case 1:
    items[chosenOne].displayName (locOneX, locOneY, false); 
    items[dial].displayName (locOneX + 200, locOneY, true); 
    items[dial].animateEntry(); 
 
    break; 

  case 2: 
    items[chosenOne].displayName (locOneX, locOneY, false); 
    items[chosenTwo].displayName (locOneX + 200, locOneY, false); 
    
    text ("hit the lever to continue", locOneX, locOneY + 300); 
    
    break;
    
  case 3:
    //combine the prefixes and suffixes
    text ("you got a " + items[chosenOne].prefix + items[chosenTwo].suffix + "!!", locOneX, locOneY+30); 
    text ("it " + items[chosenOne].description + " and " + items[chosenTwo].description, locOneX, locOneY+60); 
    text ("it costs this much", locOneX, locOneY + 120); 
    break;
    

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
    if (chosenOne == -1){
    chosenOne = dial; 
    } break;

  case 2:
    if (chosenTwo == -1) {
    chosenTwo = dial;
    } break;
  }
}

//--------------------------------------------------------------------------------
void theDial () {

  while (millis () -last > interval) {  // while the current timer is greater than interval
    if (inByte > (initVal + factor)) {     // if the rotation is this much over initial value
      if (dial < (items.length-1)) {    //if dial is at the max number  
        dial ++;        //go up the dial 
      } 
      else {
        dial = 0;                       // loopback to 0
      }
      println ("move forward");  
    }
    else if (inByte < (initVal - factor)) { // if the rotation is this much less than initial value
      if (dial != 0) {                  // if dial is at 0
        dial --;                        // go down the dial
      } 
      else {
        dial = (items.length-1);       //loopback to the max
      }
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
  if ((millis() > 3000) && (initVal == 0)) {
    initVal = inByte;
    dial = 0;
  }
}

//--------------------------------------------------------------------------------


