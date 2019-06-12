//HOVER粒子特效相關
ArrayList<StbParticle> partM;

//---------------------------------------------------------------------------
void s1_stbPartMSetup(){
  partM = new ArrayList<StbParticle>();
}

//---------------------------------------------------------------------------
void s1_stbPartMUpdate(){
  if(hover()){
    for(int i = partM.size() - 1; i >= 0; i--){
      StbParticle part = partM.get(i);
      part.stbPartUpdate();
      if(part.stbPisDead()){
        partM.remove(i);
      }
    }
    if(partM.size() < 100){
      partM.add(new StbParticle());
    }
  }
  else{
    for(int i = partM.size() - 1; i >= 0; i--){
      StbParticle part = partM.get(i);
      partM.remove(i);
    }
  }
}

//---------------------------------------------------------------------------
void s1_stbPartMDraw(){
  if(hover()){
    for(StbParticle part : partM){
      part.stbPartDraw();
    }
  }
}
