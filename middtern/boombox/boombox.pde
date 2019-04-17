/**
 * First load a sample sound file from disk, then start manipulating it using the
 * low-level data access functions provided by AudioSample.
 * With every mouseclick, two random 1 second chunks of the sample are swapped around
 * in their position. The sample always stays the same length and it keeps on looping,
 * but the more often you do random swaps, the more the original soundfile gets cut up
 * into smaller and smaller portions that seem to be resampled at random.
 */
 import processing.serial.*;

Serial myPort;
int potState;
int buttonState;
int[] inputVars = {0, 0}; //make array to be populated from serial (note number of variables)

//import processing.serial.*;
//Serial myPort;
//int number;
//float volume;

import processing.sound.*;

SoundFile file;
boolean isPlaying = false;

int jitter = 0;

void setup() {
  size(500, 500);
  background(0255,3,3);
  println(Serial.list()); //print serial devices (remember to count from 0)
  myPort = new Serial(this, Serial.list()[2], 9600); //make sure the baudrate matches arduino
  myPort.bufferUntil('\n'); // don't generate a serialEvent() unless you get a newline character
  // Load a soundfile and start playing it on loop
  file = new SoundFile(this, "Minato-Ku.mp3");
  //file.loop();
}      


void draw() {
  
  if (file.isPlaying()){
    jitter = int(random(int(map(inputVars[0],0,1023,0,-10)), int(map(inputVars[0],0,1023,0,10))));
  }
  else{
    jitter = 0;
  }
  
  println(inputVars[1]);
  file.amp(map(inputVars[0],0,1023,0,1));
  if (!file.isPlaying() && inputVars[1] == 1){ 
    file.play();
    //isPlaying = true;
  }
  else if(file.isPlaying() && inputVars[1] == 1){
    file.pause();
    //isPlaying = false;
  }
   //body
  fill(156,156,156);
  rect(50, 150, 400, 200);
  //speaker left
  fill(0);
  square(70, 220, 100);
  fill(156,156,156);
  circle(120, 270, 96 + jitter);
  fill(0);
  circle(120, 270, 55 + jitter);
  fill(156,156,156);
  circle(120, 270, 40 + jitter);
  //speaker right
  fill(0);
  square(329, 220, 100);
   fill(156,156,156);
  circle(380, 270, 96 + jitter);
  fill(0);
  circle(380, 270, 55 + jitter);
  fill(156,156,156);
  circle(380, 270, 40 + jitter);
  //cassette player
  fill(0);
  rect(190, 260, 120, 80, 7);
  //cassette
  fill(156,156,156);
  rect(205, 272, 90, 55);
  fill(225,225,225,225);
  rect(205, 280, 90, 40);
  fill(0);
  circle(220, 300, 15);
  fill(0);
  circle(280, 300, 15);
  //bottoms
  fill(156,156,156);
  square(240, 135, 25);
  fill(156,156,156);
  square(280, 135, 25);
  fill(156,156,156);
  square(200, 135, 25);
  //volume
  fill(225,225,225,225);
  circle(255, 235, 25);
  fill(225,225,225,225);
  circle(295, 235, 25);
  fill(225,225,225,225);
  circle(215, 235, 25);
  fill(225,225,225,225);
  circle(80, 190, 25);
  fill(225,225,225,225);
  circle(120, 190, 25);
  fill(225,225,225,225);
  circle(370, 190, 25);
  fill(225,225,225,225);
  circle(410, 190, 25);
  
  //redio
  fill(225,225,225,225);
  rect(140, 169, 200, 40, 7);
  fill(0);
  fill(0);
  rect(140, 190, 200, 0, 7);
  rect(160, 175, 0, 30, 7);
  rect(180, 175, 0, 30, 7);
  rect(200, 175, 0, 30, 7);
  rect(220, 175, 0, 30, 7);
  fill(199, 0, 57);
  rect(240, 175, 5, 30, 7);
  rect(260, 175, 0, 30, 7);
  rect(280, 175, 0, 30, 7);
  rect(300, 175, 0, 30, 7);
  rect(320, 175, 0, 30, 7);
  rect(340, 175, 0, 30, 7);
     
  
  
  
  
   
  
  
  
}


void mousePressed() {
  //// Every time the mouse is pressed, take two random 1 second chunks of the sample
  //// and swap them around.

  //int partOneStart = int(random(file.frames()));
  //int partTwoOffset = int(random(file.frames() - file.sampleRate()));
  //// Offset part two by at least one second
  //int partTwoStart = partOneStart + file.sampleRate() + partTwoOffset;
  //// Make sure the start of the second sample part is not past the end of the file.
  //partTwoStart = partTwoStart % file.frames();

  //// Read one second worth of frames from each position
  //float[] partOne = new float[file.sampleRate()];
  //float[] partTwo = new float[file.sampleRate()];
  //file.read(partOneStart, partOne, 0, partOne.length);
  //file.read(partTwoStart, partTwo, 0, partTwo.length);
  //// And write them back the other way around
  //file.write(partOneStart, partTwo, 0, partTwo.length);
  //file.write(partTwoStart, partOne, 0, partOne.length);
}

void serialEvent (Serial myPort) {
  String inString = myPort.readStringUntil('\n'); //read until new line (Serial.println on Arduino)
  if (inString != null) {
    inString = trim(inString); // trim off whitespace
    inputVars = int(split(inString, '&')); // break string into an array and change strings to ints 
}
}
