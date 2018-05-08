// Franciszek Mirecki & Borys Pachocki
// https://github.com/frncki/DPS-Project

class Pendulum {

  PVector pos;
  float m, l, r, theta, phi;
  color c;
  
  Pendulum(boolean which, float m, float l, float theta, float phi, color c) {
    this. m = m;
    this.l = l;
    this.theta = theta;
    this.phi = phi;
    this.pos = new PVector();
    if(which) {
      this.pos.x = l * cos(phi) * sin(theta);
      this.pos.y = l * sin(phi) * sin(theta);
      this.pos.z = l * cos(theta);
    }
    this.r = sigmoid(m);
    this.c = c;
  }
  
  PVector getPos() {return pos;}
  
  void setSecondPos(PVector firstPos) {
    this.pos.x = firstPos.x + l * cos(phi) * sin(theta);
    this.pos.y = firstPos.y + l * sin(phi) * sin(theta);
    this.pos.z = firstPos.z + l * cos(theta);
    println(l);
  }
  
  void show() {
    stroke(c);
    lights();
    line(0, 0, 0, pos.x, pos.y, pos.z);
    strokeWeight(4);
    noStroke();
    translate(pos.x, pos.y, pos.z);
    sphere(r);
  }
  
  float sigmoid(float x) { //transformed sigmoid
    return 10 / (1 + exp(3.4 - x));
  }
}
