class Village{
  //位置相關
  float villageX;
  float villageY;
  float villageR;
  float villageA;
  //微生物相關
  boolean bornNew;
  ArrayList<Micro> ms;

  //---------------------------------------------------------------------------
  Village(){
    //初始化位置
    villageX = b.width/2;
    villageY = b.width/2;
    villageR = 300;
    villageA = 255;
    //初始化微生物
    bornNew = true;
    ms = new ArrayList<Micro>();
    ms.add(new Micro());
  }

  //---------------------------------------------------------------------------
  void villUpdate(){
    mcrUpdate();
  }
  //>>-------------------------------
  void mcrUpdate(){
    if(bornNew) newMicro();
    for(int i = ms.size() - 1; i >= 0; i--){
      Micro m = ms.get(i);
      m.microUpdate();
      if(m.mcrIsDead()) ms.remove(i);
    }
  }
  //>>-------------------------------
  //全部殺死
  void mcrs_setToDead(){
    bornNew = false;
    for(Micro m : ms){
      m.mcr_setToDead();
    }
  }
  //>>-------------------------------
  void mcrs_deadByChance(){
    bornNew = true;
  }

  //---------------------------------------------------------------------------
  void villDisplay(){
    b.beginDraw();
    b.background(0, 0);
    villDraw();
    msDraw();
    b.endDraw();
  }
  //>>-------------------------------
  void villDraw(){
    b.noFill();
    b.stroke(mainColor);
    b.strokeWeight(4);
    b.ellipse(villageX, villageY, villageR, villageR);
  }
  //>>-------------------------------
  void msDraw(){
    for(Micro m : ms){
      m.microDisplay();
    }
  }

  //---------------------------------------------------------------------------
  void newMicro(){
    if(ms.size() < 10) ms.add(new Micro());
  }
}
