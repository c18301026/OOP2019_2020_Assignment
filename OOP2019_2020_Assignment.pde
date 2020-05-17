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

void setup() {
  size(500, 500);
  textAlign(CENTER, CENTER);
  
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
}

void draw() {
  background(0);
  
  if(helpOn) {
    text("Left key: Cello (default)\nRight key: Mandocello/guitar\nZ key: C2\nA key: G2\nQ key: D3\n1 key: A3\nSpace Key: Hide help", width / 2, height / 2);
  }
}

void keyPressed() {
  // Change instrument sound to cello
  if(keyCode == LEFT) {
    chan[0].programChange(42);
  }
  
  // Change instrument sound to mandocello/guitar
  if(keyCode == RIGHT) {
    chan[0].programChange(25);
  }
  
  // Press space key to display/hide help text
  if(key == ' ') {
    helpOn = false;
  }
  
  if((!pressed[midiNoteNo()]) && midiNoteNo() != 0) {
    chan[0].noteOn(midiNoteNo(), 100);
    
    pressed[midiNoteNo()] = true;
  }
}

void keyReleased() {
  chan[0].noteOff(midiNoteNo(), 100);
  
  pressed[midiNoteNo()] = false;
}

// Method to return MIDI notes, e.g., 36 = C, 37 = C#
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
