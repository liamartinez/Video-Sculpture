import processing.serial.*;

Serial myPort;        
float xPos = 0;     

float last, interval; 

int inByte; 
int initVal; 


void setup () {
  size(800, 600);   
  println(Serial.list());
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  initVal = 0;
  last = millis(); 
  interval = 1000;
}


void draw () {

  if ((millis() > 3000) && (initVal == 0)) {
    initVal = inByte;
  }


 if (millis()-last > interval) {
    if (inByte == (initVal + 5)) {
      println ("plus 5");  
      last = millis();
    } 
    else if (inByte == (initVal - 2)) {
      println ("minus 2");
      last = millis();
    }
  }

  
  //println ("initval" + initVal);
  //println ("inByte" + inByte);
}


int serialEvent (Serial myPort) {
  // get the byte:
  inByte = myPort.read(); 

  return inByte;
}

void turn () {
  
 

}
