/*************************
This code controls a stepper motor with the EasyDriver board.
***************************/

int dirpin1 = 2;
int steppin1 = 3;

int dirpin2 = 5;
int steppin2 = 6;

int minStepDelay = 200;

long previousMillis = 0;        // will store last time motor was updated
long currentMillis = 0;

void setup() 
{
  pinMode(dirpin1, OUTPUT);
  pinMode(steppin1, OUTPUT);
  pinMode(dirpin2, OUTPUT);
  pinMode(steppin2, OUTPUT);
  
  randomSeed(analogRead(0));
}

void loop()
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
