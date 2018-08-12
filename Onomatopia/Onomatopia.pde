float FRICTION = 0.962;

public class Don{
  int x,y;
  float dia;
  float opacity;
  float speed;
  int colorH;
  boolean flag;
  
  Don() {
    init(0,0,0,0);
    flag = false;
  }

  public Don(Don src) {
    this.x = src.x;
    this.y = src.y;
    this.speed = src.speed;
    this.opacity = src.opacity;
    this.colorH = src.colorH;
    this.dia = src.dia;
    this.flag = src.flag;
  }

  public void init(int _x, int _y, float _speed, int _colorH) {
    x = _x;
    y = _y;
    speed = _speed;
    colorH = _colorH;
    dia = 0.0;
    opacity = 255.0;
    flag = true;
  }

  public void rippleDraw() {
    noFill();
  
    if(speed > 1.5) {
      textSize(100);
      textAlign(CENTER, CENTER);
      fill(colorH, colorH, colorH, opacity); 
      text("don", x, y);
    }
  }

  public void move() {
    dia += speed;
    opacity -= speed * 1.4;
    speed *= FRICTION;
    if(speed < 1.5) {
      flag = false;
    }
  }

  public boolean getFlag() {
    return flag;
  }
}

