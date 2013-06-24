

PVector LEFT_ANCHOR;
PVector RIGHT_ANCHOR;

PVector C_POSITION;
PVector N_POSITION;


/* CONSTANTS */
float STEPS = 48; // per rotation.
float CIRC = 3 * 10; // mm circunference.
float STEPS_MM = CIRC / STEPS; // steps per revolution.


void setup() {

  size(1024, 480);
  smooth();
  frameRate(30);

  LEFT_ANCHOR = new PVector(10, 10);
  RIGHT_ANCHOR = new PVector(width - 10, 10);
  C_POSITION = new PVector(50, 50);

  // current position, next position
  C_POSITION = new PVector(width/2, LEFT_ANCHOR.y);
  N_POSITION = new PVector(random(width - 50), random(height - 50));

  // amount to send to the servos
  float diff_left = calculateSteps(LEFT_ANCHOR, C_POSITION, N_POSITION);
  float diff_right = calculateSteps(RIGHT_ANCHOR, C_POSITION, N_POSITION);

  // convert pixels to MM. reference:
  // http://toxiclibs.org/docs/core/toxi/math/conversion/UnitTranslator.html

  // mapping pixels to millimeters
  float mm_l = map(diff_left, 0, width, 0, 3 * (10 * 100));
  float STEPS_LEFT =  mm_l / STEPS_MM;
  
  // mapping pixels to millimeters
  float mm_r = map(diff_right, 0, width, 0, 3 * (10 * 100));
  float STEPS_RIGHT = mm_r / STEPS_MM;

  println(diff_left + " - " + diff_right);
  println("----");
  println("mill " +  mm_l);
  println("mill/step " +  STEPS_MM);
  println("steps " + STEPS_LEFT);
  println("----");
  println("mill " + mm_r);
  println("mill/step " +  STEPS_MM);
  println("steps " +  STEPS_RIGHT);

/*
  float _max = max(abs(l_steps), abs(r_steps));
  float _min = min(abs(l_steps), abs(r_steps));

  float ratio = _min / _max;

  println("ratio " + ratio);
  
  float counter = 0.0;
  
  int len = int(_max);
  
  for(float i = 0; i < len; i++) {
    if(counter > 1) {
      counter = counter-1;
      _min--;
    }
    counter += ratio;
    _max--;
    println(i + " " + counter + " " + _max + " " + _min);
  }
*/
  
  ellipseMode(RADIUS);
}

void draw() {
  
  background(255);

  stroke(0, 255, 0, 50);
  line(LEFT_ANCHOR.x, LEFT_ANCHOR.y, C_POSITION.x, C_POSITION.y);
  line(RIGHT_ANCHOR.x, RIGHT_ANCHOR.y,  C_POSITION.x, C_POSITION.y);
  
  noStroke();
  fill(255, 0, 0);
  ellipse(C_POSITION.x, C_POSITION.y, 5, 5);

  fill(0, 0, 255);
  ellipse(N_POSITION.x, N_POSITION.y, 5, 5);
}

void mousePressed()
{
  N_POSITION.set(mouseX, mouseY);
}
