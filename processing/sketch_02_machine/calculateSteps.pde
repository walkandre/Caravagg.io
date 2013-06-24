

float calculateSteps(PVector anchor, PVector position, PVector destination) {

  // difference from anchor to current position.
  PVector posDifference = new PVector();
  posDifference.set(anchor);
  posDifference.sub(position);
  
  // difference from anchor to destination
  PVector desDifference = new PVector();
  desDifference.set(anchor);
  desDifference.sub(destination);

  float difference = desDifference.mag() - posDifference.mag();

  return difference;
}
