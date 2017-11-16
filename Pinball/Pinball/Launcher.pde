class Launcher {

  Body body;
  float w;
  float h;

  Launcher(float x_, float y_, boolean stat) {
    float x = x_;
    float y = y_;
    w = 19;
    h = 19;
    makeBody(new Vec2(x,y),w,h,stat);
  }

  void killBody() {
    box2d.destroyBody(body);
  }

  boolean contains(float x, float y) {
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    Fixture f = body.getFixtureList();
    boolean inside = f.testPoint(worldPoint);
    return inside;
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();

    rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(a);
    fill(127);
    noStroke();
    strokeWeight(2);
    rect(0,0,w,h);
    popMatrix();
  }

  void makeBody(Vec2 center, float w_, float h_, boolean stat) {
    BodyDef bd = new BodyDef();
    if(stat){
      bd.type = BodyType.STATIC;
    }
    else{
      bd.type = BodyType.DYNAMIC;
    }
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);

    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.2;

    body.createFixture(fd);
    body.setUserData(this);
  }
}