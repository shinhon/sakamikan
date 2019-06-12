//>>------------------------------- 背板外觀相關
int boardW;
float boardX;
float boardY;
//>>------------------------------- 按鈕相關
//外觀
PVector stbLoc;
int stbRadius;
String hello;
//hover時間
float stbA; //外框透明度
float stbTcA; //文字透明度
int stbPassCount;
int stbPassTime;

//---------------------------------------------------------------------------
void startBtn_setup(){
  //初始化背板
  boardX = width/2;
  boardY = height/2;
  boardW = 400;
  //>>------------------------------- 初始化按鈕
  //外觀
  stbLoc = new PVector(boardX, boardY);
  stbRadius = 300;
  hello = "嘿！看這邊！";
  //時間
  stbA = 10;
  stbTcA = 255;
  stbPassCount = 0;
  stbPassTime = 180;
  //>>------------------------------- 初始化hover後特效
  s1_stbPartMSetup();
}

//---------------------------------------------------------------------------
void startBtn_update(){
  sb_stbUpdate();
  s1_stbPartMUpdate();
}
//>>-------------------------------
void sb_stbUpdate(){
  //>>------------------------------- 更新hover狀況
  if(hover()){
    if (stbPassCount <= stbPassTime) stbPassCount++;
  }
  else{
    if (stbPassCount > 0) stbPassCount--;
    // stbA = 10;
    // stbTcA = 255;
  }
  //文字轉換
  if (stbPassCount < 60){
    hello = "嘿！看這邊！";
  } else {
    hello = "很好！就是這樣！";
  }
  //透明度計算
  float ca = map(stbPassCount, 0, stbPassTime, 10, 255);
  float ta = map(stbPassCount, 0, stbPassTime, 255, 0);
  stbA = constrain(ca, 10, 255);
  stbTcA = constrain(ta, 0, 255);
}
//>>-------------------------------
boolean hover(){
  float d = PVector.dist(gaze,stbLoc);
  if(d <= stbRadius/2){
    return true;
  }
  else{
    return false;
  }
}
//>>-------------------------------
boolean sb_nextScene(){
  if(stbPassCount == stbPassTime){
    return true;
  }
  else{
    return false;
  }
}

//---------------------------------------------------------------------------
void startBtn_draw(){
  sb_boardDraw(); //背板繪製
  sb_stbDraw(); //圓圈繪製
  sb_tutTextDraw(); //教學文章繪製
  s1_stbPartMDraw(); //繪製粒子特效
}
//>>-------------------------------
void sb_boardDraw(){
  pushMatrix();
  noStroke();
  fill(sysBG);
  rectMode(CENTER);
  rect(boardX, boardY, boardW, boardW);
  popMatrix();
}
//>>-------------------------------
void sb_tutTextDraw(){
  fill(mainColor, stbTcA);
  textFont(tutFont);
  textSize(tfSize);
  textAlign(CENTER,CENTER);
  text(hello, boardX, boardY);
}
//>>-------------------------------
void sb_stbDraw(){
  noFill();
  stroke(mainColor, stbA);
  strokeWeight(5);
  ellipse(stbLoc.x, stbLoc.y, stbRadius, stbRadius);
}
