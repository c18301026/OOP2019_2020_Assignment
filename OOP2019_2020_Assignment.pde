/*
OOP Assignment
"Something beautiful to enjoy while listening to music"

Student Name: Rianlee Pineda
Student Number: C18301026
*/
import javax.sound.midi.*;

MidiChannel[] chan; // for playing sounds
int pressedSize = 70;
boolean[] pressed = new boolean[pressedSize]; // to check that a key has already been pressed
boolean helpOn = true; // to display help text on screen
int maxNumShapes = 20;
boolean barOn = true; // default display
Bar[] bars = new Bar[maxNumShapes]; // array to store bars that display on screen
int currentBar = 0;
Ripple[] ripples = new Ripple[maxNumShapes]; // array to store ripples that display on screen
int currentRipple = 0;

class Bar {
  float x, y, barW, barH;
  boolean on;
  
  // Default constructor
  Bar() {
    x = 0;
    y = 0;
    barW = 0;
    barH = 0;
    on = false;
  }
  
  // Method to initialise a bar's co-ordinates and size
  void initB(float x, float y) {
    this.x = x;
    this.y = y;
    barW = width * 0.05;
    barH = height * 0.1;
    on = true;
  }
  
  // Method to animate the bar
  void animB() {
    if(on) {
      // Bar grows in width, but shrinks in height
      barH -= 0.4;
      barW += 8;
      
      // If bar gets to a certain width, stop displaying it
      if(barW > width * 2) on = false;
    }
  }
  
  // Method to display bar
  void renderB() {
    if(on) {
      fill(0, 255, 255, 128);
      strokeWeight(1);
      stroke(0, 255, 255);
      rect(x, y, barW, barH);
    }
  }
}

class Ripple {
  float x, y, diameter;
  boolean on;
  
  // Default constructor
  Ripple() {
    x = 0;
    y = 0;
    diameter = 0;
    on = false;
  }
  
  // Method to initialise a ripple's co-ordinates and diameter
  void initR(float x, float y) {
    this.x = x;
    this.y = y;
    diameter = 0;
    on = true;
  }
  
  // Method to animate the ripple
  void animR() {
    if(on) {
      // Ripple grows in diameter
      diameter += 5;
      
      // If ripple gets to a certain diameter, stop displaying it
      if(diameter > height * 1.5) on = false;
    }
  }
  
  // Method to display ripple
  void renderR() {
    if(on) {
      noFill();
      strokeWeight(3);
      stroke(150, 255, 255, 200);
      circle(x, y, diameter);
    }
  }
}

void setup() {
  size(500, 500);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  colorMode(HSB);
  
  try {
    // Get a synthesizer
    Synthesizer synth = MidiSystem.getSynthesizer();
    synth.open();
    
    // Get the channels of the synthesizer
    chan = synth.getChannels();
    
    // Default sound is cello
    chan[0].programChange(42);
  } catch(Exception e) {}
  
  // None of the keys have been pressed yet
  for(int i = 0; i < pressedSize; i++) {
    pressed[i] = false;
  }
  
  // Create bar objects
  for(int i = 0; i < bars.length; i++) {
    bars[i] = new Bar();
  }
  
  // Create ripple objects
  for(int i = 0; i < ripples.length; i++) {
    ripples[i] = new Ripple();
  }
}

void draw() {
  background(0);
  
  // Display help text
  if(helpOn) {
    fill(255);
    text("Left key: Cello (default)\nRight key: Mandocello/guitar\nDown key: Hide help\nZ key: C2\nA key: G2\nQ key: D3\n1 key: A3", width / 2, height / 2);
  }
  
  // Display bars (in response to key presses)
  for(int i = 0; i < bars.length; i++) {
    bars[i].animB();
    bars[i].renderB();
  }
  
  // Display ripples (in response to key presses)
  for(int i = 0; i < ripples.length; i++) {
    ripples[i].animR();
    ripples[i].renderR();
  }
}

void keyPressed() {
  // Change instrument sound to cello and change render to bars
  if(keyCode == LEFT) {
    chan[0].programChange(42);
    barOn = true;
  }
  
  // Change instrument sound to mandocello/guitar and change render to ripples
  if(keyCode == RIGHT) {
    chan[0].programChange(25);
    barOn = false;
  }
  
  // Hide help text
  if(keyCode == DOWN) {
    helpOn = false;
  }
  
  // Key needs to only be pressed once to play a note
  if((!pressed[midiNoteNo()]) && midiNoteNo() != 0) {
    chan[0].noteOn(midiNoteNo(), 100);
    
    // Start the bar/ripple when a note plays
    if(barOn) {
      float x = width / 2;
      float y = map(midiNoteNo(), 36, 66, height, 0);
      bars[currentBar].initB(x, y);
      currentBar++;
    } else {
      float x = map(midiNoteNo(), 36, 66, 0, width);
      float y = height / 2;
      ripples[currentRipple].initR(x, y);
      currentRipple++;
    }
    
    pressed[midiNoteNo()] = true;
  }
  
  // Reset the current bar and ripple to 0 to prevent an array out of bounds error
  if(currentBar == bars.length) currentBar = 0;
  if(currentRipple == ripples.length) currentRipple = 0;
}

void keyReleased() {
  // Note stops playing when key is released
  chan[0].noteOff(midiNoteNo(), 100);
  
  pressed[midiNoteNo()] = false;
}

// Method to return MIDI note values, e.g., 36 = C, 37 = C#, 38 = D
int midiNoteNo() {
  // Cello layout for QWERTY keyboard
  switch(key) {
    case 'z':
    case 'Z':
      return 36;
    case 'x':
    case 'X':
      return 37;
    case 'c':
    case 'C':
      return 38;
    case 'v':
    case 'V':
      return 39;
    case 'b':
    case 'B':
      return 40;
    case 'n':
    case 'N':
      return 41;
    case 'm':
    case 'M':
      return 42;
    case ',':
    case 'a':
    case 'A':
      return 43;
    case '.':
    case 's':
    case 'S':
      return 44;
    case '/':
    case 'd':
    case 'D':
      return 45;
    case 'f':
    case 'F':
      return 46;
    case 'g':
    case 'G':
      return 47;
    case 'h':
    case 'H':
      return 48;
    case 'j':
    case 'J':
      return 49;
    case 'k':
    case 'K':
    case 'q':
    case 'Q':
      return 50;
    case 'l':
    case 'L':
    case 'w':
    case 'W':
      return 51;
    case ';':
    case 'e':
    case 'E':
      return 52;
    case 'r':
    case 'R':
      return 53;
    case 't':
    case 'T':
      return 54;
    case 'y':
    case 'Y':
      return 55;
    case 'u':
    case 'U':
      return 56;
    case 'i':
    case 'I':
    case '1':
      return 57;
    case 'o':
    case 'O':
    case '2':
      return 58;
    case 'p':
    case 'P':
    case '3':
      return 59;
    case '4':
      return 60;
    case '5':
      return 61;
    case '6':
      return 62;
    case '7':
      return 63;
    case '8':
      return 64;
    case '9':
      return 65;
    case '0':
      return 66;
    default:
      return 0;
  }
}
