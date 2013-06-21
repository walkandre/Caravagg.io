

PVector LEFT_ANCHOR;
PVector RIGHT_ANCHOR;

PVector C_POSITION;
PVector N_POSITION;

PVector C_DIFF_LEFT;
PVector C_DIFF_RIGHT;

PVector N_DIFF_LEFT;
PVector N_DIFF_RIGHT;


int frame;


void setup() {

  size(1024, 480);
  
  //smooth();
  
  frameRate(30);
  
  LEFT_ANCHOR = new PVector(10, 10);
  RIGHT_ANCHOR = new PVector(width - 10, 10);
  C_POSITION = new PVector(50, 50);
  
  // current position, next position
  C_POSITION = new PVector(width/2, LEFT_ANCHOR.y);
  N_POSITION = new PVector(random(width - 50), random(height - 50));
  
  
  // difference left
  C_DIFF_LEFT = new PVector();
  C_DIFF_LEFT.set(LEFT_ANCHOR);
  C_DIFF_LEFT.sub(C_POSITION);

  // difference right
  C_DIFF_RIGHT = new PVector();
  C_DIFF_RIGHT.set(RIGHT_ANCHOR);
  C_DIFF_RIGHT.sub(C_POSITION);
  
  // next point difference left
  N_DIFF_LEFT = new PVector();
  N_DIFF_LEFT.set(LEFT_ANCHOR);
  N_DIFF_LEFT.sub(N_POSITION);
  
  // next point difference right
  N_DIFF_RIGHT = new PVector();
  N_DIFF_RIGHT.set(RIGHT_ANCHOR);  
  N_DIFF_RIGHT.sub(N_POSITION);
  
  // amount to send to the servos
  float DIFF_LEFT = N_DIFF_LEFT.mag() - C_DIFF_LEFT.mag();
  float DIFF_RIGHT = N_DIFF_RIGHT.mag() - C_DIFF_RIGHT.mag();
  
 
  // CONSTANTS
  float steps = 48;
  float circ = 3 * 10; // mm
  float mm_step = circ / steps;
  
  

  println(DIFF_LEFT);
  float mm_l = map(DIFF_LEFT, 0, width, 0, 3 * (10 * 100));
  float l_steps =  mm_l / mm_step;
  println("mill " +  mm_l);
  println("mill/step " +  mm_step);
  println("steps " + l_steps);
  
  
  println("----");
  
  println(DIFF_RIGHT);
  float mm_r = map(DIFF_RIGHT, 0, width, 0, 3 * (10 * 100));
  float r_steps = mm_r / mm_step;
  println("mill " + mm_r);
  println("mill/step " +  mm_step);
  println("steps " +  r_steps);

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
  
  
  
  // convert pixels to MM. toxi libs to the rescue!!
  // http://toxiclibs.org/docs/core/toxi/math/conversion/UnitTranslator.html

  frame = 0;
  background(0);
}

void draw() {

  

  ellipseMode(RADIUS);
  noStroke();
  fill(255, 0, 0);
  ellipse(C_POSITION.x, C_POSITION.y, 5, 5);
  

  fill(0, 0, 2550);
  ellipse(N_POSITION.x, N_POSITION.y, 5, 5);
  
  
  stroke(0, 255, 0);
  line(LEFT_ANCHOR.x, LEFT_ANCHOR.y, C_POSITION.x, C_POSITION.y);
  line(RIGHT_ANCHOR.x, RIGHT_ANCHOR.y,  C_POSITION.x, C_POSITION.y);
  
  if(frame > 30 * 2) { //2 seconds
    
    frame = 0;
   
  } 
  
  frame++;
}
