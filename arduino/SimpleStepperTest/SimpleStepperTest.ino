/*************************
This code controls a stepper motor with the EasyDriver board.
***************************/

int switchPin = 8; // On/off switch for the motor test
int onboardLedPin = 13;

int dirpin1 = 2;
int steppin1 = 3;

int dirpin2 = 5;
int steppin2 = 6;

int minStepDelay = 5000;
int minStepInterval = 5000;

long previousMillis = 0;        // will store last time motor was updated
long currentMillis = 0;

void setup() 
{
  Serial.begin(57600);
  
  pinMode(switchPin, INPUT_PULLUP); // Input with pullup
  pinMode(onboardLedPin, OUTPUT);   // Use the onboard led
  
  pinMode(dirpin1, OUTPUT);
  pinMode(steppin1, OUTPUT);
  pinMode(dirpin2, OUTPUT);
  pinMode(steppin2, OUTPUT);
   
}

void loop()
{
  
  int sensorValue = digitalRead(switchPin);
  
  Serial.print("sensorValue = ");
  Serial.println(sensorValue);
  
  if (sensorValue == HIGH) {
    Serial.println("HIGH");
    digitalWrite(13, HIGH);
    backAndForthMove();
  } else {
    Serial.println("LOW");
    digitalWrite(13, LOW);
  }
  
  
}

void setDirLOW()
{
  digitalWrite(dirpin1, LOW);     // Set the direction.
  digitalWrite(dirpin2, LOW);
  delay(100);
}

void setDirHIGH()
{
  digitalWrite(dirpin1, HIGH);    // Change direction.
  digitalWrite(dirpin2, HIGH);
  delay(100);
}  

void writeStep(int pin) 
{
    digitalWrite(pin, LOW);  // This LOW to HIGH change is what creates the
    digitalWrite(pin, HIGH); // "Rising Edge" so the easydriver knows to when to step.
}

/**
 * BackAndForthMove
 */
 
boolean dirLOW = true;

void backAndForthMove() {

  if (dirLOW) {
    setDirLOW();
  } else {
    setDirHIGH();
  }
  
  previousMillis = currentMillis;
  currentMillis = millis();
  
  while(currentMillis - previousMillis < minStepInterval) {
    
    writeStep(steppin1);
    writeStep(steppin2);
    delayMicroseconds(minStepDelay); 
    
    currentMillis = millis();

  }  

  dirLOW = !dirLOW;  
}

