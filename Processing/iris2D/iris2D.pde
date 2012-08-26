import java.util.*;

Iris[] irises;
ArrayList seIrises = new ArrayList();
ArrayList veIrises = new ArrayList();
ArrayList viIrises = new ArrayList();

Hashtable types = new Hashtable();
int typemin, typemax;
String[] typesA;

String[] lines;

float plotX1, plotY1;
float plotX2, plotY2;
float labelX, labelY;
PFont plotFont;

float barWidth = 4;

void setup( ) {
  size(850, 850);
  fill(255);
  smooth();
  stroke(255);
  background(192, 64, 0);
  plotFont = createFont("SansSerif", 20);
  textFont(plotFont);

  plotX1 = 100;
  plotX2 = width - 100;
  labelX = 50;
  plotY1 = 100;
  plotY2 = height - 100;
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
  strokeWeight(10);
  // Draw the data for the first column.
  stroke(#5679C1);
  
  drawDataPoints(irises);
  drawDistanceLabels( );
  drawKey();
  drawAxisLabels();
  drawTitle();
}

// Draw the data as a series of points.
void drawDataPoints(Iris[] Is)
{  
  for(int i = 0; i < Is.length; i++)
  {
    float C = map((Integer)(types.get(Is[i].type)), 0.0, types.size()-1, 50, 205);
    stroke(C,C-50,C+50);
    float x = map(Is[i].swidth, 0.0, 9.0, plotX1, plotX2);
    float y = map(Is[i].slength, 0.0, 9.0, plotY2, plotY1);
    point(x,y);
  }
}

void drawKey()
{ 
  textSize(15);
  // good job java.  I love to reindex enumerations into arrays!
  Enumeration e = types.keys();
  String[] stringTypes = new String[types.size()];
  int count=1;
  while(e.hasMoreElements())
  {
     if (count==types.size())
     {
        count=0; 
     }
     stringTypes[count]=(String)e.nextElement();
     count++;
  }

  for(int i=0; i<types.size(); i++)
  {
    float C = map(i, 0.0, types.size()-1, 50, 205);
    strokeWeight(10);
    stroke(C,C-50,C+50);
    float x = map(i, -1, types.size(), plotX1, plotX2);
    float y = 70;
    text(stringTypes[i], x+(stringTypes[i].length()*6), y);
    point(x-20,y);
  }
}

void drawAxisLabels()
{ 
  textSize(15);
  text("sepal width in cm", (plotX1+plotX2)/2, plotY2+40);
  text("sepal length\n in cm", plotX1-20, (plotY1+plotY2)/2);
}

void drawTitle()
{ 
  textSize(15);
  text("Iris sepal width vs. sepal length", (plotX1+plotX2)/2, plotY1-70);
}

void drawDistanceLabels( ) {
  fill(0);
  textSize(10);
  textAlign(RIGHT);
  stroke(128);
  strokeWeight(1);
  for (float v = 0; v <= 9; v += 1)
  {
    if (v % 1 == 0)
    {
      float y = map(v, 0, 9.0, plotY2, plotY1);
      float x = map(v, 0, 9.0, plotX1, plotX2);
      if (v % 1 == 0)
      {
        float textOffset = textAscent( )/2; // Center vertically
        if (v == 0)
        {
          textOffset = 0;
        } 
        else if (v == 9)
        {
          textOffset = textAscent( ); // Align by the top
        }
        text(floor(v), plotX1 - 10, y + textOffset);
        line(plotX1 - 4, y, plotX1, y); // Draw major tick
        text(floor(v), x + textOffset, plotY2 + 20);
        line(x, plotY2, x, plotY2+4); // Draw major tick
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
     count++;
    }
  }
  typemin=0;
  typemax=count-1;
  typesA = new String[typemax];
  count=0;
  for(int i=0; i<irises.length; i++)
  {
    if(!(types.containsKey(irises[i].type)))
    {
     typesA[count]=(String)irises[i].type;
     count++;
    }
  }
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

