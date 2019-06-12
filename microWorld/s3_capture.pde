//>>------------------------------- s3儲存相關
int s3Cap_saveCount;
int s3Cap_saveNUM = 4;
int s3Cap_saveTime;
PVector[] s3Cap_locs;
//>>------------------------------- s4顯示相關
PImage[] captures;
int radiusL;
int radiusR;

//---------------------------------------------------------------------------
void s3Capture_setup(){
  s3Cap_saveCount = 0;
  s3Cap_saveNUM = 4;
  s3Cap_saveTime = floor(baLifespan/(s3Cap_saveNUM+1));
}
//>>-------------------------------
void s3Capture_loadData(){
  captures = new PImage[s3Cap_saveNUM];
  for(int i=0; i<s3Cap_saveNUM; i++){
    captures[i] = createImage(250,250,RGB);
  }
  println("loaded" + "," + captures.length);
}

//---------------------------------------------------------------------------
void s3Capture_update(){
  int ct = s3Cap_saveTime*(s3Cap_saveCount+1);
  if(baLived == ct){
    // s3Capture_save();
  }
}

//---------------------------------------------------------------------------
void s3Capture_save(){
  if (s3Cap_saveCount < s3Cap_saveNUM){
    s3Capture_s();
    s3Cap_saveCount++;
  }
}
//>>-------------------------------
void s3Capture_s(){
  radiusL = floor(random(150, 300));
  radiusR = floor(random(150, 300));
  PImage c = get(floor(baseLoc.x-radiusL), floor(baseLoc.y-radiusL), radiusL+radiusR, radiusL+radiusR);
  captures[s3Cap_saveCount] = c;
}
