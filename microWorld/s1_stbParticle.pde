class StbParticle{
  //座標位置相關
  PVector startP;
  PVector velocity;
  PVector stbLocation;

  //---------------------------------------------------------------------------
  StbParticle(){
    //初始化開始位置
    startP = new PVector(width/2, height/2);
    //決定移動方向
    PVector direct = PVector.random2D();
    float speed = random(1.5, 3.0);
    velocity = direct.copy();
    velocity.setMag(speed);
    //初始化位置
    stbLocation = startP.copy();
  }

  //---------------------------------------------------------------------------
  void stbPartUpdate(){
    stbLocation.add(velocity);
  }
  //>>-------------------------------
  boolean stbPisDead(){
    float d = PVector.dist(stbLocation, startP);
    if(d > (stbRadius/2)-20){
      return true;
    }
    else{
      return false;
    }
  }

  //---------------------------------------------------------------------------
  void stbPartDraw(){
    stroke(mainColor, stbA);
    strokeWeight(8);
    point(stbLocation.x, stbLocation.y);
  }
}
