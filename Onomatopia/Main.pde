import processing.net.*;
import java.util.Map;

int SIZE = 20;
int PORT = 10001;
Don[] ripples = new Don[SIZE];
Server server;

HashMap<String,PImage> donImgs = new HashMap<String,PImage>();
String[] keys;

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
  
  donImgs.put("red",    loadImage("img/don_red.png"));
  donImgs.put("blue",   loadImage("img/don_blue.png"));
  donImgs.put("green",  loadImage("img/don_green.png"));
  donImgs.put("orenge", loadImage("img/don_orenge.png"));
  keys = donImgs.keySet().toArray(new String[donImgs.size()]);

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
  ripples[0].init(mouseX,mouseY,6,donImgs.get(selectOnomatopiaImg(keys,0.0)));
}

// keyboard ver.
void keyPressed() {
  for(int i=SIZE-1;i>0;i--) {
    ripples[i] = new Don(ripples[i-1]);
  }
  ripples[0].init(int(random(0,width)),int(random(0,height)),6,donImgs.get(selectOnomatopiaImg(keys,0.0)));
}


void makeRippleWithPython(int position){
  for(int i=SIZE-1;i>0;i--) {
      ripples[i] = new Don(ripples[i-1]);
   }
   ripples[0].init(int(random(0,width)),position,6,donImgs.get("red"));
}