int index;
String onomatopiaMode;

// setting
Setting set = new Setting();

// onomatopia
import processing.net.*;
import java.util.Map;

int SIZE = 20;
int PORT = 10001;
Don[] ripples = new Don[SIZE];
Server server;

HashMap<String,PImage> onomatopiaImgs = new HashMap<String,PImage>();
String[] keys;

//index
void settings(){
  //size(640, 480);
  fullScreen();

}

void setup() {
  settingSetup();
  index = 0;
  server = new Server(this, PORT);

}

void draw() {
  if (index == 0){
    settingDraw();
  } else if (index == 1){
    onomatopiaDraw();
  }
}

// setting
void settingSetup() {
  colorMode(HSB,100);
  background(0);
  smooth();
  frameRate(30);
}

void settingDraw() {
  background(0);
  set.showIntro();
  set.showCursor();
}

// onomatopedia
void onomatopediaSetup() {

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
  onomatopiaImgs.put("pati_green", loadImage("img/pati_green.png"));
  onomatopiaImgs.put("pati_pink",  loadImage("img/pati_pink.png"));
  onomatopiaImgs.put("pati_red",   loadImage("img/pati_red.png"));
  onomatopiaImgs.put("pati_white", loadImage("img/pati_white.png"));
  onomatopiaImgs.put("pati_yellow",loadImage("img/pati_yellow.png"));
  keys = onomatopiaImgs.keySet().toArray(new String[onomatopiaImgs.size()]);

  for(int i=0;i<SIZE;i++) {
    ripples[i] = new Don();
  }
}

void onomatopiaDraw() {
  background(0);

  Client client = server.available();

  if (client !=null) {
    String whatClientSaid = client.readString();
      if (whatClientSaid != null) {
        String s[] = splitTokens(whatClientSaid,",");
        println(whatClientSaid);
        println(s[0]); // Pythonからのメッセージを出力
        //makeRippleWithPython(int(whatClientSaid));
        makeRippleWithPython(int(s[0]),int(s[1]));
      }
  }
  for(int i=0;i<SIZE;i++) {
    if(ripples[i].getFlag()) {
      ripples[i].move();
      ripples[i].rippleDraw();
    }
  }
}

// onomatopia functions
// mouse ver.
void mousePressed() {
  if (index == 1){
    for(int i=SIZE-1;i>0;i--) {
      ripples[i] = new Don(ripples[i-1]);
    }
    switch (mouseButton){
    case LEFT:
      if(onomatopiaMode == "DON"){
        ripples[0].init(mouseX,mouseY,6,onomatopiaImgs.get(selectOnomatopiaImg(keys,0.1)));
      }else if(onomatopiaMode == "PATI"){
        ripples[0].init(mouseX,mouseY,6,onomatopiaImgs.get(selectOnomatopiaImg(keys,-1.0)));
      }
      break;
    case RIGHT:
      ripples[0].init(mouseX,mouseY,6,onomatopiaImgs.get(selectOnomatopiaImg(keys,0.001)));
      break;
    }
  }
}

// keyboard ver.
void keyPressed() {
  if (key == 'S' ||key =='s') {
    settingDraw();
    index = 0;
  } else if(key == 'O'||key == 'o') {
    onomatopediaSetup();
    onomatopiaMode = "DON";
    index = 1;
  } else if(key == 'P'||key == 'p') {
    onomatopiaMode = "PATI";
  } else if (index == 1){
    for(int i=SIZE-1;i>0;i--) {
      ripples[i] = new Don(ripples[i-1]);
    }
    ripples[0].init(int(random(0,width)),int(random(0,height)),6,onomatopiaImgs.get(selectOnomatopiaImg(keys,0.0)));
  }
}

void makeRippleWithPython(int positionX, int positionY){
  int marginX = int(width)/5;
  int marginY = int(height)/5;
  for(int i=SIZE-1;i>0;i--) {
      ripples[i] = new Don(ripples[i-1]);
   }
   //ripples[0].init(int(random(0,width)),positionX,6,onomatopiaImgs.get("don_red"));
   if(onomatopiaMode == "DON"){
     ripples[0].init(positionX,positionY,6,onomatopiaImgs.get(selectOnomatopiaImg(keys,0.1)));          
   }
   else if(onomatopiaMode == "PATI"){ 
     ripples[0].init(mouseX,mouseY,6,onomatopiaImgs.get(selectOnomatopiaImg(keys,-1.0)));
     ripples[1].init(int(random(marginX,width))-marginX,int(random(0,height)),6,onomatopiaImgs.get(selectOnomatopiaImg(keys,-1.0)));
     ripples[2].init(int(random(marginX,width))-marginX,int(random(0,height)),6,onomatopiaImgs.get(selectOnomatopiaImg(keys,-1.0)));
     ripples[3].init(int(random(marginX,width))-marginX,int(random(0,height)),6,onomatopiaImgs.get(selectOnomatopiaImg(keys,-1.0)));

   }
}
