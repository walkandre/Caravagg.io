/**
 *
 */
import controlP5.*;
import blobDetection.*;

ControlP5 controlP5;
BlobDetection blobDetection;
PImage img;
PImage blobImg;
float threshold_value;

void setup() {
  
  size(1024, 480);
  smooth();
  frameRate(30);
  
  threshold_value = 0.50f;
  
  /* gui */
  controlP5 = new ControlP5(this);
  controlP5.addButton("traceBT", 0, 5, 400, 100, 20).setLabel("acquire");
  controlP5.addSlider("threshold", 0.0f, 1.0f, 5, 435, 100, 20).setValue(threshold_value);

  /* test image */
  img = loadImage("image.jpg");
  blobImg = new PImage(80, 80);
  
  img.filter(BLUR, 1);
  img.filter(GRAY);
  img.filter(POSTERIZE, 6);
  
  blobImg.copy(img, 0, 0, img.width, img.height, 0, 0, blobImg.width, blobImg.height);
  
  

  blobDetection = new BlobDetection(blobImg.width, blobImg.height);
  blobDetection.setPosDiscrimination(true);
}

void draw() {
  background(0);
  image(img, 0, 0);

  /*
  threshold_value += 0.01;
  if(threshold_value > 1) {
    threshold_value = 0.0f;
  }
  */

  /* 
   * http://www.v3ga.net/processing/BlobDetection/index-page-documentation.html
   */
  blobDetection.setThreshold(threshold_value);
  blobDetection.computeBlobs(blobImg.pixels);

  /* from blob detection example sketch */
  drawBlobsAndEdges(false, true);
}

/* from blob detection example sketch */
void drawBlobsAndEdges(boolean drawBlobs, boolean drawEdges) {
  noFill();
  
  Blob b;
  EdgeVertex eA, eB;
  for (int n = 0 ; n < blobDetection.getBlobNb(); n++) {
    b = blobDetection.getBlob(n);
    if (b != null) {

      // Edges
      if (drawEdges) {
        strokeWeight(2);
        stroke(0, 255, 0);

        beginShape(LINES);
        for (int m = 0; m < b.getEdgeNb(); m++) {
          eA = b.getEdgeVertexA(m);
          eB = b.getEdgeVertexB(m);
          if (eA != null && eB != null) {
            vertex(img.width + eA.x * img.width, eA.y * img.height);
            vertex(img.width + eB.x * img.width, eB.y * img.height);
            //line(img.width + eA.x * img.width, eA.y * img.height, img.width + eB.x * img.width, eB.y * img.height);
          }
        }
        endShape();
      }

      // Blobs
      if (drawBlobs) {
        strokeWeight(1);
        stroke(255, 0, 0);
        rect(img.width + b.xMin * img.width, b.yMin * img.height, b.w * img.width, b.h * img.height);
      }
    }
  }
}

/* controlp5 callbacks */
public void traceBT(int theValue) {
  
}
public void threshold(float theValue) {
  //println("threshold: " + theValue);
  threshold_value = theValue;
}
