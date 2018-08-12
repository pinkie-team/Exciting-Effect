import processing.net.*;

int SIZE = 20;
int PORT = 10001;
Don[] ripples = new Don[SIZE];
Server server;

void settings(){
  //size(640, 480);
  fullScreen();
}

void setup() {
  server = new Server(this, PORT);

  colorMode(HSB,100);
  background(0);
  smooth();
  frameRate(30);
  
  for(int i=0;i<SIZE;i++) {
    ripples[i] = new Don();
  }
}

void draw() {
  background(0);

  Client client = server.available();

  if (client !=null) {
    String whatClientSaid = client.readString();
      if (whatClientSaid != null) {
        println(whatClientSaid); // Pythonからのメッセージを出力
        makeRippleWithPython(int(whatClientSaid));
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
    ripples[i] = new Don(ripples[i-1]);
  }
  ripples[0].init(mouseX,mouseY,random(5,15),int(random(10,80)));
}

// keyboard ver.
void keyPressed() {
  for(int i=SIZE-1;i>0;i--) {
    ripples[i] = new Don(ripples[i-1]);
  }
  ripples[0].init(int(random(0,width)),int(random(0,height)),random(5,15),int(random(30,240)));
}

void makeRippleWithPython(int position){
  for(int i=SIZE-1;i>0;i--) {
      ripples[i] = new Don(ripples[i-1]);
   }
   ripples[0].init(int(random(0,width)),position,random(5,15),int(random(10,80)));
}
