class Body {
  ArrayList<PVector> d;
  ArrayList<PVector> v;
  ArrayList<PVector> a;
  float m;
  color c1;
  boolean isStatic;
  int aLength;
  Body(PVector d1, PVector v1, float m1, boolean y, color co) {
    d = new ArrayList<PVector>();
    v = new ArrayList<PVector>();
    a = new ArrayList<PVector>();
    aLength = 4000;
    this.c1 = co;
    d.add(d1);
    v.add(v1);
    a.add(new PVector());
    this.m = m1;
    this.isStatic = y;}
  void iterate(Body body) {
    a.set(0,PVector.add(calcE(body),v.get(0).cross(calcB(body))));
    }
  void move(float iterator) {
    a.add(0,a.get(0));
    v.add(0,v.get(0));
    d.add(0,d.get(0));
    //v.add(0,PVector.add(v.get(0),PVector.mult(a.get(0),iterator)));
    //d.add(0,PVector.add(d.get(0),PVector.mult(v.get(0),iterator)));
    
    //for (int i = 0; i < d.size(); i++) {
    //  println(i + "\t" + d.get(i) + "\t" + v.get(i) + "\t" + a.get(i));}
    if (d.size() == aLength-2){
      println("go");}
    if (d.size() == aLength+1) {
      d.remove(aLength);
      v.remove(aLength);
      a.remove(aLength);}
}
  void sketch() {
    colorMode(RGB);
    stroke(c1);
    pushMatrix();
    translate(d.get(0).x,d.get(0).y,d.get(0).z);
    sphere(10);
    popMatrix();}
  boolean returnStatic() {return this.isStatic;}
  PVector calcE(Body center) {
    PVector g = PVector.sub(center.getD(),this.getD());
    PVector r = PVector.mult(g.normalize(),1/epsilon0*center.getM()/4/PI/PVector.sub(center.getD(),this.getD()).magSq());
    //return r.limit(190);}
    return r;}
  PVector calcB(Body center) {
    if (center.getV().mag()==0.0) {
      return new PVector(0,0);}
    else {
      PVector g = PVector.sub(center.getD(),this.getD());
      PVector r = PVector.mult(center.getV().cross(g.normalize()),center.getM()*it*mu0/PVector.sub(center.getD(),this.getD()).magSq());
      return r;}
    }
  PVector calcRE(PVector pos) {
    PVector rp = PVector.sub(pos,d.get(0));
    PVector rp1 = PVector.sub(pos,d.get(0));
    float rd = rp.mag();
    PVector r2 = rp.cross(a.get(0));
    PVector r1 = rp1.cross(r2);
    return PVector.mult(r1,eq/4/PI/epsilon0/c/c/rd/rd/rd);
  }
  PVector calcRB(PVector pos) {
    PVector rp = PVector.sub(pos,d.get(0));
    float rd = rp.mag();
    PVector a1 = new PVector(a.get(0).x,a.get(0).y,a.get(0).z);
    PVector r1 = a1.cross(rp);
    return PVector.mult(r1,eq/4/PI/epsilon0/c/c/c/rd/rd);
  }
  PVector calcRELW(PVector pos) {
    PVector r = PVector.sub(pos,d.get(0));
    int retard = (int)(r.mag()*c/200.0);
    //retard = 0;
    r = PVector.sub(pos,d.get(retard));
    PVector betas = PVector.div(v.get(retard),c);
    PVector ns = PVector.div(r,r.mag());
    float gamma = 1.0/sqrt(1.0-betas.magSq());
    PVector betasdot = PVector.div(a.get(retard),c);
    PVector partA = PVector.sub(ns,betas);
    PVector partB = ns.cross(partA.cross(betasdot));
    partA = PVector.div(partA,gamma*gamma*pow(1.0-ns.dot(betas),3.0)*r.magSq());
    partB = PVector.div(partB,c*pow(1.0-ns.dot(betas),3.0)*r.mag());
    PVector total = PVector.add(partA,partB);
    total.div(4.0*PI*epsilon0/eq);
    return total;
  }
  PVector calcRBLW(PVector pos) {
    PVector r = PVector.sub(pos,d.get(0));
    int retard = (int)(r.mag()*c/200.0);
    //retard = 0;
    r = PVector.sub(pos,d.get(retard));
    PVector ns = PVector.div(r,r.mag());
    ns.div(c);
    return ns.cross(calcRELW(pos));
  }
  PVector getD() {return d.get(0);}
  PVector getV() {return v.get(0);}
  PVector getA() {return a.get(0);}
  float getM() {return this.m;}
  void setD(PVector d1) {d.set(0,d1);}
  void setV(PVector v1) {v.set(0,v1);}
  void setA(PVector a1) {a.set(0,a1);}
  void setColor(color c) {c1 = c;}
}
