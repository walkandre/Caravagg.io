


void setup() {
  size(1024, 480);
  smooth();
  frameRate(30);
  
}

void draw() {
  background(0);
  
  ellipseMode(RADIUS);
  noStroke();
  fill(255, 0, 0);
  ellipse(50, 50, 5, 5);
  
  
  stroke(0, 255, 0);
  line(0, 0, 50, 50);
  line(width, 0, 50, 50);
  
  
}
