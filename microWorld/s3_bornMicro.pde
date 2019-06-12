//出生點相關
PVector s3bpLoc;
float s3bpRadius;
float s3bpREasing;
//凝視動態
int s3bpGazeCount;
int s3bpGazeTime;
//出生確認
boolean s3Borned;

//---------------------------------------------------------------------------
void s3bm_setup(){
  //初始化出生點
  s3bpLoc = new PVector(gaze.x, gaze.y);
  s3bpRadius = 300;
  s3bpREasing = 0.0;
  //初始化凝視時間
  s3bpGazeCount = 0;
  s3bpGazeTime = 390;
  //出生確認
  s3Borned = false;
}

//---------------------------------------------------------------------------
void s3bm_update(){
  s3bpLoc = gaze.copy();//更新視線位置
  if(!s3Borned){
    s3gazeUpdate();//更新時間
    s3easeUpdate();//更新大小
  }
  s3bornUpdate();
}
//>>-------------------------------
void s3gazeUpdate(){
  //更新時間
  if(s3bpGazeCount <= s3bpGazeTime){
    s3bpGazeCount++;
  }
}
//>>-------------------------------
void s3easeUpdate(){
  float gm;
  if(s3bpGazeCount >= 360){
    gm = map(s3bpGazeCount, 360, s3bpGazeTime, 0.0, 1.0);
  }
  else{
    gm = 0.5;
  }
  float gmValue = easeInQuint(constrain(gm, 0.1, 1.0));
  s3bpREasing = s3bpRadius*gmValue;
}
//>>-------------------------------
void s3bornUpdate(){
  if(s3bpGazeCount == s3bpGazeTime && !s3Borned){
    s3Borned = true;
    base_setup();
  }
}

//---------------------------------------------------------------------------
void s3bm_draw(){
  if(!s3Borned){
    s3_bornPointDraw();
  }
}
//>>-------------------------------
void s3_bornPointDraw(){
  noFill();
  stroke(mainColor);
  strokeWeight(5);
  ellipse(s3bpLoc.x, s3bpLoc.y, s3bpREasing, s3bpREasing);
}
