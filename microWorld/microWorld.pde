//>>------------------------------- update
final float TARGET_FPS = 60.0f; // 目標フレームレート
final float FRAME_TIME = 1000.0f / TARGET_FPS; // 1フレームの許容処理時間
int lastUpdateTime = 0; // 前回の更新時刻
float elapsedTime = 0.0f;   // 前フレームからの経過時間
//>>------------------------------- update
// import  java.lang.System;
String os = "Mac OS X";
String osDetect;
int sNUM;
//>>------------------------------- 顏色
color sysBG = color(255);
color mainColor = color(0, 46, 109);
color subColor = color(247, 158, 76);
//>>------------------------------- gazetrack
import gazetrack.*;
GazeTrack gazeTrack;
//>>------------------------------- 字型
PFont microFont;
PFont tutFont;
int tfSize = 30;
String[] micros = {"☻", "☺", "◬", "◭", "◮", "⊗", "⊝", "⊛", "◘", "◩", "◪"};
String[] chance = {"☠", "☤"};
//>>------------------------------- 場景控制
int scene;
boolean mainFileLoading;
//>>------------------------------- 視線偵測相關
PVector gaze;

//---------------------------------------------------------------------------
void setup(){
  osDetect = System.getProperty("os.name"); //偵測作業系統
  // println(osDetect + "," + osDetect.equals(os));
  fullScreen(P2D,2);
  // pixelDensity(2);
  noCursor();
  frameRate(60);
  background(sysBG);

  if(osDetect.equals(os) == true){
    gaze = new PVector(mouseX, mouseY);//初始化視線位置
  }
  else{
    gazeTrack = new GazeTrack(this);
    gaze = new PVector(0, 0);//初始化視線位置
  }
  thread("loadData");

  scene = 1;//初始化場景
  s1_setup();
  // s4_setup();

  // base_setup(); //初始化培養基
}
//>>-------------------------------
void loadData(){
  mainFileLoading = true;
  //讀取字型
  if(osDetect.equals(os) == true){
    tutFont = createFont("NotoSansCJKjp-Medium", 40);
  } else {
    tutFont = createFont("Noto Sans CJK TC Medium", 40);
  }
  microFont = createFont("SetoFont",60);
  //s2
  s2ui_loadData();
  //s3
  baseV_loadData();
  s3Capture_loadData();//截圖用
  mainFileLoading = false;
}

//---------------------------------------------------------------------------
void update(){
  if(osDetect.equals(os) == true){
    gaze.set(mouseX, mouseY); //載入視線位置
  } else {
    gazeUpdate();
  }

  //>>------------------------------- 場景更新
  switch(scene){
    //互動開始
    case 1:
      s1_update();
      break;
    //視線校正
    case 2:
      s2_update();
      break;
    //觀察
    case 3:
      s3_update();
      break;
    //觀看四格漫畫
    case 4:
      s4_update();
      break;
    default:
      break;
  }
}
//>>-------------------------------
void gazeUpdate(){
  if (gazeTrack.gazePresent())
  {
    // ellipse(gazeTrack.getGazeX(), gazeTrack.getGazeY(), 80, 80);
    gaze.set(gazeTrack.getGazeX(), gazeTrack.getGazeY());
    // Print the tracker's timestamp for the gaze cursor above
    println("Latest gaze data at: " + gazeTrack.getTimestamp());
  }
  else{
    gaze.set(-10, -10);
  }
}

//---------------------------------------------------------------------------
void draw(){
  if(mainFileLoading){
    background(mainColor);
    textAlign(CENTER,CENTER);
    text("Loading", width/2, height/2);
  }
  else{
    updateDraw();//更新數據

    //>>------------------------------- 場景描圖
    background(sysBG);
    switch(scene){
      //互動開始
      case 1:
        s1_draw();
        break;
      //視線校正
      case 2:
        s2_draw();
        break;
      //觀察
      case 3:
        s3_draw();
        break;
      //觀看四格漫畫
      case 4:
        s4_draw();
        break;
      default:
        break;
    }

    // debug();//偵錯用
  }
}
//>>-------------------------------
void updateDraw(){
  int curTime = millis();
  elapsedTime += curTime - lastUpdateTime;
  lastUpdateTime = curTime;

  for( ; elapsedTime >= FRAME_TIME; elapsedTime -= FRAME_TIME) {
    update();
  }
}

//---------------------------------------------------------------------------
void debug(){
  pushMatrix();
  fill(0);
  textSize(10);
  textAlign(LEFT);
  text(floor(frameRate) + "," + baCrashed, 10, height-10);
  popMatrix();
}

//---------------------------------------------------------------------------
void mouseReleased(){
  // if(scene == 3){
  //   base_setup();
  //   baseV_setup();
  // }
  // screenShot();
}
//>>-------------------------------
void keyPressed(){
  if(key == 'r' || key == 'R'){
    setup();
  }
}
