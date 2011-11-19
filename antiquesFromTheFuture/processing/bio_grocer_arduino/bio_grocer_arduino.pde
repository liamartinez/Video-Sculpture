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

Item[] items = new Item[8]; //array size
int dial; 
int chosenOne, chosenTwo;

PFont font; 
int locOneX, locOneY; 

int state; 

int isItOn, wasItOn; 

//--------------------------------------------------------------------------------
void setup () {
  size (500, 500); 


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

  //String[] input = loadStrings("groceries.csv");
  for (int i = 0; i < items.length; i++) {
    items[i] = new Item();
    //String[] splits = input[i].split(",");
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
  locOneX = width/3-100;
  locOneY = height/3;
  chosenOne = 0; 
  chosenTwo = 0;

  isItOn = 0; 
  wasItOn = 0; 

  myPort.bufferUntil('\n');
}

//--------------------------------------------------------------------------------

void draw () {
  background (255); 

  setInit(); //set initial rotation value 

 // println ("inbyte " + inByte);
  //println ("initVal " + initVal); 

  theSwitch (); 
  theDial(); 


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

//void mousePressed () {
void theSwitch () {

  isItOn = bigSwitch; 
  println ("Is it on? " + isItOn); 

  if (isItOn != wasItOn) {
    if (isItOn == 1) {
      if (state < 2) {
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
void theDial () {
  wasItOn = isItOn;

  while (millis () -last > interval) {  // while the current timer is greater than interval
    if (inByte > (initVal + 10)) {     // if the rotation is this much over initial value
      if (dial < (items.length-1)) {    //if dial is at the max number  
        dial ++;                        //go up the dial
      } 
      else {
        dial = 0;                       // loopback to 0
      }
      println ("plus 5");  
      last = millis();                  //reset the timer
    }
    else if (inByte < (initVal - 10)) { // if the rotation is this much less than initial value
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
}

//-------------------------------------------------------------------------------------------------
/*
int serialEvent (Serial myPort) {
 // get the byte:
 inByte = myPort.read(); 
 return inByte;
 }
 
 */

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
      // split the string at the commas
      // and convert the sections into integers:
      int sensors[] = int(split(myString, ','));
/* TRY THIS LATER! LIA
    // Add the latest byte from the serial port to array:
    serialInArray[serialCount] = inByte;
    serialCount++;
*/

      
      // print out the values you got:
       for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
       print("Sensor inside " + sensorNum + ": " + sensors[sensorNum] + "\t"); 
       // add a linefeed after all the sensor values are printed:
       println();
       }
      


      if (sensors.length > 1) {
        inByte = sensors[0]; 
        bigSwitch = sensors[1];
        //println ("inByte " + inByte + " bigSwitch " + bigSwitch);
      }
    }
    // when you've parsed the data you have, ask for more:
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


