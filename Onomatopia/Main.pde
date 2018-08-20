import processing.net.*;
import java.util.Map;

int SIZE = 20;
int PORT = 10001;
Don[] ripples = new Don[SIZE];
Server server;

HashMap<String,PImage> onomatopiaImgs = new HashMap<String,PImage>();
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
  
  onomatopiaImgs.put("don_red",    loadImage("img/don_red.png"));
  onomatopiaImgs.put("don_blue",   loadImage("img/don_blue.png"));
  onomatopiaImgs.put("don_green",  loadImage("img/don_green.png"));
  onomatopiaImgs.put("don_orenge", loadImage("img/don_orenge.png"));
  onomatopiaImgs.put("kan_red",    loadImage("img/kan_red.png"));
  onomatopiaImgs.put("kan_blue",   loadImage("img/kan_blue.png"));
  onomatopiaImgs.put("kan_green",  loadImage("img/kan_green.png"));
  onomatopiaImgs.put("kan_orenge", loadImage("img/kan_orenge.png"));
  onomatopiaImgs.put("kan_yellow", loadImage("img/kan_yellow.png"));
  keys = onomatopiaImgs.keySet().toArray(new String[onomatopiaImgs.size()]);

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
  ripples[0].init(mouseX,mouseY,6,onomatopiaImgs.get(selectOnomatopiaImg(keys,0.0)));
}

// keyboard ver.
void keyPressed() {
  for(int i=SIZE-1;i>0;i--) {
    ripples[i] = new Don(ripples[i-1]);
  }
  ripples[0].init(int(random(0,width)),int(random(0,height)),6,onomatopiaImgs.get(selectOnomatopiaImg(keys,0.0)));
}


void makeRippleWithPython(int position){
  for(int i=SIZE-1;i>0;i--) {
      ripples[i] = new Don(ripples[i-1]);
   }
   ripples[0].init(int(random(0,width)),position,6,onomatopiaImgs.get("don_red"));
}