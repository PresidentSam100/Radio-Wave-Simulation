ArrayList<Body> bodies;
float t = 0;
import peasy.*; //from a libary called PeasyCam so that we can move the camera
PeasyCam p;
PVector testV;
PVector testD;
boolean e, b, e1, b1, e2,b2, pow,pow2, showFlux, showFlux1;
int chargeNum = 30;
float mu0 = 50; 
//50/.01  amp2 freq8: .24,.15,.96 __ .17,.18,1.26 (colors
//.01/.001 amp304 freq3: 0.00713, 0.00729,0.021 __ 0.000016, 0.000009, 0.000037
float epsilon0 = .01;
float c = 1/sqrt(epsilon0*mu0);
float eq = 13;
float it = .005; // Time in between each arrow
int gfieldDensity = 100;
void setup() {
  e = false;
  b = false;
  showFlux = false;
  bodies = new ArrayList<Body>();
  size(800, 800, P3D);
  p = new PeasyCam(this,400,400,400,400);
  stdCharges(4);
}
void draw() {
  background(0);
  translate(width/2, height/2);
  float amp = 2;
  float freq = 8;
  for (int i = 0; i < bodies.size();i++){
    bodies.get(i).setA(new PVector(0,0,amp*cos(freq*t)));
    bodies.get(i).setV(new PVector(0,0,amp/freq*sin(freq*t)));
    bodies.get(i).setD(new PVector(0,0,400-amp/freq/freq*cos(freq*t)));
    bodies.get(i).move(it);
  }
  for (Body body : bodies) {
    body.sketch();
  }
  if (e) drawEField();
  if (b) drawBField();
  if (e1) drawERField();
  if (b1) drawBRField();
  if (e2) drawERLWField();
  if (b2) drawBRLWField();
  if (pow) drawPowField();
  if (pow2) drawPow2Field();
  t += it;
}
void drawEField() {
  Body s = new Body(new PVector(0,0),new PVector(0,0),1,false,color(255,255,255));
  for (int x = -width/2; x < width/2; x+=gfieldDensity) {
    for (int y = -height/2; y < height/2; y+= gfieldDensity) {
      for (int z = 0; z < height; z+=gfieldDensity) {
      s.setD(new PVector(x,y,z));
      PVector h = new PVector(0,0);
      for (int i = 0; i < bodies.size(); i++) {
        h = PVector.add(h, s.calcE(bodies.get(i)));
      }
      colorMode(HSB);
      drawMiniArrow(x,y,z,h,gfieldDensity,true);
      }}}
  }
  void drawBField(){
  Body s = new Body(new PVector(0,0), new PVector(0,0),1,false,color(255,255,255));
  for (int x = -width/2; x < width/2; x+= gfieldDensity) {
    for (int y = -height/2; y < height/2; y+= gfieldDensity) {
      for (int z = 0; z < height; z+= gfieldDensity) {
      s.setD(new PVector(x,y,z));
      PVector h = new PVector(0,0);
      for (int i = 0; i < bodies.size(); i++) {
        h = PVector.add(h, s.calcB(bodies.get(i)));
      }
      colorMode(HSB);
      drawMiniArrow(x,y,z,h,gfieldDensity,false);
      }}}
  }
  void drawERField() {
  for (int x = -width/2; x < width/2; x+= gfieldDensity) {
    for (int y = -height/2; y < height/2; y+= gfieldDensity) {
      for (int z = 0; z < height; z+=gfieldDensity) {
      PVector p = new PVector(x,y,z);
      PVector h = new PVector(0,0);
      for (int i = 0; i < bodies.size(); i++) {
        h = PVector.add(h, bodies.get(i).calcRE(p));
      }
      colorMode(HSB);
      drawMiniArrow(x,y,z,h,gfieldDensity,true);
      }}}
  }
 void drawBRField() {
  for (int x = -width/2; x < width/2; x+= gfieldDensity) {
    for (int y = -height/2; y < height/2; y+= gfieldDensity) {
      for (int z = 0; z < height; z+=gfieldDensity) {
      PVector p = new PVector(x,y,z);
      PVector h = new PVector(0,0);
      for (int i = 0; i < bodies.size(); i++) {
        h = PVector.add(h, bodies.get(i).calcRB(p));
      }
      colorMode(HSB);
      drawMiniArrow(x,y,z,h,gfieldDensity,false);
      }}}
  }
    void drawERLWField() {
  for (int x = -width/2; x < width/2; x+= gfieldDensity) {
    for (int y = 0; y < height/2; y+= gfieldDensity) {
      for (int z = 0; z < height; z+=gfieldDensity) {
      PVector p = new PVector(x,y,z);
      PVector h = new PVector(0,0);
      for (int i = 0; i < bodies.size(); i++) {
        h = PVector.add(h, bodies.get(i).calcRELW(p));
      }
      colorMode(HSB);
      drawMiniArrow(x,y,z,h,gfieldDensity,true);
      }}}
  }
 void drawBRLWField() {
  for (int x = -width/2; x < width/2; x+= gfieldDensity) {
    for (int y = 0; y < height/2; y+= gfieldDensity) {
      for (int z = 0; z < height; z+=gfieldDensity) {
      PVector p = new PVector(x,y,z);
      PVector h = new PVector(0,0);
      for (int i = 0; i < bodies.size(); i++) {
        h = PVector.add(h, bodies.get(i).calcRBLW(p));
      }
      colorMode(HSB);
      drawMiniArrow(x,y,z,h,gfieldDensity,false);
      }}}
  }
   void drawPowField() {
  for (int x = -width/2; x < width/2; x+= gfieldDensity) {
    for (int y = -height/2; y < height/2; y+= gfieldDensity) {
      for (int z = 0; z < height; z+=gfieldDensity) {
      PVector p = new PVector(x,y,z);
      PVector h = new PVector(0,0);
      for (int i = 0; i < bodies.size(); i++) {
        h = PVector.add(h, bodies.get(i).calcRE(p).cross(bodies.get(i).calcRB(p)));
      }
      colorMode(HSB);
      drawMiniArrow(x,y,z,h,gfieldDensity,true);
      }}}
  }
   void drawPow2Field() {
  for (int x = -width/2; x < width/2; x+= gfieldDensity) {
    for (int y = -height/2; y < height/2; y+= gfieldDensity) {
      for (int z = 0; z < height; z+=gfieldDensity) {
      PVector p = new PVector(x,y,z);
      PVector h = new PVector(0,0);
      for (int i = 0; i < bodies.size(); i++) {
        h = PVector.add(h, bodies.get(i).calcRELW(p).cross(bodies.get(i).calcRBLW(p)));
      }
      colorMode(HSB);
      drawMiniArrow(x,y,z,h,gfieldDensity,false);
      }}}
  }


