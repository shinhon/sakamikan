//說明文位置
int s4TutX;
int s4TutY;
//漫畫相關
// PImage[] ms;
PVector[] msLoc;
int msNUM = 4;
float msStart = 95;
int mWidth = 250;
boolean s4Loading = false;
//重置倒數
int s4_resetCount;
int s4_resetTime = 1800;
//倒數進度條
float s4rStartX;
float s4rEndCount;
float s4rEndX;
int s4rY;
//倒數計時系統提示文字
float s4rTutX;
float s4rTutY;

//---------------------------------------------------------------------------
void s4ui_setup(){
  //初始化說明文位置
  s4TutX = 50;
  s4TutY = 80;
  s4ui_loadData();
  //初始化計時器
  s4_resetCount = 0;
  //初始化倒數進度條
  s4rStartX = msStart;
  s4rEndCount = msStart;
  s4rEndX = width - msStart;
  s4rY = 600;
  //初始化倒數計時系統提示文字
  s4rTutX = width - msStart;
  s4rTutY = 590;
}
//>>-------------------------------
void s4ui_loadData(){
  s4Loading = true;
  // ms = new PImage[msNUM];
  msLoc = new PVector[msNUM];
  for(int i=0; i<msLoc.length; i++){
    int fileName = i + 1;
    // ms[i] = requestImage("s" + fileName + ".png");
    msLoc[i] = new PVector(msStart + mWidth*i + 30*i, (height/2)-(mWidth/2));
  }
  s4Loading = false;
}

//---------------------------------------------------------------------------
void s4ui_update(){
  s4ui_timeUpdate();//更新計時
  s4resetUpdate();
}
//>>-------------------------------
void s4ui_timeUpdate(){
  if(s4_resetCount <= s4_resetTime){
    s4_resetCount++;
  }
}
//>>-------------------------------
void s4resetUpdate(){
  float srm = map(s4_resetCount, 0, s4_resetTime, s4rStartX, s4rEndX);
  s4rEndCount = srm;
}
//>>-------------------------------
boolean s4ui_goNext(){
  if(s4_resetCount == s4_resetTime){
    return true;
  }
  else{
    return false;
  }
}

//---------------------------------------------------------------------------
void s4ui_draw(){
  background(sysBG);
  s4tutDraw();//顯示說明文字
  s4mangaDraw();//顯示漫畫
  s4resetTutDraw(); //顯示倒數計時系統提示文字
  s4resetDraw();//顯示進度條
}
//>>-------------------------------
void s4ui_loading(){
  fill(sysBG);
  textFont(tutFont);
  textSize(tfSize);
  textAlign(LEFT,TOP);
  text("記錄輸出中...", width/2, height/2);
}
//>>-------------------------------
void s4tutDraw(){
  fill(mainColor);
  textFont(tutFont);
  textSize(tfSize);
  textAlign(LEFT,TOP);
  text("在觀察的過程中留下了一些照片，\n照片裡的微生物們正在做些什麼事情呢？", s4TutX, s4TutY);
}
//>>-------------------------------
void s4mangaDraw(){
  imageMode(CORNER);
  rectMode(CORNER);
  for(int i=0; i<captures.length; i++){
    image(captures[i], msLoc[i].x, msLoc[i].y, mWidth, mWidth);
    noFill();
    stroke(mainColor);
    strokeWeight(3);
    rect(msLoc[i].x, msLoc[i].y, mWidth, mWidth);
  }
}
//>>-------------------------------
void s4resetTutDraw(){
  fill(mainColor);
  textFont(tutFont);
  textSize(20);
  textAlign(RIGHT,BOTTOM);
  text("...距離觀察結束時間", s4rTutX, s4rTutY);
}
//>>-------------------------------
void s4resetDraw(){
  stroke(mainColor);
  strokeWeight(5);
  strokeCap(ROUND);
  line(s4rStartX, s4rY, s4rEndCount, s4rY);
}
