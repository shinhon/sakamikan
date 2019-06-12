ArrayList<ChanceMicro> cms;

//---------------------------------------------------------------------------
void chanceSys_setup(){
  cms = new ArrayList<ChanceMicro>();
}

//---------------------------------------------------------------------------
void chanceSys_update(){
  chanceSys_addCm();
  for(int i = cms.size() - 1; i >= 0; i--){
    ChanceMicro cm = cms.get(i);
    cm.chanceMicro_update();
    if(cm.cmIsDead()){
      cms.remove(i);
    }
  }
}
//>>-------------------------------
void chanceSys_addCm(){
  if(cms.size() < 3 && frameCount%600==0){
    cms.add(new ChanceMicro());
  }
}

//---------------------------------------------------------------------------
void chanceSys_draw(){
  for(ChanceMicro cm : cms){
    cm.chanceMicro_Draw();
  }
}
