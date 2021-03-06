// Franciszek Mirecki & Borys Pachocki
// https://github.com/frncki/DPS-Project

import controlP5.*;

//user interface variables
Knob knobM1;
Knob knobM2;
Knob knobTheta1;
Knob knobTheta2;
Knob knobG;

Button startButton;
Button stopButton;

Textlabel authorsLabel;
Textlabel authorsNames;

float xPos = 1120;
float yPos1 = 40;
float factorPos = 150;

int colorM = color(255, 30, 30);
int colorL = color(255, 155, 0);

PFont pixelFont;

void setupUI(ControlP5 cp5) {
  
  cp5.addTab("default")
     .setColorBackground(color(0, 160, 100))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0))
     ;

  // if you want to receive a controlEvent when
  // a  tab is clicked, use activeEvent(true)

  cp5.getTab("default")
     .activateEvent(true)
     .setLabel("Simulation")
     .setId(1)
     ;

     //authors tab
     cp5.addTab("authors")
     .setColorBackground(color(220, 200, 20))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0))
     ;

     cp5.getTab("authors")
     .activateEvent(true)
     .setLabel("Authors")
     .setId(2)
     ;

     //exit tab
     cp5.addTab("exit")
     .setColorBackground(color(255, 0, 0))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0))
     ;

     cp5.getTab("exit")
     .activateEvent(true)
     .setLabel("exit")
     .setId(3)
     ;

  knobM1 = cp5.addKnob("m1")
               .setRange(2,40)
               .setValue(20)
               .setPosition(xPos, yPos1)
               .setRadius(50)
               .setColorBackground(colorM)
               .setDragDirection(Knob.HORIZONTAL)
               .setId(4)
               ;


  knobM2 = cp5.addKnob("m2")
               .setRange(2,40)
               .setValue(20)
               .setPosition(xPos, yPos1 + factorPos)
               .setRadius(50)
               .setColorBackground(colorM)
               .setDragDirection(Knob.HORIZONTAL)
               .setId(5)
               ;


  knobTheta1 = cp5.addKnob("theta1")
               .setRange(-90, 90)
               .setValue(degrees(PI/3))
               .setPosition(xPos, yPos1 + 2 * factorPos)
               .setRadius(50)
               .setColorBackground(colorL)
               .setDragDirection(Knob.HORIZONTAL)
               .setId(6)
               ;


  knobTheta2 = cp5.addKnob("theta2")
               .setRange(-90, 90)
               .setValue(degrees(PI/2))
               .setPosition(xPos, yPos1 + 3 * factorPos)
               .setRadius(50)
               .setColorBackground(colorL)
               .setDragDirection(Knob.HORIZONTAL)
               .setId(7)
               ;

  cp5.addToggle("disco")
     .setPosition(xPos+20, yPos1 + 4.1 * factorPos)
     .setLabel("disco")
     .setSize(50,20)
     .setValue(false)
     .setMode(ControlP5.SWITCH)
     .setId(9)
     ;


startButton = new Button(cp5, "startButton");

  startButton.setBroadcast(false)
     .setLabel("start")
     .setPosition(xPos - 40, 720)
     .setSize(80,30)
     .setColorBackground(color(70, 100, 225))
     .setValue(1)
     .setBroadcast(true)
     .getCaptionLabel().align(CENTER,CENTER)

     ;

  cp5.addButton("resetButton")
     .setBroadcast(false)
     .setLabel("reset")
     .setPosition(xPos + 60, 720)
     .setSize(80,30)
     .setColorBackground(color(5, 105, 10))
     .setValue(2)
     .setBroadcast(true)
     .getCaptionLabel().align(CENTER,CENTER)
     ;


  //authors tab
  pixelFont = createFont("VT323-Regular", 32);
  
  authorsLabel = cp5.addTextlabel("authorsLabel")
                    .setText("Made by:")
                    .setFont(createFont("VT323-Regular",36))
                    ;

  int aLabelWidth = authorsLabel.getWidth();
  authorsLabel.setPosition(width/2 - aLabelWidth, height/2 - 30);

  authorsNames = cp5.addTextlabel("authorsNames")
                    .setText("Borys Pachocki & Franciszek Mirecki")
                    .setFont(createFont("VT323-Regular",36))
                    ;
                    
  int nLabelWidth = authorsNames.getWidth();
  authorsNames.setPosition(width/2 - nLabelWidth, height/2);
  
  cp5.getController("authorsLabel").moveTo("authors");
  cp5.getController("authorsNames").moveTo("authors");
                    
  // Tab 'global' is a tab that lies on top of any
  // other tab and is always visible

  cp5.setAutoDraw(false);
}

void gui() {
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  cp5.draw();
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
}

void animateLabel(Textlabel label, int ii) {
  label.setColor(colors.get((int)ii));
  ii += 0.3;
  if(ii > 4) ii = 0;
}

void controlEvent(ControlEvent theControlEvent) {

  if (theControlEvent.isTab()) {
    println("got an event from tab : " + theControlEvent.getTab().getName() + " with id " + theControlEvent.getTab().getId());
    
    if (theControlEvent.getTab().getName() == "exit") {
     exit();
    }
    
    if (theControlEvent.getTab().getName() == "default") {
     visible = true;
    }
    
    if (theControlEvent.getTab().getName() == "authors") {
     visible = false;
     bg = 51;
    }
  }
  
  if(theControlEvent.getId() == 4) { //m1
    p1.setM(knobM1.getValue());
    p1.setR(knobM1.getValue());
  }
  
  if(theControlEvent.getId() == 5) { //m2
    p2.setM(knobM2.getValue());
    p2.setR(knobM2.getValue());
  }
  
  if(theControlEvent.getId() == 6) { //theta
    p1.setTheta(knobTheta1.getValue());
  }
  
  if(theControlEvent.getId() == 7) { //phi
    p2.setTheta(knobTheta2.getValue());
  }
  
  if(theControlEvent.getId() == 8) { //g
    p1.setG(knobG.getValue());
    p2.setG(knobG.getValue());
  }
  
  if(theControlEvent.getId() == 9) {//discomode
    if(!disco) disco = true;
    else {
      disco = false;
      bg = 51;
    }
  }
  
  if(theControlEvent.getName() == "startButton") {
    if(!moving) {
      moving = true;
      startButton.setLabel("stop");
      startButton.setColorBackground(color(235,0,0));
    } else {
      moving = false;
      startButton.setLabel("start");
      startButton.setColorBackground(color(70, 100, 225));

    }
  }
  
  if(theControlEvent.getName() == "resetButton") {
    frameCount = -1;
  }
}

void button(float theValue) {
  println("a button event. " + theValue);
}

void keyPressed() {
  if(keyCode == TAB) {
    if(visible) {
      cp5.getTab("authors").bringToFront();
      visible = false;
    } else {
      cp5.getTab("default").bringToFront();
      visible = true;
    }
  }
}
