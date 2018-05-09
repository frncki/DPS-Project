// Franciszek Mirecki & Borys Pachocki
// https://github.com/frncki/DPS-Project


import peasy.*;
import controlP5.*;
import processing.opengl.*;
//UI variables
PeasyCam cam;
double distance = 300;
ControlP5 cp5;


//pendulum variables
Pendulum p1, p2;
boolean first = true;
float l = 100;

void setup() {
  size(1280, 800, P3D);
  
  cam = new PeasyCam(this, distance);
  cam.setYawRotationMode();
  cam.setMinimumDistance(distance);
  cam.setMaximumDistance(distance);
  
  cp5 = new ControlP5(this);
  setupUI(cp5);
  
  p1 = new Pendulum(100, l, 45, 90, color(0, 0, 225));
  p2 = new Pendulum(100, l/2, 45, -90, color(255, 255, 0));
}

void draw() {
  background(51);
  gui();
  
  translate(0, -150);
  rotateZ(-PI/2);
  rotateY(-PI/2);
  
  p1.setPos(first, new PVector());
  p2.setPos(!first, p1.getPos());
  
  p1.show();
  p1.move(first, p2.getM(), p2.getTheta(), p2.getPhi());
  
  p2.move(!first, p1.getM(), p1.getTheta(), p1.getPhi());
  p2.show();
  
}
