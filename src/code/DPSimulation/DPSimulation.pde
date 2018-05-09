// Franciszek Mirecki & Borys Pachocki
// https://github.com/frncki/DPS-Project


import peasy.*;
import controlP5.*;
import processing.opengl.*;
//UI variables
PeasyCam cam;
double distance = 350;
ControlP5 cp5;


//pendulum variables
Pendulum p1, p2;
boolean first = true;
float l = 100;

void setup() {
  size(1280, 800, P3D);
  frameRate(60);
  cam = new PeasyCam(this, distance);
  cam.setYawRotationMode();
  cam.setMinimumDistance(distance);
  cam.setMaximumDistance(distance);
  
  cp5 = new ControlP5(this);
  setupUI(cp5);
  
  p1 = new Pendulum(40, l, 0, 0, color(0, 0, 225));
  p2 = new Pendulum(40, l/2, PI/3, 0, color(255, 255, 0));
  println(degrees(p2.getTheta()));
}

void draw() {
  background(51);
  gui();
  
  translate(0, -150);
  rotateZ(-PI/2);
  rotateY(-PI/2);
  
  p1.setPos(first, new Pendulum());
  p2.setPos(!first, p1);
  
  p1.show();
  p2.show();
  
  p1.move(first, p2.getM(), p2.getTheta(), p2.getPhi(), p2.getDTheta(), p2.getDPhi(), 1);
  p2.move(!first, p1.getM(), p1.getTheta(), p1.getPhi(), p1.getDTheta(), p1.getDPhi(), 1);
}
