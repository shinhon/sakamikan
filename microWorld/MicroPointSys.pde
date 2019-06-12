class MicroPointSys{
  //產生新微生物
  PVector startP;
  float radius;
  //出生點被凝視時的動態
  PVector sPmoveS;
  PVector sPmove;
  float xoff;
  float yoff;
  color mpsC;
  //微生物管理
  int mpAmount;
  ArrayList<MicroPoint> mps;

  //---------------------------------------------------------------------------
  MicroPointSys(float x, float y, int amt, int r){
    //初始化微生物出生點
    startP = new PVector(x, y);
    radius = r;
    //初始化被凝視動態
    sPmoveS = new PVector(50, 50);
    sPmove = new PVector(0, 0);
    xoff = 0.0;
    yoff = 0.0;
    mpsC = mainColor;
    //初始化微生物管理陣列
    mpAmount = amt;
    mps = new ArrayList<MicroPoint>();
    //新增微生物
    for(int i=0; i<mpAmount; i++){
      mpsBorn();
    }
  }

  //---------------------------------------------------------------------------
  void mpsUpdate(){
    mpUpdate();
    mpspUpdate();
  }
  //>>-------------------------------
  //粒子特效更新
  void mpUpdate(){
    for (int i = mps.size() - 1; i >= 0; i--) {
      MicroPoint mp = mps.get(i);
      mp.microPointUpdate();
      if(mp.isDead()){
        mps.remove(i);
      }
    }
    if(mps.size() < mpAmount) mpsBorn();
  }
  //>>-------------------------------
  void mpspUpdate(){
    float gX = map(gaze.x, 0, width, 0, 960);
    float gY = map(gaze.y, 0, height, 0, 540);
    PVector gM = new PVector(gX, gY);
    float d = PVector.dist(gM, startP);
    if(d < radius){
      xoff = xoff+0.05;
      float noiseX = noise(xoff)*sPmoveS.x;
      yoff = yoff+0.05;
      float noiseY = noise(yoff)*sPmoveS.y;
      sPmove.set((startP.x + noiseX)-(radius/2), (startP.y + noiseY)-(radius/2));
      //出生點顏色更新
      mpsC = subColor;
    }
    else{
      sPmove.set(startP.x, startP.y);
      mpsC = mainColor;
    }
  }

  //---------------------------------------------------------------------------
  void mpsDraw(PGraphics p){
    for(MicroPoint mp : mps){
      mp.microPointDraw(p);
    }
    p.pushMatrix();
    p.stroke(mpsC);
    p.strokeWeight(6);
    p.point(sPmove.x, sPmove.y);
    p.popMatrix();
  }

  //---------------------------------------------------------------------------
  void mpsBorn(){
    mps.add(new MicroPoint(startP.x, startP.y, radius));
  }
}