void drawMiniArrow(float x, float y, float z,PVector h, int fD, boolean e) {
  if (e) {
    if (h.mag()>0.024) {
      stroke(map(h.mag(),0.015,0.096,125,255),255,255);
    pushMatrix();
      translate(x,y,z);
      float phi = atan2(h.z,sqrt(sq(h.x)+sq(h.y)));
      float theta =atan2(h.y,h.x);
      rotateZ(PI/2+theta);
      rotateX(PI-phi);
      //rotateY(-phi*cos(theta));
      line(0,fD*.5,0,0);
      noFill();
      triangle(0,fD*.7,fD*.05,fD*.5,-fD*.05,fD*.5);
    popMatrix();}}
  else {
    if (h.mag()>0.00009) {
      stroke(map(h.mag(),0.00011,0.84589,0,125),255,255);
    pushMatrix();
      translate(x,y,z);
      float phi = atan2(h.z,sqrt(sq(h.x)+sq(h.y)));
      float theta =atan2(h.y,h.x);
      rotateZ(PI/2+theta);
      rotateX(PI-phi);
      //rotateY(-phi*cos(theta));
      line(0,fD*.7,0,0);
      noFill();
      triangle(0,fD*.7,fD*.05,fD*.5,-fD*.05,fD*.5);
    popMatrix();}}}
    
