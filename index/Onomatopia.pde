import java.util.List;
import java.util.ArrayList;

float FRICTION = 0.962;

public class Don{
  int x,y;
  float dia;
  float opacity;
  float speed;
  boolean flag;
  PImage donImg;
  
  Don() {
    init(0,0,0);
    flag = false;
  }

  public Don(Don src) {
    this.x = src.x;
    this.y = src.y;
    this.speed = src.speed;
    this.opacity = src.opacity;
    this.dia = src.dia;
    this.flag = src.flag;
    this.donImg = src.donImg;
  }
  
  public void init(int _x, int _y, float _speed) {
    x = _x;
    y = _y;
    speed = _speed;
    dia = 0.0;
    opacity = 255.0;
    flag = true;
  }

  public void init(int _x, int _y, float _speed, PImage _img) {
    x = _x;
    y = _y;
    speed = _speed;
    dia = 0.0;
    opacity = 255.0;
    flag = true;
    donImg = _img;
  }
    

  public void rippleDraw() {
    noTint();  
    if(speed > 0.1) {
      tint(#FFFFFF, opacity);
      image(donImg, x, y);
    }
  }

  public void move() {
    dia += speed;
    opacity -= speed * 1.6;
    speed *= FRICTION;
    if(speed < 0.1) {
      flag = false;
    }
  }

  public boolean getFlag() {
    return flag;
  }
}

public String selectOnomatopiaImg(String[] keys, float sensorValue){
  float DEMO = 0.0;
  float BOUND = 0.01;
  float PATI = -1.0;
  int randomIndex;
  List<String> k = new ArrayList<String>();
  
  if(sensorValue == DEMO){
    for(String key: keys){
      k.add(key);
    }

  }else if(sensorValue == PATI){
    for(String key: keys){
      if((key.indexOf("pati")) != -1){
        k.add(key);
      }
    }
    
  }else if(Math.abs(sensorValue) >= BOUND && sensorValue != DEMO){
    for(String key: keys){
      if((key.indexOf("don")) != -1){
        k.add(key);
      }
    }

  }else{
    for(String key: keys){
      if((key.indexOf("kan")) != -1){
        k.add(key);
      }
    }
  }
  
  randomIndex = int(random(0,k.size()));
  return k.get(randomIndex);
}
