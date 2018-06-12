// Franciszek Mirecki & Borys Pachocki
// https://github.com/frncki/DPS-Project

class Pendulum {

  PVector pos;
  float m, l, r, theta, phi, g;
  float dtheta, dphi, ddtheta, ddphi;
  //float num1, num2, num3, num4, den;
  color c;
  ArrayList<Integer> colors = new ArrayList<Integer>();
  float ii;

  Pendulum() {}
  
  Pendulum( float m, float l, float theta, float phi, color c) {
    this. m = m;
    this.l = l;
    this.theta = theta;
    this.phi = phi;
    this.dtheta = 0;
    this.dphi = 0;
    this.pos = new PVector();
    this.r = sigmoid(m);
    this.c = c;
    g = 1;
    ii = 0;
    colors.add(color(255, 0, 0));
    colors.add(color(255, 127, 0));
    colors.add(color(255, 255, 0));
    colors.add(color(0, 180, 0));
    colors.add(color(0, 0, 255));
  }
  
  float sigmoid(float x) {return 40 / (1 + exp(7 - x/3.2));} //transformed sigmoid
  
  PVector getPos() {return pos;}
  
  float getM() {return m;}
  
  float getTheta() {return theta;}
  
  float getDTheta() {return dtheta;}
  
  float getPhi() {return phi;}
  
  float getDPhi() {return dphi;}
  
  float getX() {return pos.x;}
  
  float getY() {return pos.y;}

  
  void setM(float m) {this.m = m;}
  
  void setR(float r) {this.r = sigmoid(r);}
  
  void setTheta(float theta) {this.theta = theta;}
  
  void setG(float g) {this.g = g;}

    
  void setPos(boolean which, Pendulum prior) {
    if(which) {
      this.pos.y = l * sin(theta);
      this.pos.z = l * cos(theta);
      
      //this.pos.x = l * cos(phi) * sin(theta);
      //this.pos.y = l * sin(phi) * sin(theta);
      //this.pos.z = l * cos(theta)
    } else {
      this.pos.y = prior.pos.y + l * sin(theta);
      this.pos.z = prior.pos.z + l * cos(theta);
      
      //this.pos.x = firstPos.x + l * cos(phi) * sin(theta);
      //this.pos.y = firstPos.y + l * sin(phi) * sin(theta);
      //this.pos.z = firstPos.z + l * cos(theta);
    }
  }
  
  void show(boolean disco) {
    stroke(c);
    lights();
    line(0, 0, 0, pos.x, pos.y, pos.z);
    strokeWeight(4);
    noStroke();
    if(disco) {
      fill(colors.get((int)ii));
      ii += 0.3;
      if(ii > 4) ii = 0;
    } else {
      fill(200);
    }
    translate(pos.x, pos.y, pos.z);
    sphere(r);
  }
  
  void move(boolean which, float m2, float theta2, float dtheta2) {
    float num1, num2, num3, num4, den;
    if(which) {
      num1 = -g * (2 * this.m + m2) * sin(this.theta);
      num2 = -m2 * g * sin(this.theta - 2 * theta2);
      num3 = -2 * sin(this.theta - theta2) * m2;
      num4 = dtheta2 * dtheta2 * this.l + this.dtheta * this.dtheta * this.l * cos(this.theta - theta2);
      den = this.l * (2 * this.m + m2 - m2 * cos(2 * this.theta - 2 * theta2));
      ddtheta = (num1 + num2 + num3*num4) / den;
      dtheta += ddtheta;
      theta += dtheta;
      //println(theta);
      dtheta *= 0.99;
    } else {
      num1 = 2 * sin(theta2 - this.theta);
      num2 = (dtheta2 * dtheta2 * this.l * (m2 + this.m));
      num3 = g * (m2 + this.m) * cos(theta2);
      num4 = this.dtheta * this.dtheta * this.l * this.m * cos(theta2 - this.theta);
      den = this.l * (2 * m2 + this.m - this.m * cos(2 * theta2 - 2 * this.theta));
      ddtheta = (num1*(num2+num3+num4)) / den;
      dtheta += ddtheta;
      theta += dtheta;
      dtheta *= 0.99;
    }
  }
}
