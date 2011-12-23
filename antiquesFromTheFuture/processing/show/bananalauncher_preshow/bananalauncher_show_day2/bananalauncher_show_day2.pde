
import ddf.minim.*;
import fullscreen.*; 

FullScreen fs; 

/*
import ddf.minim.signals.*;
 import ddf.minim.analysis.*;
 import ddf.minim.effects.*;
 */


import processing.video.*;
import processing.serial.*;

Serial myPort;        
int switchValue; 
int lastFrame; 
int lastByte; 

boolean dataReceived = false;


Minim minim;
AudioPlayer[] baba; 
AudioPlayer[] nana;
int numAudio = 0; 

Movie movie;
int numFrame = 0;
PFont font;
boolean isPlaying; 
int numMovie; 

int state; 
int timer; 

Banana[] banana; 
int [] video;  
String [] splits; 

//-----------------------------------------------------------------
void setup () {
  size (640, 480); 
  background (0); 
  smooth(); 
  noStroke(); 

  fs = new FullScreen(this); 
  // enter fullscreen mode
  //fs.setResolution (1680, 1050); 
  


  println(Serial.list());
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);



  String []input = loadStrings ("bananas_day1.csv"); 
  movie = new Movie(this, "bananas2.mov");
  state = 0; 
  timer = 0; 

  movie.play();
  movie.goToBeginning();
  movie.pause();
  isPlaying = false;  

  font = loadFont("DejaVuSans-24.vlw");
  textFont(font, 24);

  banana = new Banana [input.length]; 
  //println ("banana is:" + " " + banana.length + " input is " +  input.length); 

  minim = new Minim (this); 
  baba = new AudioPlayer [16]; 
  nana = new AudioPlayer [16]; 

  for (int i = 0; i < baba.length; i++) {
    baba[i] = minim.loadFile ("bananas/baba_" + i + ".aif", 2048);
    baba[i].pause();
  }

  for (int i = 0; i < nana.length; i++) {
    nana[i] = minim.loadFile ("bananas/nana_" + i + ".aif", 2048);
    nana[i].pause();
  }

  video = new int [input.length]; 
  splits = new String [input.length]; 

  for (int i = 1; i < input.length; i++) {
    println ("number of markers: " + input.length); 
    splits = input[i].split(","); 
    //banana[i].releaseVideo = int(splits[0]);
    video[i] =  int(splits[0]);
    //banana[i].releaseVideo = int(splits[0]);

    //println (lia); 
    println (video[i]); 
    //println ("releasevideo " + banana[i].releaseVideo);

    //lastByte = 0;
  }
}

//-----------------------------------------------------------------
void draw () {

  if (dataReceived)
  {
    dataReceived = false;
    upNum();
    setFrame (video[numFrame]);
    //nana[numAudio].rewind();
    //baba[numAudio].rewind(); 

    println ("state is: " + state);
    switch (state) {  
    case 0: 
      if (baba[numAudio].position() < baba[numAudio].length()) baba[numAudio].play();
      //if the current frame is bigger than 0, and if the old one is still playing
      if (numAudio > 0) { 
        if (nana[numAudio-1].isPlaying()) nana[numAudio-1].pause();
        nana[numAudio-1].rewind();
      } 
      else {
        if (nana[nana.length-1].isPlaying()) nana[nana.length-1].pause();
        
      }
      break;

    case 1: 
      if (nana[numAudio].position() < nana[numAudio].length())nana[numAudio].play(); 
      if (numAudio > 0) { 
        if (baba[numAudio-1].isPlaying()) baba[numAudio-1].pause();
        baba[numAudio-1].rewind();
      } 
      else {
        if (baba[baba.length-1].isPlaying()) baba[baba.length-1].pause();
      }
      break;
    }
  }// close data received loop


  image(movie, 0, 0, width, height);
  fill(240, 20, 30);

  //text(getFrame() + " / " + (getLength() - 1), 10, 30);

  timer = getFrame(); 

  //println ("switchvalue " + switchValue); 
  switch (state) {

  case 0: //restingstate
    movie.pause(); 
    textSize (30); 

    break; 

  case 1: //launching
    if (numFrame < video.length-1) {   //if the current frame is less than the total 
      //play video
      if (timer < video[numFrame+1] ) {   //play the video while its not yet the next one
        movie.play();
      } 
      else {
        movie.pause();
      }
    } 
    else {
      movie.play();
    } 
    break;
  }
}


