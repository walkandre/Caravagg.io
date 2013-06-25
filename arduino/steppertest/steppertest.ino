/*************************
This code controls a stepper motor with the EasyDriver board.
***************************/

int dirpin1 = 2;
int steppin1 = 3;

int dirpin2 = 5;
int steppin2 = 6;

int minStepDelay = 5000;

long previousMillis = 0;        // will store last time motor was updated
long currentMillis = 0;

void setup() 
{
  Serial.begin(9600);
  
  pinMode(8,INPUT_PULLUP);  // Input with pullup
  pinMode(13, OUTPUT);      // Use the onboard led
  
  pinMode(dirpin1, OUTPUT);
  pinMode(steppin1, OUTPUT);
  pinMode(dirpin2, OUTPUT);
  pinMode(steppin2, OUTPUT);
  
  randomSeed(analogRead(0));  
}

void loop()
{
  //randomMove();
  
  int sensorValue = digitalRead(8);
  Serial.println(sensorValue);
  if (sensorValue == HIGH) {
    digitalWrite(13, HIGH);
    backAndForthMove();
  } else {
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
  int interval = 5000;

  if (dirLOW) {
    setDirLOW();
  } else {
    setDirHIGH();
  }
  
  previousMillis = currentMillis;
  currentMillis = millis();
  
  while(currentMillis - previousMillis < interval) {
    
    writeStep(steppin1);
    writeStep(steppin2);
    delayMicroseconds(minStepDelay); 
    
    currentMillis = millis();

  }  

  dirLOW = !dirLOW;  
}

/**
 * randomMove
 */
 
void randomMove() 
{
  int r = random(2);
  if (r) {
    setDirLOW();
  } else {
    setDirHIGH();
  }
  
  int s = minStepDelay + random(500);
  
  int interval = random(3000);
  
  previousMillis = currentMillis;
  currentMillis = millis();
  
  while(currentMillis - previousMillis < interval) {
    
    writeStep(steppin1);
    writeStep(steppin2);
    delayMicroseconds(s);      // This delay time is close to top speed for this
                               // particular motor. Any faster the motor stalls.
    
    currentMillis = millis();

  }  
}
