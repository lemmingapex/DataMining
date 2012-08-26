import java.util.*;

Iris[] irises;
ArrayList seIrises = new ArrayList();
ArrayList veIrises = new ArrayList();
ArrayList viIrises = new ArrayList();

Hashtable types = new Hashtable();
int typemin, typemax;

String[] lines;

float plotX1, plotY1;
float plotX2, plotY2;
float labelX, labelY;
PFont plotFont;

float barWidth = 4;

void setup( ) {
  size(720, 405);
  fill(255);
  smooth();
  stroke(255);
  background(192, 64, 0);
  plotFont = createFont("SansSerif", 20);
  textFont(plotFont);

  plotX1 = 120;
  plotX2 = width - 80;
  labelX = 50;
  plotY1 = 60;
  plotY2 = height - 70;
  labelY = height - 25;
  

  ReadFile("iris.data");
  //noLoop();
  smooth( );
}


void draw( ) {
  background(224);
  // Show the plot area as a white box.
  fill(255);
  rectMode(CORNERS);
  noStroke( );
  rect(plotX1, plotY1, plotX2, plotY2);
  strokeWeight(5);
  // Draw the data for the first column.
  stroke(#5679C1);
  
  ArrayList Aves = new ArrayList();
  Aves.add(Average(seIrises));
  Aves.add(Average(veIrises));
  Aves.add(Average(viIrises));
  drawDataPoints(Aves, #9911C1, 0);

  ArrayList Meds = new ArrayList();
  Meds.add(Median(seIrises));
  Meds.add(Median(veIrises));
  Meds.add(Median(viIrises));
  drawDataPoints(Meds, #555555, 15);
  
  drawTypeLabels();
  drawDistanceLabels();
  drawTitle();
  drawKey();
}

void drawDataPoints(ArrayList Iss, int C, int xo)
{
  stroke(C);
  Iris[] Is = new Iris[Iss.size()];
  Iss.toArray(Is);
  
  for(int i = 0; i < Is.length; i++)
  {
    int value = (Integer)(types.get(Is[i].type));
    float x = map(value, typemin-((types.size()-1)*.25), typemax+((types.size()-1)*.25), plotX1, plotX2);
    float y = map(Is[i].slength, 0.0, 10.0, plotY2, plotY1);
    x=x-60;
    rect(xo+x-barWidth/2, y, xo+x+barWidth/2, plotY2);
    //point(x, y);
    x=x+30;
    y = map(Is[i].swidth, 0.0, 10.0, plotY2, plotY1);
    rect(xo+x-barWidth/2, y, xo+x+barWidth/2, plotY2);
    x=x+30;
    y = map(Is[i].plength, 0.0, 10.0, plotY2, plotY1);
    rect(xo+x-barWidth/2, y, xo+x+barWidth/2, plotY2);
    x=x+30;
    y = map(Is[i].pwidth, 0.0, 10.0, plotY2, plotY1);
    rect(xo+x-barWidth/2, y, xo+x+barWidth/2, plotY2);
  }
}

void drawKey()
{ 
  textSize(15);
  textAlign(LEFT);
  strokeWeight(10);
  float y =40;
  float x =(plotX1+plotX2)/2;
  text("Mean", x, y+10);
  stroke(#9911C1);
  point(x-10,y);
  x=x+100;
  text("Median", x, y+10);
  stroke(#555555);
  point(x-10,y);
}

void drawTitle()
{ 
  textSize(15);
  text("Irises mean and median", (plotX1+plotX2)/2-100, plotY1-20);
}

void drawTypeLabels( ) {
  fill(0);
  textSize(15);
  textAlign(CENTER);
  stroke(224);
  strokeWeight(1);
  
  for (int i=0; i < irises.length; i++)
  {
      textSize(15);
      float x = map((Integer)types.get(irises[i].type), typemin-((types.size()-1)*.25), typemax+((types.size()-1)*.25), plotX1, plotX2);
      text(irises[i].type, x, plotY2 + textAscent( ) + 20);
      textSize(9);
      text("slength", x-45, plotY2 + textAscent( ));
      text("swidth", x-15, plotY2 + textAscent( ));
      text("plength", x+15, plotY2 + textAscent( ));
      text("pwidth", x+45, plotY2 + textAscent( ));
  }
}

void drawDistanceLabels( ) {
  fill(0);
  textSize(10);
  textAlign(RIGHT);
  stroke(128);
  strokeWeight(1);
  for (float v = 0; v <= 10; v += 1) {
    if (v % 1 == 0) { // If a tick mark
      float y = map(v, 0, 10, plotY2, plotY1);
      if (v % 1 == 0) { // If a major tick mark
        float textOffset = textAscent( )/2; // Center vertically
        if (v == 0) {
          textOffset = 0; // Align by the bottom
        } 
        else if (v == 10) {
          textOffset = textAscent( ); // Align by the top
        }
        text(floor(v), plotX1 - 10, y + textOffset);
        line(plotX1 - 4, y, plotX1, y); // Draw major tick
      } 
      else {
        //line(plotX1 - 2, y, plotX1, y); // Draw minor tick
      }
    }
  }
}


void ReadFile(String filename)
{
  lines = loadStrings(filename);
  irises = new Iris[lines.length];

  for (int i=0; i<lines.length; i++)
  {
    String[] pieces = split(lines[i], ",");
    irises[i] = new Iris(pieces);
  }
  
  for(int i=0; i<irises.length; i++)
  {
    if((irises[i].type).equals("Iris-setosa"))
    {
      seIrises.add(irises[i]);
    }
    if((irises[i].type).equals("Iris-versicolor"))
    {
      veIrises.add(irises[i]);
    }
    if((irises[i].type).equals("Iris-virginica"))
    {
      viIrises.add(irises[i]);
    }
  }
  FillTypes();
}


void FillTypes()
{
  int count=0;
  for(int i=0; i<irises.length; i++)
  {
    if(!(types.containsKey(irises[i].type)))
    {
     types.put((String)irises[i].type, (Integer)count);
     //System.out.println(types.get((String)irises[i].type));
     count++;
    }
  }
  typemin=0;
  typemax=count-1;
}

Iris Average(ArrayList Is)
{
  Iris ReturnAverageIris = new Iris();
  int Size = Is.size();
  for(int i=0; i<Size; i++)
  {
    ReturnAverageIris.slength += ((Iris)Is.get(i)).slength;
    ReturnAverageIris.swidth += ((Iris)Is.get(i)).swidth;
    ReturnAverageIris.plength += ((Iris)Is.get(i)).plength;
    ReturnAverageIris.pwidth += ((Iris)Is.get(i)).pwidth;
  }
  ReturnAverageIris.slength/=Size;
  ReturnAverageIris.swidth/=Size;
  ReturnAverageIris.plength/=Size;
  ReturnAverageIris.pwidth/=Size;
  ReturnAverageIris.type=((Iris)(Is.get(0))).type;

  return ReturnAverageIris;
}

Iris Average(Iris[] Is)
{
  Iris ReturnAverageIris = new Iris();
  int Size = Is.length;
  for(int i=0; i<Size; i++)
  {
    ReturnAverageIris.slength += Is[i].slength;
    ReturnAverageIris.swidth += Is[i].swidth;
    ReturnAverageIris.plength += Is[i].plength;
    ReturnAverageIris.pwidth += Is[i].pwidth;
  }
  ReturnAverageIris.slength/=Size;
  ReturnAverageIris.swidth/=Size;
  ReturnAverageIris.plength/=Size;
  ReturnAverageIris.pwidth/=Size;

  return ReturnAverageIris;
}

Iris Median(ArrayList Iss)
{
  Iris[] Is = new Iris[Iss.size()];
  Iss.toArray(Is);
  
  String Type=Is[0].type;  // type
  Float Slength;  // sepal length in cm
  Float Swidth;  // sepal width in cm
  Float Plength;  // petal length in cm
  Float Pwidth;  // petal width in cm
  Iris ReturnMedianIris = new Iris();
  
  int middle = Is.length/2;

  if (Is.length%2 == 1)
  {
    Arrays.sort(Is, new sLengthComparator());
    Slength=Is[middle].slength;
    Arrays.sort(Is, new sWidthComparator());
    Swidth=Is[middle].swidth;
    Arrays.sort(Is, new pLengthComparator());
    Plength=Is[middle].plength;
    Arrays.sort(Is, new pWidthComparator());
    Pwidth=Is[middle].pwidth;
    ReturnMedianIris = new Iris(Slength, Swidth, Plength, Pwidth, Type);
  }
  else
  {
    Iris TempIris = new Iris();
    Iris[] temp = new Iris[2];
     
    Arrays.sort(Is, new sLengthComparator());
    temp[0]=Is[middle-1];
    temp[1]=Is[middle];
    TempIris=Average(temp);
    Slength=TempIris.slength;
    
    Arrays.sort(Is, new sWidthComparator());
    temp[0]=Is[middle-1];
    temp[1]=Is[middle];
    TempIris=Average(temp);
    Swidth=TempIris.swidth;
    
    Arrays.sort(Is, new pLengthComparator());
    temp[0]=Is[middle-1];
    temp[1]=Is[middle];
    TempIris=Average(temp);
    Plength=TempIris.plength;
    
    Arrays.sort(Is, new pWidthComparator());
    temp[0]=Is[middle-1];
    temp[1]=Is[middle];
    TempIris=Average(temp);
    Pwidth=TempIris.pwidth;
    
    ReturnMedianIris = new Iris(Slength, Swidth, Plength, Pwidth, Type);
  }

  return ReturnMedianIris;  
}


class Iris
{
  String type;  // type
  // Iris Setosa
  // Iris Versicolour
  // Iris Virginica
  Float slength;  // sepal length in cm
  Float swidth;  // sepal width in cm
  Float plength;  // petal length in cm
  Float pwidth;  // petal width in cm

  public Iris(String[] pieces)
  {
    slength = float(pieces[0]);
    swidth = float(pieces[1]);
    plength = float(pieces[2]);
    pwidth = float(pieces[3]);
    type = pieces[4];
  }

  public Iris(Float SL, Float SW, Float PL, Float PW, String T)
  {
    slength = SL;
    swidth = SW;
    plength = PL;
    pwidth = PW;
    type = T;
  }

  public Iris()
  {
    slength = 0.0;
    swidth = 0.0;
    plength = 0.0;
    pwidth = 0.0;
    type = "";
  }
}

class sLengthComparator implements Comparator
{
  public int compare(Object A, Object B)
  {
    return (((Iris)A).slength).compareTo(((Iris)B).slength);
  }
}

class sWidthComparator implements Comparator
{
  public int compare(Object A, Object B)
  {
    return (((Iris)A).swidth).compareTo(((Iris)B).swidth);
  }
}

class pLengthComparator implements Comparator
{
  public int compare(Object A, Object B)
  {
    return (((Iris)A).plength).compareTo(((Iris)B).plength);
  }
}

class pWidthComparator implements Comparator
{
  public int compare(Object A, Object B)
  {
    return (((Iris)A).pwidth).compareTo(((Iris)B).pwidth);
  }
}

