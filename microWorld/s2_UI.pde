//介面圖片
PImage s2ui;
//閱讀倒數
int s2PassCount;
int s2PassTime;
//進度條
float s2PLineSX; //start
float s2PLineLX; //loading
float s2PLineEX; //end
int s2PLineY;

//---------------------------------------------------------------------------
void s2ui_setup(){
  //初始化時間計算
  s2PassCount = 0;
  s2PassTime = 1200;
  //初始化線條
  s2ui_lineSetup();
}
//>>-------------------------------
void s2ui_lineSetup(){
  s2PLineSX = 60;
  s2PLineLX = s2PLineSX;
  s2PLineEX = width-60;
  s2PLineY = height-30;
}
//>>-------------------------------
void s2ui_loadData(){
  s2ui = loadImage("s2ui.jpg");
}

//---------------------------------------------------------------------------
void s2ui_update(){
  if(s2PassCount < s2PassTime) s2PassCount++;
  s2ui_lineUpdate();
}
//>>-------------------------------
void s2ui_lineUpdate(){
  int m = floor(map(s2PassCount, 0, s2PassTime, s2PLineSX, s2PLineEX));
  s2PLineLX = constrain(m, s2PLineSX, s2PLineEX);
}

//---------------------------------------------------------------------------
void s2ui_draw(){
  background(255);
  s2ui_uiDraw();
  s2ui_lineDraw();
  // s2ui_textDraw(); //繪製教學文
}
//>>-------------------------------
void s2ui_uiDraw(){
  pushMatrix();
  imageMode(CORNER);
  image(s2ui, 0, 0);
  popMatrix();
}
//>>-------------------------------
void s2ui_lineDraw(){
  pushMatrix();
  stroke(mainColor);
  strokeWeight(6);
  line(s2PLineSX, s2PLineY, s2PLineLX, s2PLineY);
  popMatrix();
}
