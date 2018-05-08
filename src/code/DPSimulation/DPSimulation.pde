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
boolean first = true;
Pendulum p1, p2;

void setup() {
  size(1280, 800, P3D);
  
  cam = new PeasyCam(this, distance);
  cam.setYawRotationMode();
  cam.setMinimumDistance(distance);
  cam.setMaximumDistance(distance);
  
  cp5 = new ControlP5(this);
  
  setupUI(cp5);

  p1 = new Pendulum(first, 100, 100, 0, 0, color(0, 0, 225));
  p2 = new Pendulum(!first, 100, 100, PI/4, PI/2, color(255, 255, 0));
  //println(p1.getPos());
  p2.setSecondPos(p1.getPos());
}

void draw() {
  background(51);
  gui();
  translate(0, -150);
  rotateZ(-PI/2);
  rotateY(-PI/2);
  p1.show();
  p2.show();
}
