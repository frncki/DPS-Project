// Franciszek Mirecki & Borys Pachocki
// https://github.com/frncki/DPS-Project

class Pendulum {

  PVector pos;
  float m, l, r, theta, phi;
  float dtheta, dphi, ddtheta, ddphi;
  color c;
  
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
  }
  
  float sigmoid(float x) {return 10 / (1 + exp(3.4 - x));} //transformed sigmoid
  
  PVector getPos() {return pos;}
  
  float getM() {return m;}
  
  float getTheta() {return theta;}
  
  float getDTheta() {return dtheta;}
  
  float getPhi() {return phi;}
  
  float getDPhi() {return dphi;}
    
  void setPos(boolean which, Pendulum prior) {
    if(which) {
      this.pos.y = l * sin(theta);
      this.pos.z = l * cos(theta);
      /*
      this.pos.x = l * cos(phi) * sin(theta);
      this.pos.y = l * sin(phi) * sin(theta);
      this.pos.z = l * cos(theta);
      */
    } else {
      this.pos.y = prior.pos.y + l * sin(theta);
      this.pos.z = prior.pos.z + l * cos(theta);
      /*
      this.pos.x = firstPos.x + l * cos(phi) * sin(theta);
      this.pos.y = firstPos.y + l * sin(phi) * sin(theta);
      this.pos.z = firstPos.z + l * cos(theta);
      */
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
  
  void move(boolean which, float m2, float theta2, float phi2, float dtheta2, float dphi2, float g) {
    //float numTheta, denTheta, numPhi, denPhi;
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
      println(theta);
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







      /*
      //------------theta------------
      //numerator
      float upPart1_1 = 4 * this.m + 3 * m2 + 2 * m2 * cos(2 * theta2) * cos(this.phi - phi2) * cos(this.phi - phi2)- m2 * cos(2 * (this.phi - phi2)) * sin(this.theta);
      
      float upPart1_2 =  2 * g * m2 * cos(this.theta) * cos(this.phi - phi2) * sin(2 * theta2);
      
      float upPart1 = 4 * g *(upPart1_1 - upPart1_2);
      
      float upPart2_1_1 = cos(this.theta) * cos(2 * theta2) * (3 + cos(2 * (this.phi - phi2))) * sin(this.theta);
      
      float upPart2_1_2 = 2 * cos(2 * this.theta) * cos(this.phi - phi2) * sin(2 * theta2);
      
      float upPart2_1_3 = sin(2 * this.theta) * sin(this.phi - phi2) * sin(this.phi - phi2) * this.dtheta * this.dtheta;
      
      float upPart2_1 = m2 * (upPart2_1_1 - upPart2_1_2 + upPart2_1_3);
      
      float upPart2_2 = 4 * m2 * (-cos(theta2) * sin(this.theta) + cos(this.theta) * cos(this.phi - phi2) * sin(theta2)) * dtheta2 * dtheta2;

      float upPart2_3 = ((2 * this.m + m2 - m2 * cos(2 * theta2)) * sin(2 * this.theta) - 2 * m2 * cos(this.phi - phi2) * sin(this.theta) * sin(this.theta) * sin(2 * theta2)) * this.dphi * this.dphi;
      
      float upPart2_4 = 4 * m2 * sin(theta2) * sin(theta2) * (-cos(theta2) * sin(this.theta) + cos(this.theta) * cos(this.phi - phi2) * sin(theta2)) * dphi2 * dphi2;
      
      float upPart2 = this.l * (-upPart2_1 + upPart2_2 + upPart2_3 + upPart2_4);
      
      numTheta = upPart1 + upPart2;
      
      //denumerator
      float downPart1 = 2 * r * (8 * this.m + 5 * m2);
      
      float downPart2_1 = 2 * cos(2 * this.theta) + 3 * cos(2 * (this.theta - theta2)) + 2 * cos(2 * theta2);
      
      float downPart2_2 = 3 * cos(2 * (this.theta + theta2)) + 8 * cos(2 * (this.phi - phi2)) * sin(this.theta) * sin(this.theta) * sin(theta2) * sin(theta2) + 8 * cos(this.phi - phi2) * sin(2 * this.theta) * sin(2 * theta2);
      
      float downPart2 = m2 * (downPart2_1 + downPart2_2);
      
      denTheta = downPart1 - downPart2;
      
      ddtheta = numTheta/denTheta;
      
      dtheta += ddtheta/50;
      
      theta += dtheta/50;
      
      println(theta);
      
      //------------phi------------
      //numerator
      numPhi = (2 * (2 * m2 * l  * ((1/sin(this.theta)) * (1/sin(this.theta))) * ((1/tan(this.theta)) * sin(2 * theta2) * sin(this.phi - phi2) + sin(theta2) * sin(theta2) * sin(2 * (this.phi - phi2))) * this.dtheta * this.dtheta + l * (1/tan(this.theta)) * (m2 + 8 * this.m * (1/sin(this.theta) * 1/sin(this.theta)) - m2 * ((1/tan(this.theta) * (1/tan(this.theta))) - 5 * ((1/sin(this.theta)) * (1/sin(this.theta))) + cos(2 * theta2) * (-6 + 4 * (1/sin(this.theta)) * (1/sin(this.theta))) + 4 * cos(2 * (this.phi - phi2)) * sin(theta2) * sin(theta2) + 8 * cos(this.phi - phi2) * (1/sin(this.theta)) * sin(2 * theta2))) * this.dtheta * this.dphi + 2 * m2 * (2 * l * (1/sin(this.theta) * (1/sin(this.theta) * (1/sin(this.theta)) * sin(theta2) * sin(this.phi - phi2) * dtheta2 * dtheta2 - ((1/tan(this.theta)) * sin(2*theta2) * sin(this.phi - phi2) + sin(theta2) * sin(theta2) * sin(2 * (this.phi - phi2))) * (g * (1/tan(this.theta)) * (1/sin(this.theta)) - l * this.dphi * this.dphi) + 2 * l * (1/sin(this.theta) * (1/sin(this.theta) * (1/sin(this.theta)) * sin(theta2) * sin(theta2) * sin(theta2) * sin(this.phi - phi2) * dphi2) * dphi2))))));

      //denumerator
      denPhi = l * (-m2 - 8 * this.m * ((1/sin(this.theta)) * (1/sin(this.theta))) + m2 * (1/tan(this.theta) * (1/tan(this.theta))) - 5 * (1/sin(this.theta) * (1/sin(this.theta))) + cos(2 * theta2) * (-6 + 4 * (1/sin(this.theta) * (1/sin(this.theta)))) + 4 * cos(2 * (this.phi - phi2)) * sin(theta2)  * sin(theta2) + 8 * cos(this.phi - phi2) * (1/tan(this.theta)) * sin(2 * theta2));
      
      ddphi = numPhi/denPhi;
      
      dphi += ddphi/50;
      
      phi += dphi/50;
      
      println(phi);
      */
