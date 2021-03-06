/**
 * Easing. 
 * 
 * Move the mouse across the screen and the symbol will follow.  
 * Between drawing each frame of the animation, the program
 * calculates the difference between the position of the 
 * symbol and the cursor. If the distance is larger than
 * 1 pixel, the symbol moves half of the distance from its
 * current position toward the cursor. 
 * 
 * Updated 21 August 2002
 */
 
float x;
float y;
float targetX, targetY;
float easing = 0.05;

void setup() 
{
  size(200, 200); 
  smooth();
  noStroke();  
}

void draw() 
{ 
  background( 51 );
  
  targetX = mouseX;
  float dx = mouseX - x;
  if(abs(dx) > 1) {
    x += dx * easing;
  }
  
  targetY = mouseY;
  float dy = mouseY - y;
  if(abs(dy) > 1) {
    y += dy * easing;
  }
  
  ellipse(x, y, 33, 33);
}
