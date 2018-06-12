// Franciszek Mirecki & Borys Pachocki
// https://github.com/frncki/DPS-Project

import peasy.*;
import controlP5.*;
import processing.opengl.*;

int bg, ii;

//UI variables
PeasyCam cam;
double distance = 350;
ControlP5 cp5;


//pendulum variables
Pendulum p1, p2;
boolean first, disco, moving, visible;
float l = 100;

float px2, py2;

void setup() {
  size(1280, 800, P3D);
  frameRate(60);
  
  bg = 51;
  
  cam = new PeasyCam(this, distance);
  cam.setYawRotationMode();
  cam.setMinimumDistance(distance);
  cam.setMaximumDistance(distance);
  
  cp5 = new ControlP5(this);
  setupUI(cp5);
  
  p1 = new Pendulum(20, l, PI/3, 0, color(40, 11, 11));
  p2 = new Pendulum(20, l/2, PI/2, 0, color(53, 23, 23));
  
  first = true;
  disco = false;
  moving = false;
  visible = true;
}

void draw() {
  
  background(bg);
  gui();
  
  translate(0, -150);
  rotateZ(-PI/2);
  rotateY(-PI/2);
  
  p1.setPos(first, new Pendulum());
  p2.setPos(!first, p1);
  if(visible) {
    if(disco) {
    if((ii % 8) == 0) {
      if(bg != 51) bg = 51;
      else bg = 220;
    }
  }
    p1.show(disco);
    p2.show(disco);
    if(moving) {
      p1.move(first, p2.getM(), p2.getTheta(), p2.getDTheta());
      p2.move(!first, p1.getM(), p1.getTheta(), p1.getDTheta());
    }
  }
  ii++;
}
