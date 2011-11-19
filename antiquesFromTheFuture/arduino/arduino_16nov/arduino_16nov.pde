const int switchPin = 7;      // digital input 
int sensorValue;

 void setup() {
   // configure the serial connection:
   Serial.begin(9600);
   // configure the digital input:
   pinMode(switchPin, INPUT);
   establishContact();
 }
 
 /*
 void loop() {
   // read the sensor:
   int sensorValue = analogRead(A0);
   // print the results:
   Serial.print(sensorValue);
   Serial.print(",");

   // read the sensor:
   sensorValue = digitalRead(switchPin);
   // print the last reading with a println() so that
   // each set of three readings prints on a line by itself:
   Serial.println(sensorValue);
 }
 */
 
 
 void loop() {
  if (Serial.available() > 0) {
     // read the incoming byte:
    int inByte =Serial.read();
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
 }

 
 
 void establishContact() {
 while (Serial.available() <= 0) {
      Serial.println("hello");   // send a starting message
      delay(300);
   }
 }

