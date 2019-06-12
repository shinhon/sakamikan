//>>------------------------------- 座標位置相關
PVector baseLoc;
PVector baseAccel;
PVector baseVel;
float baMaxforce;    //最大作用力
float baMaxspeed;    //最高速度
//>>------------------------------- 外觀相關
int baRadius;
float arcStart;
float arcPercent;
color baColor;
//>>------------------------------- 碰撞
boolean baCrashed = false;
int baCrashCount;
int baCrashTime;
//>>------------------------------- 生存時間
int baLifespan = -1;
int baLived = 0;
int baGoingToDead;
boolean baGoNext;
//>>------------------------------- 村莊相關
PGraphics b;
Village v;

//---------------------------------------------------------------------------
void base_setup(){
  baseSetup();
  baseVSetup();
}
//------------------------------->>
void baseSetup(){
  //初始化座標
  baseAccel = new PVector(0,0);
  baseVel = new PVector(0,-2);
  baseLoc = new PVector(gaze.x,gaze.y);
  baMaxspeed = 4;
  baMaxforce = 0.1;
  //初始化外觀
  baRadius = 320;
  arcStart = radians(-90);
  arcPercent = radians(360);
  baColor = mainColor;
  //初始化碰撞外觀
  baCrashed = false;
  baCrashCount = 0;
  baCrashTime = 60;
  //初始化生存時間
  baLifespan = 2700;
  baLived = 0;
  baGoingToDead = baLifespan - 120;
  //初始化截圖
  s3Capture_setup(); //初始化截圖
  //下一幕
  baGoNext = false;
}
//------------------------------->>
void baseVSetup(){
  v = new Village();
}

//---------------------------------------------------------------------------
void base_update(){
  if(!baIsDead() && s3Borned){
    ba_lifeUpdate();
    baseVGoingToDead();
    baAppearUpdate();
    baseVUpdate();
  }
}
//------------------------------->> 生存時間更新
void ba_lifeUpdate(){
  if(baLived <= baLifespan){
    baLived++;
  }
  if(baLived == baLifespan){
    baGoNext = true;
  }
}
//>>-------------------------------
boolean baIsDead(){
  if(baLived > baLifespan){
    return true;
  }
  else{
    return false;
  }
}
//------------------------------->> 外觀更新
//整理
void baAppearUpdate(){
  ba_appearanceUpdate();
  ba_seek(gaze);
  ba_physicsUpdate();
  if(baCrashed) ba_crashedUpdate(); //碰撞偵測
}
//-------------------------------
void ba_appearanceUpdate(){
  float angle = map(baLived, 0, baLifespan, 360, 0);
  arcPercent = arcStart+radians(angle);
}
//-------------------------------
void ba_crashedUpdate(){
  if(baCrashCount < baCrashTime) {
    baCrashCount++;
    baColor = subColor;
  }
  if(baCrashCount == baCrashTime) {
    baColor = mainColor;
    baCrashCount = 0;
    baCrashed = false;
  }
}
//------------------------------->> 座標更新
void ba_physicsUpdate(){
  baseVel.add(baseAccel);
  baseVel.limit(baMaxspeed);
  baseLoc.add(baseVel);
  baseAccel.mult(0); //今入下一次描圖之間先將加速度歸零
}
//>>-------------------------------
void ba_applyForce(PVector force){
  baseAccel.add(force);
}
//>>-------------------------------
void ba_seek(PVector target){
  PVector desired = PVector.sub(target,baseLoc); //計算位置與目的地之距離
  desired.setMag(baMaxspeed); //將距離縮放為移動最高速度
  PVector steer = PVector.sub(desired,baseVel); //避免物件超速，指向力 ＝ 最高速 - 目前速度
  steer.limit(baMaxforce); //避免物件超速，指向力 != 最高作用力
  ba_applyForce(steer);
}
//------------------------------->> 村莊相關
void baseVUpdate(){
  v.villUpdate();
}
//>>-------------------------------
//進入死亡模式
void baseVGoingToDead(){
  if(baLived == baGoingToDead){
    v.mcrs_setToDead();
    // println("Dead");
  }
}

//---------------------------------------------------------------------------
void base_draw(){
  if(!baIsDead() && s3Borned){
    baseDraw();
    baseVDraw();
  }
}
//>>-------------------------------
void baseDraw(){
  noFill();
  stroke(baColor);
  strokeWeight(3);
  arc(baseLoc.x, baseLoc.y, baRadius, baRadius, arcStart, arcPercent, OPEN);
  imageMode(CENTER);
  image(b, baseLoc.x,  baseLoc.y);
}
//>>-------------------------------
void baseVDraw(){
  v.villDisplay();
}

//---------------------------------------------------------------------------
void baseV_loadData(){
  b = createGraphics(304, 304, P2D);
}
