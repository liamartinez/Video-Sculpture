#include <SoftwareSerial.h>
#include <Thermal.h>

int printer_RX_Pin = 2;
int printer_TX_Pin = 3;

Thermal printer(printer_RX_Pin, printer_TX_Pin);

String incoming = "";
char * out;

const int switchPin = 2;      // digital input 
const int cardPin = 8;


int sensorValue;
String barcode; 

//average
const int numReadings = 10;

int readings[numReadings];      // the readings from the analog input
int index = 0;                  // the index of the current reading
int total = 0;                  // the running total
int average = 0;                // the average

void setup(){

  printer.feed(); //advance one line 
  Serial.begin(9600);
  Serial.println("setup");

  pinMode(6, OUTPUT);   // set the yellow LED pin to be an output
  //pinMode(7, INPUT);   
  pinMode (cardPin, INPUT); 

  pinMode(switchPin, INPUT);
  establishContact();
  
  for (int thisReading = 0; thisReading < numReadings; thisReading++)
  readings[thisReading] = 0;  
}

void loop(){


  if (digitalRead (cardPin) == HIGH) {
    digitalWrite(6, HIGH);
    //    printer.begin(); 
    //  printer.inverseOn();
    //  printer.print("inverse ON");
    //  printer.inverseOff();  // this adds a line feed
    printer.feed();
    //inverseOn("thank you for your patronage"); 
    printer.println("Cavendish Trebuchet");
    printer.println("GenoTypewriter");
    //inverseOff(); 
    printer.feed();
    printer.println("will-jennings.com");
    printer.println("liamartinez.com");
    printer.feed();
    printer.printBarcode("24901090409", UPC_A);
    printer.feed();
    printer.feed();
    printer.feed();
    printer.feed();
    printer.feed();
    printer.feed();

  }



  if(Serial.available() ){
    int raw = Serial.read();

     if(raw == 1){
      // read the sensor:
      //sensorValue =analogRead(A0);
      
      sensorValue = getAverage (A0); 
      
      // print the results:
      Serial.print(sensorValue, DEC);
      Serial.print(",");

      // read the sensor:
      sensorValue =digitalRead(switchPin);
      // print the last sensor value with a println() so that
      // each set of four readings prints on a line by itself:
      Serial.println(sensorValue, DEC);
    } 
    else if(raw == 2){
      printer.println(out);
      printer.feed();
      //barcode 
      printer.printBarcode("24901090409", UPC_A);
      printer.feed();
      printer.feed();

      printer.feed();
      printer.feed();
      printer.feed();
      printer.feed();
      incoming = "";

    }
    else {
      incoming += (char)raw;
      out = &incoming[0];
    }
  }


}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("hello");   // send a starting message
    delay(300);
  }
}

int getAverage (int inputPin) {
  
    // subtract the last reading:
  total= total - readings[index];         
  // read from the sensor:  
  readings[index] = analogRead(inputPin); 
  // add the reading to the total:
  total= total + readings[index];       
  // advance to the next position in the array:  
  index = index + 1;                    

  // if we're at the end of the array...
  if (index >= numReadings)              
    // ...wrap around to the beginning: 
    index = 0;                           

  // calculate the average:
  average = total / numReadings;  
  
  return average; 
}



