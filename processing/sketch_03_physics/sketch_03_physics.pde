
import controlP5.*;
import traer.physics.*;

ControlP5 controlP5;

ParticleSystem physics;

Particle machine;
Particle left_anchor;
Spring left_spring;

Particle right_anchor;
Spring right_spring;

float drag_var;
float rest_length_left_var;
float rest_length_right_var;

void setup() {
  size(1024, 480);
  smooth();
  fill(0);
  frameRate(30);
  
  drag_var = 1.0;
  rest_length_left_var = (width - 10) / 2;
  rest_length_right_var = (width - 10) / 2;
 
  physics = new ParticleSystem(0.2, drag_var);

  machine = physics.makeParticle(1.0, (width - 10) / 2, 0, 0);

  left_anchor = physics.makeParticle(1.0, 5, 10, 0);
  left_anchor.makeFixed();

  right_anchor = physics.makeParticle(1.0, width - 5, 10, 0);
  right_anchor.makeFixed();
  
  float strength = 1;
  
  println(rest_length_left_var + " " + rest_length_right_var);
  
  // p1, p2, strength, damping, minimum distance 
  left_spring = physics.makeSpring(machine, left_anchor, strength, 1, rest_length_left_var);
  left_spring.setRestLength(rest_length_left_var);
  right_spring = physics.makeSpring(machine, right_anchor, strength, 1, rest_length_right_var);
  right_spring.setRestLength(rest_length_right_var);

  /* gui */
  controlP5 = new ControlP5(this);
  controlP5.addSlider("drag", 0.0f, 1.0f, 5, 400, 100, 20).setValue(drag_var);
  controlP5.addSlider("restlength_left", 0, width-10, 5, 425, 100, 20).setValue(rest_length_left_var);
  controlP5.addSlider("restlength_right", 0, width-10, 5, 450, 100, 20).setValue(rest_length_right_var);
}

void draw() {

  physics.tick();

  background(255, 255, 255, .5);

  line(machine.position().x(), machine.position().y(), left_anchor.position().x(), left_anchor.position().y());
  line(machine.position().x(), machine.position().y(), right_anchor.position().x(), right_anchor.position().y());

  ellipse(machine.position().x(), machine.position().y(), 10, 10);
}

void mousePressed()
{
   //right_spring.setRestLength(300);
}

public void drag(float theValue) {
  drag_var = theValue;
  physics.setDrag(drag_var);
}

public void restlength_right(int theValue) {
  rest_length_left_var = theValue;
  left_spring.setRestLength(rest_length_left_var);
}
public void restlength_left(int theValue) {
  rest_length_right_var = theValue;
  right_spring.setRestLength(rest_length_right_var);
}


