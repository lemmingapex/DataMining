/**
 * Array. 
 * 
 * An array is a list of data. Each piece of data in an array 
 * is identified by an index number representing its position in 
 * the array. Arrays are zero based, which means that the first 
 * element in the array is [0], the second element is [1], and so on. 
 * In this example, an array named "coswav" is created and
 * filled with the cosine values. This data is displayed three 
 * separate ways on the screen.  
 */

size(200, 200);

float[] coswave = new float[width];

for(int i=0; i<width; i++) {
  float ratio = (float)i/(float)width;
  coswave[i] = abs( cos(ratio*PI) );
}

for(int i=0; i<width; i++) {
  stroke(coswave[i]*255);
  line(i, 0, i, width/3);
}

for(int i=0; i<width; i++) {
  stroke(coswave[i]*255/4);
  line(i, width/3, i, width/3*2);
}

for(int i=0; i<width; i++) {
  stroke(255-coswave[i]*255);
  line(i, width/3*2, i, height);
}
