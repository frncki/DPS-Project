// Franciszek Mirecki & Borys Pachocki
// https://github.com/frncki/DPS-Project

import controlP5.*;


//user interface variables
Knob knobM1;
Knob knobM2;
Knob knobL1;
Knob knobL2;
Knob knobG;

Textlabel authorsLabel;
Textlabel authorsNames;

float xPos = 1120;
float yPos1 = 40;
float factorPos = 120;

int colorM = color(255, 30, 30);
int colorL = color(255, 155, 0);

//int buttonValue = 1;

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
     .setId(1)
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
     .setId(1)
     ;

  knobM1 = cp5.addKnob("m1")
               .setRange(1,25)
               .setValue(2)
               .setPosition(xPos, yPos1)
               .setRadius(50)
               .setColorBackground(colorM)
               .setDragDirection(Knob.HORIZONTAL)
               ;


  knobM2 = cp5.addKnob("m2")
               .setRange(1,25)
               .setValue(2)
               .setPosition(xPos, yPos1 + factorPos)
               .setRadius(50)
               .setColorBackground(colorM)
               .setDragDirection(Knob.HORIZONTAL)
               ;


  knobL1 = cp5.addKnob("l1")
               .setRange(1,25)
               .setValue(5)
               .setPosition(xPos, yPos1 + 2*factorPos)
               .setRadius(50)
               .setColorBackground(colorL)
               .setDragDirection(Knob.HORIZONTAL)
               ;


  knobL2 = cp5.addKnob("l2")
               .setRange(1,25)
               .setValue(5)
               .setPosition(xPos, yPos1 + 3*factorPos)
               .setRadius(50)
               .setColorBackground(colorL)
               .setDragDirection(Knob.HORIZONTAL)
               ;


  knobG = cp5.addKnob("g")
               .setRange(1,20)
               .setValue(9.81)
               .setPosition(xPos, yPos1 + 4*factorPos)
               .setRadius(50)
               .setColorBackground(color(5, 75, 10))
               .setDragDirection(Knob.HORIZONTAL)
               ;

  cp5.addToggle("disco")
     .setPosition(xPos+20, yPos1 + 5.2*factorPos)
     .setLabel("disco")
     .setSize(50,20)
     .setValue(false)
     //.setColorBackground(color(70, 70, 225))
     .setMode(ControlP5.SWITCH)
     ;



  cp5.addButton("startButton")
     .setBroadcast(false)
     .setLabel("start")
     .setPosition(xPos - 40, 720)
     .setSize(80,30)
     .setColorBackground(color(70, 100, 225))
     .setValue(1)
     .setBroadcast(true)
     .getCaptionLabel().align(CENTER,CENTER)
     ;

  cp5.addButton("stopButton")
     .setBroadcast(false)
     .setLabel("stop")
     .setPosition(xPos + 60, 720)
     .setSize(80,30)
     .setColorBackground(color(255, 65, 0))
     .setValue(2)
     .setBroadcast(true)
     .getCaptionLabel().align(CENTER,CENTER)
     ;


  //authors tab

  authorsLabel = cp5.addTextlabel("authorsLabel")
                    .setText("Authors:")
                    .setPosition(width/2, height/2)
                    .setHeight(20)
                    ;

  authorsNames = cp5.addTextlabel("authorsNames")
                    .setText("Borys Pachocki & Franciszek Mirecki")
                    .setPosition(width/2, height/2 + 20)
                    ;


  // arrange controller in separate tabs

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

void controlEvent(ControlEvent theControlEvent) {

  if (theControlEvent.isTab()) {
    println("got an event from tab : " + theControlEvent.getTab().getName() + " with id " + theControlEvent.getTab().getId());
  }

  //if (theControlEvent.getTab().getName() == "exit") {
  // exit();
  //}
}

void button(float theValue) {
  println("a button event. " + theValue);
}

void keyPressed() {
  
  if(keyCode == TAB) {
    cp5.getTab("authors").bringToFront();
  }
}
