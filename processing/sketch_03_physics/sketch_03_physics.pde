
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

ArrayList<Vector3D> positions;

void setup() {
  size(1024, 480);
  smooth();
  frameRate(30);
  
  drag_var = 1.0;
  rest_length_left_var = (width - 10) / 2;
  rest_length_right_var = (width - 10) / 2;
 
  physics = new ParticleSystem(0.9, drag_var);

  machine = physics.makeParticle(0.5, (width - 10) / 2, 10, 0);

  left_anchor = physics.makeParticle(1.0, 5, 10, 0);
  left_anchor.makeFixed();

  right_anchor = physics.makeParticle(1.0, width - 5, 10, 0);
  right_anchor.makeFixed();
  
  float strength = 0.5;

  // p1, p2, strength, damping, minimum distance 
  left_spring = physics.makeSpring(machine, left_anchor, strength, 0.05, rest_length_left_var);
  left_spring.setRestLength(rest_length_left_var);
  right_spring = physics.makeSpring(machine, right_anchor, strength, 0.05, rest_length_right_var);
  right_spring.setRestLength(rest_length_right_var);
  
  
  positions = new ArrayList<Vector3D>();
  positions.add(machine.position());

  /* gui */
  controlP5 = new ControlP5(this);
  controlP5.addSlider("drag", 0.0f, 1.0f, 5, 400, 100, 20).setValue(drag_var);
  controlP5.addSlider("restlength_left", 0, width-10, 5, 425, 100, 20).setValue(rest_length_left_var);
  controlP5.addSlider("restlength_right", 0, width-10, 5, 450, 100, 20).setValue(rest_length_right_var);
  
  background(255);
}

void draw() {

  physics.tick();

  Vector3D position = positions.get(positions.size() - 1);
  Vector3D mPosition = machine.position();
  if(position.x() != mPosition.x() && position.y() != mPosition.y()) {
    positions.add(mPosition);
  }

  stroke(204, 102, 0, 10);
  line(mPosition.x(), mPosition.y(), left_anchor.position().x(), left_anchor.position().y());
  line(mPosition.x(), mPosition.y(), right_anchor.position().x(), right_anchor.position().y());

  int len = positions.size();
  for(int i = 0; i < len; i++) {
    Vector3D oldPosition = positions.get(i);

    float alpha = map(i, 0, len, 0, 100);
    noStroke();
    fill(0, 0, 0);
    ellipse(oldPosition.x(), oldPosition.y(), 10, 10);  
  }
}

void mousePressed()
{
  PVector pAnchorLeft = new PVector(left_anchor.position().x(), left_anchor.position().y());
  PVector pAnchorRight = new PVector(right_anchor.position().x(), right_anchor.position().y());

  PVector position = new PVector(machine.position().x(), machine.position().y());

  PVector destination = new PVector(mouseX, mouseY);

  float left_diff = left_spring.restLength() + calculateDifference(pAnchorLeft, position, destination);
  float right_diff = left_spring.restLength() + calculateDifference(pAnchorRight, position, destination);

  println(left_diff + " - " + right_diff);

  left_spring.setRestLength(left_diff);
  right_spring.setRestLength(right_diff);
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


