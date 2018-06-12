// Franciszek Mirecki & Borys Pachocki
// https://github.com/frncki/DPS-Project

class Pendulum {

  double x, y, z;
  double m, l, r, theta, phi, g;
  double dtheta, dphi, ddtheta, ddphi;
  color c;
  float ii;

  Pendulum() {}
  
  Pendulum( double m, double l, double theta, double phi, color c) {
    this. m = m;
    this.l = l;
    this.theta = theta;
    this.phi = phi;
    this.dtheta = 0;
    this.dphi = 0;
    this.r = sigmoid(m);
    this.c = c;
    g = 1;
    ii = 0;
  }
  
  void setPos(boolean which, Pendulum prior) {
    if(which) {
      this.y = l * Math.sin(theta);
      this.z = l * Math.cos(theta);
    } else {
      this.y = prior.y + l * Math.sin(theta);
      this.z = prior.z + l *  Math.cos(theta);
    }
  }
  
  void show(boolean disco) {
    stroke(c);
    lights();
    line(0, 0, 0, (float)x, (float)y, (float)z);
    strokeWeight(4);
    noStroke();
    if(disco) {
      fill(colors.get((int)ii));
      ii += 0.3;
      if(ii > 4) ii = 0;
    } else {
      fill(200);
    }
    translate((float)x, (float)y, (float)z);
    sphere((float)r);
  }
  
  void move(boolean which, double m2, double theta2, double dtheta2) {
    double num1, num2, num3, num4, den;
    if(which) {
      num1 = -g * (2 * this.m + m2) *  Math.sin(this.theta);
      num2 = -m2 * g *  Math.sin(this.theta - 2 * theta2);
      num3 = -2 *  Math.sin(this.theta - theta2) * m2;
      num4 = dtheta2 * dtheta2 * this.l + this.dtheta * this.dtheta * this.l *  Math.cos(this.theta - theta2);
      den = this.l * (2 * this.m + m2 - m2 *  Math.cos(2 * this.theta - 2 * theta2));
      ddtheta = (num1 + num2 + num3*num4) / den;
      dtheta += ddtheta;
      theta += dtheta;
      dtheta *= 0.99;
    } else {
      num1 = 2 *  Math.sin(theta2 - this.theta);
      num2 = (dtheta2 * dtheta2 * this.l * (m2 + this.m));
      num3 = g * (m2 + this.m) *  Math.cos(theta2);
      num4 = this.dtheta * this.dtheta * this.l * this.m *  Math.cos(theta2 - this.theta);
      den = this.l * (2 * m2 + this.m - this.m *  Math.cos(2 * theta2 - 2 * this.theta));
      ddtheta = (num1*(num2+num3+num4)) / den;
      dtheta += ddtheta;
      theta += dtheta;
      dtheta *= 0.99;
    }
  }
  
  double sigmoid(double x) {return 30 / (1 + Math.exp(7 - x/3.2)) + 5;} //transformed sigmoid
    
  double getM() {return m;}
  
  double getTheta() {return theta;}
  
  double getDTheta() {return dtheta;}
  
  double getPhi() {return phi;}
  
  double getDPhi() {return dphi;}
  
  double getX() {return x;}
  
  double getY() {return y;}

  void setM(double m) {this.m = m;}
  
  void setR(double r) {this.r = sigmoid(r);}
  
  void setTheta(double theta) {this.theta = Math.toRadians(theta);}
  
  void setG(double g) {this.g = g;}
  
}
