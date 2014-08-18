import processing.serial.*;
import oscP5.*;

Serial myPort;  // Create object from Serial class
OscP5 oscP5;

SmartRobot robot;

int found;
float smileThreshold = 16;
float mouthWidth, previousMouthWidth;

void setup() 
{
  size(400,60); //make our canvas 200 x 200 pixels big
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
    frameRate(30);
  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  try {
    robot = new SmartRobot();
  } catch (AWTException e) {
  }


}


void draw() {
  background(255);
  if (mouthWidth > smileThreshold) 
  {                           //if we clicked in the window
   myPort.write('1');         //send a 1
   println("1");

    noStroke();
    fill(mouthWidth > smileThreshold ? color(255, 0, 0) : 0);
    float drawWidth = map(mouthWidth, 10, 25, 0, width);
    rect(0, 0, drawWidth, 64);
     text(nf(mouthWidth, 0, 1), drawWidth + 10, 0);
       if (previousMouthWidth < smileThreshold && mouthWidth > smileThreshold) {
      robot.type(":)\n");
    }
    previousMouthWidth = mouthWidth; 
  }
 else 
  {                           //otherwise
  myPort.write('0');          //send a 0
  }   
}

/////////////////
public void found(int i) {
  found = i;
}

public void mouthWidthReceived(float w) {
  mouthWidth = w;
}

// all other OSC messages end up here
void oscEvent(OscMessage m) {
  if (m.isPlugged() == false) {
  }
}

