import java.io.*;

OPC opc;
MEOWNGE meownge;

void setup() {
  size (600, 600);
    // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  meownge = new MEOWNGE(opc);
}

void draw() {
  background(0);
}

  