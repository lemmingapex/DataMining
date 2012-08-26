/**
 * Letter K 
 * by Peter Cho. 
 * 
 * Move the mouse across the screen to fold the "K". 
 * 
 * Created 16 December 2002
 */
 
color bgc, fgc, fgc2;

float p_x, p_y;
float p_fx, p_fy;
float p_v2, p_vx, p_vy;
float p_a2, p_ax, p_ay;
float p_mass, p_drag;

void setup()
{
  size(200, 200, P3D);
  noStroke();
  colorMode(RGB, 255);
  bgc = color(134, 144, 154);
  fgc = color(235, 235, 30);
  fgc2 = color(240, 130, 20);
  init_particle(.6, .9,  width/2, height/2);
}

void draw()
{
  background(bgc);
  pushMatrix();

  iterate_particle(.15*(-p_x+mouseX), .15*(-p_y+(height-mouseY)));

  translate(width/2, height/2, 0);
  fill(fgc);
  drawK();
 
  pushMatrix();
  translate(0, 0, 1);
  translate(.75*(p_x-width/2), -.75*(p_y-height/2), 0);
  translate(.75*(p_x-width/2), -.75*(p_y-height/2), 0);
  rotateZ(atan2(-(p_y-height/2),(p_x-width/2)) + PI/2);
  rotateX(PI);
  rotateZ(-(atan2(-(p_y-height/2),(p_x-width/2)) + PI/2));
  
  fill(fgc2);
  drawK();
  popMatrix();

  translate(0, 0, 2);
  translate(.75*(p_x-width/2), -.75*(p_y-height/2), 0);
  rotateZ(atan2(-(p_y-height/2),(p_x-width/2)) + PI/2);
  fill(bgc);
  beginShape(QUADS);
  vertex(-200, 0);
  vertex(+200, 0);
  vertex(+200, -200);
  vertex(-200, -200);
  endShape();
  
  popMatrix();
}

void init_particle(float _mass, float _drag, float ox, float oy) 
{
  p_x = ox;
  p_y = oy;
  p_v2 = 0.0f;
  p_vx = 0.0f;
  p_vy = 0.0f;
  p_a2 = 0.0f;
  p_ax = 0.0f;
  p_ay = 0.0f;
  p_mass = _mass;
  p_drag = _drag;
}

void iterate_particle(float fkx, float fky) 
{
  // iterate for a single force acting on the particle
  p_fx = fkx;
  p_fy = fky;
  p_a2 = p_fx*p_fx + p_fy*p_fy;
  if (p_a2 < 0.0000001) return;
  p_ax = p_fx/p_mass;
  p_ay = p_fy/p_mass;
  p_vx += p_ax;
  p_vy += p_ay;
  p_v2 = p_vx*p_vx + p_vy*p_vy;
  if (p_v2 < 0.0000001) return;
  p_vx *= (1.0 - p_drag);
  p_vy *= (1.0 - p_drag);
  p_x += p_vx;
  p_y += p_vy;
}

void drawK() 
{
  scale(1);
  translate(-63, +71);
  beginShape(QUADS);
  vertex(0, 0, 0);
  vertex(0, -142.7979, 0);
  vertex(37.1992, -142.7979, 0);
  vertex(37.1992, 0, 0);
  
  vertex(37.1992, -87.9990, 0);
  vertex(84.1987, -142.7979, 0);
  vertex(130.3979, -142.7979, 0);
  vertex(37.1992, -43.999, 0);

  vertex(77.5986-.2, -86.5986-.3, 0);
  vertex(136.998, 0, 0);
  vertex(90.7988, 0, 0);
  vertex(52.3994-.2, -59.999-.3, 0);
  endShape();
  translate(+63, -71);
}



