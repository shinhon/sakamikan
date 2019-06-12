//---------------------------------------------------------------------------
void s1_setup(){
  mpss_setup(); //初始化橘子皮
  startBtn_setup();//初始化背板
}
//>>-------------------------------
void s1_update(){
  mpss_update(); //更新橘子皮
  startBtn_update(); //更新按鈕
  s1_goNext();
}
//>>-------------------------------
void s1_draw(){
  mpss_draw();
  startBtn_draw();
}
//>>-------------------------------
void s1_goNext(){
  if(sb_nextScene()){
    scene++;
    s2_setup();
    println(scene);
  }
}

//---------------------------------------------------------------------------
void s2_setup(){
  s2ui_setup();
}
//>>-------------------------------
void s2_update(){
  s2ui_update();
  s2_goNext();
}
//>>-------------------------------
void s2_draw(){
  s2ui_draw();
}
//>>-------------------------------
void s2_goNext(){
  if(s2PassCount == s2PassTime){
    scene++;
    s3_setup();
    println(scene);
  }
}

//---------------------------------------------------------------------------
void s3_setup(){
  s3bm_setup();
  chanceSys_setup(); //初始化chance
  s3Capture_setup();
}
//>>-------------------------------
void s3_update(){
  mpss_update();
  s3bm_update();//更新出生點
  if(!baIsDead()){
    base_update(); //更新培養基
    s3Capture_update();
  }
  chanceSys_update(); //更新chance
  s3_goNext();
}
//>>-------------------------------
void s3_draw(){
  mpss_draw();
  s3bm_draw();//顯示出生動畫
  chanceSys_draw(); //顯示chance
  if(!baIsDead()){
    base_draw();
  }
}
//>>-------------------------------
void s3_goNext(){
  if(baGoNext){
    scene++;
    baGoNext = false;
    s4_setup();
    println(scene);
  }
}

//---------------------------------------------------------------------------
void s4_setup(){
  s4ui_setup();
}
//>>-------------------------------
void s4_update(){
  s4ui_update();
  s4_goNext();
}
//>>-------------------------------
void s4_draw(){
  if(s4Loading){
    background(mainColor);
  }
  else{
    s4ui_draw();
  }
}
//>>-------------------------------
void s4_goNext(){
  if(s4ui_goNext()){
    scene = 1;
    setup();
    println(scene);
  }
}
