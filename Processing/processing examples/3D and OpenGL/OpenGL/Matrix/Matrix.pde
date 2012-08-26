/**
 * Matrix 
 * by Mixel. 
 * 
 * Simple example utilizing the OpenGL Library for Processing. 
 */

import processing.opengl.*;

void setup() 
{
  size(640, 480, OPENGL);
  noStroke();
  fill(0, 102, 153, 40);
}

void draw() 
{
  float x = mouseX - width/2;
  background(255);
  translate(width/2, height/2);
  rotateY(radians(mouseY/5));
  for(int i=-height/2; i<height/2; i+=50) {
    for(int j=-width/2; j<width/2; j+=50) {
      beginShape(QUADS);
      vertex(x+j,   i,    0);
      vertex(x+j, i+15,    0);
      vertex(j-x, i+15, -400);
      vertex(j-x,   i, -400);
      endShape();
    }
  }
}

