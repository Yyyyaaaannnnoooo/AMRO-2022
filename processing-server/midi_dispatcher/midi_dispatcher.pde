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
  midi.sendNoteOn(channel, note, velocity); // Send a Midi noteOn
  delay(200);
  midi.sendNoteOff(channel, note, velocity);
}

void draw() {
}