//-----------------------------------------------------------------
void movieEvent(Movie movie) {
  movie.read();
}

//------------------------------------------------------------------


void mouseClicked () {
  upNum(); 

  //create a lastPlayed variable before you enter this
  /*
  numFrame = (int)random (0, baba.length); 
   if (numFrame != lastFrame) lastFrame = numFrame; 
   */

  setFrame (video[numFrame]);
  println ("numframe is " + numFrame); 
  nana[numAudio].rewind();
  baba[numAudio].rewind();

  //save the current frame here 
  //lastFrame = numFrame; 

  //println ("numframe " + numFrame + " last frame " + lastFrame); 
  //println (numFrame); 


  if (state <1) {
    state++;
  } 
  else {
    state = 0;
  }
  
  switch (state) {

  case 0: 
    baba[numAudio].setGain (4); 
    if (baba[numAudio].position() < baba[numAudio].length()) baba[numAudio].play();
    //if the current frame is bigger than 0, and if the old one is still playing
    if (numAudio > 0) { 
      if (nana[numAudio-1].isPlaying()) nana[numAudio-1].pause();
    } 
    else {
      if (nana[nana.length-1].isPlaying()) nana[nana.length-1].pause();
    }
    break;

  case 1: 

    nana[numAudio].play(); 
    if (numAudio > 0) { 
      if (baba[numAudio-1].isPlaying()) baba[numAudio-1].pause();
    } 
    else {
      if (baba[baba.length-1].isPlaying()) baba[baba.length-1].pause();
    }
    break;
  }

}



//-----------------------------------------------------------------

void keyPressed() {
  if (key == 'p') {
    // toggle pausing
    if (!isPlaying) {
      movie.play();
    } 
    else {
      movie.pause();
    }
    isPlaying = !isPlaying;
  }

  if (key == 'q') {
    numFrame++ ;

    for (int i = 0; i<video.length; i++) {
      setFrame (video[numFrame]);
      println (numFrame);
    }
  }
  
  if (key == 'f') {
  fs.enter(); 
  } else if (key == 'F') {
  fs.leave(); 
  }
  
} 


//------------------------------------------------------------------

int getFrame() {    
  return ceil(movie.time() * movie.getSourceFrameRate()) - 1;
}

//-------------------------------------------------------------------
void setFrame(int n) {
  movie.play();

  float srcFramerate = movie.getSourceFrameRate();

  // The duration of a single frame:
  float frameDuration = 1.0 / srcFramerate;

  // We move to the middle of the frame by adding 0.5:
  float where = (n + 0.5) * frameDuration; 

  // Taking into account border effects:
  float diff = movie.duration() - where;
  if (diff < 0) {
    where += diff - 0.25 * frameDuration;
  }

  movie.jump(where);

  movie.pause();
}  
//---------------------------------------------------------------------

int getLength() {
  return int(movie.duration() * movie.getSourceFrameRate());
}  

//---------------------------------------------------------------------


void serialEvent (Serial myPort) {

  int inByte = myPort.read(); 
  //println ("inbyte " + inByte); 


  if (inByte != lastByte) 
  {
    dataReceived = true;

    //change State
    if (inByte == 0 ) {
      state = 0;
    }
    if (inByte == 1 ) {
      state = 1;
    }

  }
  //set lastByte
  lastByte = inByte;
  //println ("last is: " + lastByte); 

}

//---------------------------------------------------------------------
void upNum() {
  if (numFrame < video.length-1) {
    numFrame++ ;
  } 
  else {
    numFrame = 0;
  }
  
    if (numAudio < baba.length-1) {
    numAudio++ ;
  } 
  else {
    numAudio = 0;
  }
  println ("numFrame: " + numFrame + " numAudio: " + numAudio); 
}


//---------------------------------------------------------------------
void stop()
{
  // always close Minim audio classes when you are done with them

  minim.stop();
  super.stop();
}