void drawP(int x,int y,int z) {
  colorMode(HSB);
  stroke(map(z,-50,50,125,255),255,255);
  beginShape();
    vertex(0,0,0);
    vertex(x,0,0);
    vertex(x,y,0);
    vertex(0,y,0);
    vertex(0,0,0);
    
    vertex(0,0,0);
    vertex(0,y,0);
    vertex(0,y,z);
    vertex(0,0,z);
    vertex(0,0,0);
    
    vertex(0,0,0);
    vertex(x,0,0);
    vertex(x,0,z);
    vertex(0,0,z);
    vertex(0,0,0);
    
    vertex(x,0,0);
    vertex(x,y,0);
    
    vertex(x,y,z);
    vertex(x,0,z);
    vertex(x,y,z);
    vertex(0,y,z);
    vertex(x,y,z);
    
    vertex(x,y,z);
    vertex(x,y,0);
    vertex(x,y,z);
    vertex(x,0,z);
    vertex(x,y,z);
    
    vertex(x,y,z);
    vertex(x,y,0);
    vertex(x,y,z);
    vertex(0,y,z);
    vertex(x,y,z);
  endShape();}    
    
  
void stdCharges(int in) {
  bodies.clear();
  if (in ==1) {
    for (int i = 0; i < chargeNum; i++) {
      float q = random(-50,50);
      bodies.add(new Body(new PVector(random(-height/2+110,height/2-110),random(-height/2+110,height/2-110),random(110,height-110)),new PVector(0,0,0),10*q,true,color((q+20)*12,(q+20)*12,(q+20)*12)));}
    for (int i = 0; i < chargeNum; i++) { if (bodies.get(i).getD().x > 0 && bodies.get(i).getD().x < 200 && bodies.get(i).getD().y < 200 && bodies.get(i).getD().y > 0 && bodies.get(i).getD().z < 600 && bodies.get(i).getD().z > 400){
      println("Location: " + bodies.get(i).getD() + "  Charge: " + bodies.get(i).getM());
      bodies.get(i).setColor(color(0,255,0));}
    }}
  else if (in == 2) {
    float q = random(-50,50);
    bodies.add(new Body(new PVector(random(-height/2+110,height/2-110),random(-height/2+110,height/2-110),random(110,height-110)),new PVector(0,0,0),10*q,true,color((q+20)*12,(q+20)*12,(q+20)*12)));}
  else if (in == 3) {
    int d = 40;
    chargeNum = int(sq(width/d)*2);
    for (int x = -width/2; x < width/2; x+=d) {
      for (int y = -height/2; y <height/2; y+=d) {
        float q = 10;
        bodies.add(new Body(new PVector(x,y,150),new PVector(0,0,0),10*q,true,color((q+20)*12,(q+20)*12,(q+20)*12)));
      }}
    for (int x = -width/2; x < width/2; x+=d) {
      for (int y = -height/2; y <height/2; y+=d) {
        float q = 10;
        bodies.add(new Body(new PVector(x,y,-150),new PVector(0,0,0),10*q,true,color((q+20)*12,(q+20)*12,(q+20)*12)));
      }}
    
  }
  else if (in == 4) {
    bodies.add(new Body(new PVector(0,0,height/2),new PVector(0,0,0), 100,false,color(255,255,255)));
  }
  }
  void keyPressed() {
    if (key == '1') {
      if (!e) {e = true;}
      else {e = false;}}
    else if (key == '2') {
      if (!b) {b = true;}
      else {b = false;}}
    else if (key == '3') {
      if (!e1) {e1 = true;}
      else {e1 = false;}}
    else if (key == '4') {
      if (!b1) {b1 = true;}
      else {b1 = false;}}
    else if (key == '5') {
      if (!pow) {pow = true;}
      else {pow = false;}}
    else if (key == '6') {
      if (!e2) {e2 = true;}
      else {e2 = false;}}
    else if (key == '7') {
      if (!b2) {b2 = true;}
      else {b2 = false;}}
    else if (key == '8') {
      if (!pow2) {pow2 = true;}
      else {pow2 = false;}}}
