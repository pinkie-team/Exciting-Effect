Setting set = new Setting();

void settings(){
  //size(640, 480);
  fullScreen();
}

void setup() {
  colorMode(HSB,100);
  background(0);
  smooth();
  frameRate(30);
}

void draw() {
  background(0);
  set.showIntro();
  set.showCursor();

}