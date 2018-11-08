Setting set = new Setting();

int index;

void settings(){
  //size(640, 480);
  fullScreen();
  index = 0;
}

void setup() {
  settingSetup();
}

void draw() {
  settingDraw()
}

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
