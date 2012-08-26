#include <SoftwareSerial.h>
#include <Thermal.h>

int printer_RX_Pin = 2;
int printer_TX_Pin = 3;

Thermal printer(printer_RX_Pin, printer_TX_Pin);

String incoming = "";
char * out;

const int switchPin = 7;      // digital input 
const int cardPin = 8;


int sensorValue;
String barcode; 


void setup(){

  printer.feed(); //advance one line 
  Serial.begin(9600);
  Serial.println("setup");

  pinMode(6, OUTPUT);   // set the yellow LED pin to be an output
  //pinMode(7, INPUT);   
  pinMode (cardPin, INPUT); 

  pinMode(switchPin, INPUT);
  establishContact();
}

void loop(){
  
  if (digitalRead(7) == HIGH) {
    // if the switch is closed:
    digitalWrite(6, HIGH);    // turn on the yellow LED

  } 
  else {
    // if the switch is open:
    digitalWrite(6, LOW);     // turn off the yellow LED
  }
  
  if (digitalRead (cardPin) == HIGH) {
    digitalWrite(6, HIGH);
  printer.feed();
  inverseOn(); 
  printer.println("Cavendish Trebuchet");
  printer.println("GenoTypewriter");
  inverseOff(); 
  printer.feed();
  printer.println("will-jennings.com");
  printer.println("liamartinez.com");
  printer.feed();
  printer.printBarcode("24901090409", UPC_A);
  printer.feed();
  printer.feed();
  printer.feed();
  
  }
  


  if(Serial.available()){
    int raw = Serial.read();
    if(raw == 1){
      // read the sensor:
      sensorValue =analogRead(A0);
      // print the results:
      Serial.print(sensorValue, DEC);
      Serial.print(",");

      // read the sensor:
      sensorValue =digitalRead(switchPin);
      // print the last sensor value with a println() so that
      // each set of four readings prints on a line by itself:
      Serial.println(sensorValue, DEC);
    } 
    else {

      char in = (char)raw;
      if(in == '2'){
        printer.println(out);
        printer.feed();
        //barcode 
        printer.printBarcode("24901090409", UPC_A);
        printer.feed();
        printer.feed();
        incoming = "";
        printer.feed();
        printer.feed();

      }
      else {
        incoming += in;
        out = &incoming[0];
      }
    }
  }
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("hello");   // send a starting message
    delay(300);
  }
}




