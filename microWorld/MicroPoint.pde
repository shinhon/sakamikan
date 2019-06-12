class MicroPoint{
  //壽命相關
  PVector pointStart;
  float lifeDist;
  float radius;
  //位置相關
  PVector pointVel;
  PVector pointAccel;
  PVector pointLoc;
  //外觀相關
  float pointAlpha;

  MicroPoint(float sx, float sy, float r){
    //初始化壽命
    pointStart = new PVector(sx, sy);
    radius = r;
    //初始化位置
    pointAccel = new PVector(random(-0.05, 0.05), random(-0.05, 0.05));
    pointVel = new PVector(random(-1, 1), random(-1, 1));
    pointLoc = new PVector(sx, sy);
    //初始化外觀
    pointAlpha = 255;
  }

  void microPointUpdate(){
    //更新剩餘壽命
    lifeDist = PVector.dist(pointLoc, pointStart);
    //更新位置
    pointVel.add(pointAccel);
    pointLoc.add(pointVel);
    //更新外觀
    pointAlpha = map(lifeDist, 0, radius, 255, 10);
  }

  void microPointDraw(PGraphics p){
    p.stroke(mainColor, pointAlpha);
    p.strokeWeight(2);
    p.point(pointLoc.x, pointLoc.y);
  }

  boolean isDead(){
    if(lifeDist >= radius){
      return true;
    }
    else{
      return false;
    }
  }
}
