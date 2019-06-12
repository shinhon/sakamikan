class ChanceMicro{
  //>>------------------------------- 移動座標相關
  PVector startP;
  PVector position;
  PVector noff;
  //>>------------------------------- 外觀相關
  String m;
  int mNUM; //屬性
  float size;
  float sizeScale;
  color mc;
  //>>------------------------------- 進出場效果
  int cmInOutCount;
  int cmInOutTime;
  boolean cmIn;
  boolean cmOut;
  boolean isDead;

  //---------------------------------------------------------------------------
  ChanceMicro(){
    //初始化座標
    startP = new PVector(random(100, width-100), random(100, height-100));
    position = new PVector(startP.x, startP.y);
    noff = new PVector(random(1000),random(1000));
    //初始化外觀
    mNUM = floor(random(chance.length));
    m = chance[mNUM];
    size = random(40, 50);
    sizeScale = 1;
    mc = mainColor;
    //初始化進出場效果
    cmInOutTime = 90;
    cmInOutCount = 0;
    cmIn = true;
    cmOut = false;
    isDead = false;
  }

  //---------------------------------------------------------------------------
  void chanceMicro_update(){
    if(cmIn){
      cmBorn(); //更新外觀
    }
    else if(cmOut){
      cmDead();
    }
    else{
      cmWalkerUpdate(); //更新位置
      if(s3Borned) cmCrashUpdate();
    }
  }
  //>>-------------------------------
  void cmWalkerUpdate(){
    position.x = map(noise(noff.x),0,1,startP.x-200, startP.x+200);
    position.y = map(noise(noff.y),0,1,startP.y-200, startP.y+200);
    noff.add(0.01,0.01,0);
  }
  //>>-------------------------------
  void cmBorn(){
    if(cmInOutCount < cmInOutTime){
       cmInOutCount++;//更新時間
       if(cmInOutCount == cmInOutTime) cmIn = false;
       //------------------------------- 更新大小
       float t = map(cmInOutCount, 0, cmInOutTime, 0, 1);
       float value = easeOutElastic(t);
       sizeScale = value;
    }
  }
  //>>-------------------------------
  void cmDead(){
    if(cmInOutCount > 0){
      cmInOutCount--;
      if(cmInOutCount == cmInOutTime){
        cmOut = false;
        isDead = true;
      }
      //------------------------------- 更新大小
      float t = map(cmInOutCount, 0, cmInOutTime, 0, 1);
      float value = easeOutElastic(t);
      sizeScale = value;
    }
  }
  //>>-------------------------------
  boolean cmIsDead(){
    return isDead;
  }
  //>>-------------------------------
  void cmCrashUpdate(){
    float d = PVector.dist(baseLoc, position);
    if(d < (baRadius/2)){
      cmOut = true;
      mc = subColor;
      cmCrashEvent();
    }
  }
  //>>-------------------------------
  void cmCrashEvent(){
    switch(mNUM){
      case 0:
        v.mcrs_setToDead();//殺光村民
        v.mcrs_deadByChance();
        break;
      case 1:
        if(baLived < (baGoingToDead-40)){
          baLived = baLived - 30;
          baCrashed = true;
        }
        break;
      default:
        break;
    }
  }

  //---------------------------------------------------------------------------
  void chanceMicro_Draw(){
    pushMatrix();
    textFont(microFont);
    fill(mc);
    textSize(size);
    textAlign(CENTER,CENTER);
    translate(position.x, position.y);
    scale(sizeScale);
    text(m, 0, 0);
    popMatrix();
  }
}
