const int numReadings = 30;

int readings[numReadings];      // the readings from the analog input
int index = 0;                  // the index of the current reading
int total = 0;                  // the running total
int average = 0;                // the average

int analogValue = 0;        // value read from the pot
int turn = 0;         

void setup() {

  Serial.begin(9600); 
  for (int thisReading = 0; thisReading < numReadings; thisReading++)
    readings[thisReading] = 0;  

}

void loop() {
    // subtract the last reading:
  total= total - readings[index];     

  analogValue = analogRead(A0);      // read the pot value
  turn = analogValue /4;             //divide by 4 to fit in a byte
  
  // read from the sensor:  
  readings[index] = turn;
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


  Serial.write(average);        // print the brightness value back to the serial monitor
}


