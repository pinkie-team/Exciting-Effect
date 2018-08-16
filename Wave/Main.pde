import processing.net.*;

int SIZE = 20;
int SENSORPORT = 10001;
int SETTINGPORT = 10002;
Ripple[] ripples = new Ripple[SIZE];
Server sensorServer;
Server settingServer;

void settings(){
  //size(640, 480);
  fullScreen();
}

void setup() {
  sensorServer = new Server(this, SENSORPORT);
  settingServer = new Server(this, SETTINGPORT);

  colorMode(HSB,100);
  background(0);
  smooth();
  frameRate(30);
  
  for(int i=0;i<SIZE;i++) {
    ripples[i] = new Ripple();
  }
}

void draw() {
  background(0);

  Client sensorClient = sensorServer.available();
  Client settingClient = settingServer.available();


  if (sensorClient !=null) {
    String positionY = sensorClient.readString();
      if (positionY != null) {
        println(positionY); // Pythonからのメッセージを出力
        makeRippleWithPython(int(positionY));
      }
  }
    if (settingClient !=null) {
    String effectMode = settingClient.readString();
      if (effectMode != null) {
        println(effectMode); // Pythonからのメッセージを出力
      }
  }
  for(int i=0;i<SIZE;i++) {
    if(ripples[i].getFlag()) {
      ripples[i].move();
      ripples[i].rippleDraw();
    }
  }
}

// mouse ver.
void mousePressed() {
  for(int i=SIZE-1;i>0;i--) {
    ripples[i] = new Ripple(ripples[i-1]);
  }
  ripples[0].init(mouseX,mouseY,random(5,15),int(random(10,80)));
}

// keyboard ver.
void keyPressed() {
  for(int i=SIZE-1;i>0;i--) {
    ripples[i] = new Ripple(ripples[i-1]);
  }
  ripples[0].init(int(random(0,width)),int(random(0,height)),random(5,15),int(random(10,80)));
}

void makeRippleWithPython(int position){
  for(int i=SIZE-1;i>0;i--) {
      ripples[i] = new Ripple(ripples[i-1]);
   }
   ripples[0].init(int(random(0,width)),position,random(5,15),int(random(10,80)));
}