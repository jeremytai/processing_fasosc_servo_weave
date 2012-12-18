// FaceOSC Servo Action
// by Truth Dare Double Dare / http://truthdaredoubledare.com
// Jeremy Tai Abbett / Franziska Hübler

import oscP5.*; //  Load OSC P5 library
import netP5.*; //  Load net P5 library
float eyebrow;

import processing.serial.*; //  Load serial library
Serial arduinoPort;         //  Set arduinoPort as serial connection

OscP5 oscP5; //  Set oscP5 as OSC connection
NetAddress myRemoteLocation;

void setup() {
  size(100, 100); // Processing screen size
  frameRate(5);
  
  oscP5 = new OscP5(this, 8338);   // Start oscP5, listening for incoming messages at port 8338 
  arduinoPort = new Serial(this, Serial.list()[0], 9600);    // Set arduino to 9600 baud

}

// open window
void draw() {
  textSize(40);
  if (eyebrow > 9) {
  }
}

void mousePressed() {
}

// parse the OSCface data
void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.checkAddrPattern("/gesture/eyebrow/left")==true) {
    float firstValue = theOscMessage.get(0).floatValue();
    eyebrow = firstValue;
    println("eyebrow = "+eyebrow);
    
    float temp = (map(eyebrow, 8, 10, 0, 180)); //set eye brow height and map to degree of servo rotation
    int tempint = int(temp);
    println("Moving to position " + tempint);

    String pos = str(tempint);
    arduinoPort.write(pos);
    arduinoPort.write('.');
  }
}
