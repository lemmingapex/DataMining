/**
 * Explode 
 * by Daniel Shiffman. 
 * 
 * Mouse horizontal location controls breaking apart of image and 
 * Maps pixels from a 2D image into 3D space. Pixel brightness controls 
 * translation along z axis. 
 */
 
PImage img;       // The source image
int cellsize = 2; // Dimensions of each cell in the grid
int COLS, ROWS;   // Number of columns and rows in our system
void setup()
{
  size(200, 200, P3D); 
  img = loadImage("eames.jpg");     // Load the image
  COLS = width/cellsize;            // Calculate # of columns
  ROWS = height/cellsize;           // Calculate # of rows
  colorMode(RGB,255,255,255,100);   // Setting the colormode
}
void draw()
{
  background(0);
  // Begin loop for columns
  for ( int i = 0; i < COLS;i++) {
    // Begin loop for rows
    for ( int j = 0; j < ROWS;j++) {
      int x = i*cellsize + cellsize/2; // x position
      int y = j*cellsize + cellsize/2; // y position
      int loc = x + y*width;           // Pixel array location
      color c = img.pixels[loc];       // Grab the color
      // Calculate a z position as a function of mouseX and pixel brightness
      float z = (mouseX / (float) width) * brightness(img.pixels[loc]) - 100.0f;
      // Translate to the location, set fill and stroke, and draw the rect
      pushMatrix();
      translate(x,y,z);
      fill(c);
      noStroke();
      rectMode(CENTER);
      rect(0,0,cellsize,cellsize);
      popMatrix();
    }
  }
}
