/**
 * Simple Write. 
 * 
 * Check if the mouse is over a rectangle and writes the status to the serial port. 
 * This example works with the Wiring / Arduino program that follows below.
 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;        // Data received from the serial port

void setup() 
{
  size(200, 200);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void draw() {
        // Draw a square
}

void thermalPrintString(String toPrint){
  for(int i = 0; i < toPrint.length(); i++){
    myPort.write((byte)toPrint.charAt(i));
  }
  myPort.write((byte)'\n');
}

void mousePressed(){

  thermalPrintString("I am the string");
}

void keyPressed(){
  //println(key);
  //println(key == '\n');
  
 // myPort.write((byte)key);
  
  
}

void serialEvent(Serial p){
  println(myPort.read());
}
