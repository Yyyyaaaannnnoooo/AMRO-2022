/**
SimpleHTTPServer by Ramin Soleymani
This example creates a HTTP Server listening on port 8000 and
serves the index.html file, which is located in the data folder.
It also checks for query parameters under the path /midi.
http://127.0.0.1:8000/midi?note=${note}&channel=${channel}&velocity=${velocity}
*/

import http.*;
import themidibus.*;

SimpleHTTPServer server;

/*
POSSIBLE PROBLEM WITH MIDI BUS
SOLVED LIKE THIS
https://discourse.processing.org/t/does-themidibus-library-work-in-processing-4/31851/7
getting the .jar file from here: https://github.com/micycle1/themidibus/releases/tag/p4
*/

MidiBus midi;

int midi_ch = 0;


void setup() {
  size(400, 400);
  server = new SimpleHTTPServer(this);
  SimpleHTTPServer.useIndexHtml = false;
  // listening on port http://127.0.0.1:8000/midi
  server.serve("midi", "dummy.html", "logger");
  println("listening on port http://127.0.0.1:8000/midi");
  MidiBus.list();
  delay(1000);
  midi = new MidiBus(this, -1, "Bus 1");
  //noLoop();
}

// all callback methods must have these two parametertypes: String,Map<String,String>
// the map contains the parameters as field-value pairs
void logger(String uri, HashMap<String, String> parameterMap) {
  println("uri:", uri, "parameters:");
  println(parameterMap);
  println("send midi message");
  // add midi stuff down here
  int note = int(parameterMap.getOrDefault("note", "0"));
  int channel = int(parameterMap.getOrDefault("channel", "0"));
  int velocity = int(parameterMap.getOrDefault("velocity", "0"));
  
  println("note: ", note);
  println("channel: ", channel);
  println("velocity: ", velocity);
  midi.sendNoteOn(channel, note, velocity); // Send a Midi noteOn
  delay(200);
  midi.sendNoteOff(channel, note, velocity);
}

void draw() {
}

void keyPressed() {
  if (key == 's') {
    //println("sending midi from keyboard");
    //int note = int(random(0, 127));
    //println("note: ", note);
    //int channel = 0;
    //println("channel: ", channel);
    //int velocity = int(random(0, 127));
    //println("velocity: ", velocity);
    //midi.sendNoteOn(channel, note, velocity); // Send a Midi noteOn
    //delay(750);
    //midi.sendNoteOff(channel, note, velocity);
    
    arp();
  }
}
// make your own sequence of notes
int[] notes = {
  60,60,60,75,60,60,60,75,
  60,60,60,75,60,60,60,75,
  60,60,60,75,70,77,70,75,
  60,60,60,75,60,60,60,75,
  60,60,60,79,60,60,60,75,
  60,80,60,77,60,60,60,75,
  60,80,60,79,60,90,60,75,
  60,80,60,77,60,90,90,75
};

void arp() {
  float xoff = 0.0;
  for (int i = 0; i < 64; i++) {
    xoff = xoff + .25;
    //int note = int(noise(xoff) * 127);
    int note = notes[i];
    println("note: ", note);
    int channel = 0;
    println("channel: ", channel);
    int velocity = int(random(0, 127));
    println("velocity: ", velocity);
    midi.sendNoteOn(channel, note, velocity); // Send a Midi noteOn
    delay(50);
    midi.sendNoteOff(channel, note, velocity);
    delay(150);
    
  }
}
