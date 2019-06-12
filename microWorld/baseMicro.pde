class Micro{
  //位置相關
  PVector acceleration;
  PVector velocity;
  PVector location;
  PVector center;
  float maxForce;
  float edge; //移動邊境
  //外觀相關
  int mfNUM;
  String m;
  float size;
  float sizeCount;
  float sizeScale;
  color mc;
  //生存時間相關
  int lifeCount;
  int lifeTime;

  //---------------------------------------------------------------------------
  Micro(){
    //初始化位置
    acceleration = new PVector(0, 0);
    velocity = new PVector(random(-1, 1), random(-1, 1));
    maxForce = random(0.5, 1);
    center = new PVector(b.width/2, b.height/2); //中心點
    location = new PVector(center.x, center.y);
    PVector dir = PVector.random2D();
    float scale = random(10, center.x*0.8);
    dir.mult(scale);
    location.add(dir);
    //初始化外觀
    mfNUM = floor(random(micros.length));
    m = micros[mfNUM];
    size = ceil(random(40, 60));
    sizeCount = 0.0;
    sizeScale = 0.0;
    mc = mainColor;
    //計算邊緣
    edge = center.x - (size/2);
    //初始化生存時間
    lifeCount = 0;
    lifeTime = ceil(random(360, 480));
  }

  //---------------------------------------------------------------------------
  void microUpdate(){
    mcr_life();
    mcr_born();
    mcr_updatePhysics();
    mcr_dead();
  }
  //------------------------------->> 生存時間
  void mcr_life(){
    //計算
    if(lifeCount <= lifeTime){
      lifeCount++;
    }
  }
  //>>-------------------------------
  void mcr_born(){
    //
    if(lifeCount < 60){
      float s = map(lifeCount, 0, 60, 0, 1);
      float se = easeInOutQuint(s);
      sizeCount = se;
    }
  }
  //>>-------------------------------
  void mcr_dead(){
    if(lifeCount >= (lifeTime-90)){
      float s = map(lifeCount, lifeTime-90, lifeTime, 1, 0);
      float se = easeOutElastic(constrain(s, 0, 1.5));
      mc = subColor;
      sizeCount = se;
    }
    else{
      mc = mainColor;
    }
  }
  //>>-------------------------------
  void mcr_setToDead(){
    lifeCount = lifeTime-90;
  }
  //>>-------------------------------
  boolean mcrIsDead(){
    if(lifeCount == lifeTime){
      return true;
    }
    else{
      return false;
    }
  }
  //------------------------------->> 移動位置
  void mcr_updatePhysics(){
    velocity.add(acceleration);
    velocity.limit(maxForce);
    location.add(velocity);
    mcr_edge();
    acceleration.mult(0);
  }
  //>>-------------------------------
  void mcr_applyForce(PVector force){
    acceleration.add(force);
  }
  //>>-------------------------------
  void mcr_edge(){
    float d = PVector.dist(location, center);
    if(d >= edge){
      velocity.mult(-1);
    }
  }

  //---------------------------------------------------------------------------
  void microDisplay(){
    b.pushMatrix();
    b.textFont(microFont);
    b.fill(mc);
    b.textSize(size);
    b.textAlign(CENTER,CENTER);
    b.translate(location.x, location.y);
    b.scale(sizeCount);
    b.text(m, 0, 0);
    b.popMatrix();
  }
}
