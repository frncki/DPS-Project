// Franciszek Mirecki & Borys Pachocki
// https://github.com/frncki/DPS-Project

class Pendulum {

  PVector pos;
  float m, l, r, theta, phi;
  float dtheta, dphi, ddtheta, ddphi;
  color c;
  
  Pendulum( float m, float l, float theta, float phi, color c) {
    this. m = m;
    this.l = l;
    this.theta = radians(theta);
    this.phi = radians(phi);
    this.pos = new PVector();
    this.r = sigmoid(m);
    this.c = c;
  }
  
  
  
  void setPos(boolean which, PVector firstPos) {
    if(which) {
      this.pos.x = l * cos(phi) * sin(theta);
      this.pos.y = l * sin(phi) * sin(theta);
      this.pos.z = l * cos(theta);
    } else {
      this.pos.x = firstPos.x + l * cos(phi) * sin(theta);
      this.pos.y = firstPos.y + l * sin(phi) * sin(theta);
      this.pos.z = firstPos.z + l * cos(theta);
    }
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
  
  void move(boolean which, float m2, float l2, float theta2, float phi2) {
    if(which) {
     // this.theta += 0.01;
      this.phi += -0.02;
    } else {
      this.theta += -0.02;
      this.phi += 0.2;
    }
  }
  
  float sigmoid(float x) {return 10 / (1 + exp(3.4 - x));} //transformed sigmoid
  
  PVector getPos() {return pos;}
  float getM() {return m;}
  float getTheta() {return theta;}
  float getPhi() {return phi;}
  float getL() {return l;}
}
