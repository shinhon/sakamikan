//橘子皮背景
//>>------------------------------- background
PGraphics bg;
int bgW;
int bgH;

//>>------------------------------- micro
ArrayList<MicroPointSys> mpss;
int radius = 50;

//---------------------------------------------------------------------------
void mpss_setup(){
  bgW = 960;
  bgH = 540;
  bg = createGraphics(bgW, bgH, P2D);
  mpss = new ArrayList<MicroPointSys>();
  int radius2 = radius*2;
  int frameX = floor((bgW-(radius2*floor(bgW/radius2)))/2);
  int frameY = floor((bgH-(radius2*floor(bgH/radius2)))/2);
  for(int y=radius+frameY; y<(bgH-radius); y+=radius2){
    for(int x=radius+frameX; x<(bgW-radius); x+=radius2){
      mpss.add(new MicroPointSys(x, y, 20, radius));
    }
  }
}
//>>-------------------------------
void mpss_update(){
  for(MicroPointSys mps : mpss){
    mps.mpsUpdate();
  }
}
//>>-------------------------------
void mpss_draw(){
  bg.beginDraw();
  bg.background(sysBG);
  for(MicroPointSys mps : mpss){
    mps.mpsDraw(bg);
  }
  bg.endDraw();
  imageMode(CORNER);
  image(bg, 0, 0, width, height);
}
