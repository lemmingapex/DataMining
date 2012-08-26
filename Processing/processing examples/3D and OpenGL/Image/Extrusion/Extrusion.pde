/**
 * Extrusion. 
 * 
 * Converts a flat image into spatial data points and rotates the points
 * around the center.
 * 
 * Created 18 August 2002
 */
 
PImage a;
boolean onetime = true;
int[][] aPixels;
int[][] values;
float angle;

void setup() 
{
  size(200, 200, P3D);
  
  aPixels = new int[width][height];
  values = new int[width][height];
  noFill();

  // Load the image into a new array
  // Extract the values and store in an array
  a = loadImage("ystone08.jpg");
  for (int i=0; i<height; i++) {
    for (int j=0; j<width; j++) {
      aPixels[j][i] = a.pixels[i*width + j];
      values[j][i] = int(blue(aPixels[j][i]));
    }
  }
}

void draw() 
{
  background(0);
  
  // Update and constrain the angle
  angle += 0.005;
  if (angle > TWO_PI) { angle = 0; }
  
  // Rotate around the center axis
  translate(width/2, 0, 128);
  rotateY(angle);  
  translate(-width/2, 0, 128);
  
  // Display the image mass
  for (int i=0; i<height; i+=2) {
    for (int j=0; j<width; j+=2) {
      stroke(values[j][i]);
      point(j, i, -values[j][i]);
    }
  }
}
