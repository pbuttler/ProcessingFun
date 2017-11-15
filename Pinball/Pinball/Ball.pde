class Ball {
  
  Body body;
  float radius;
  
  Ball( float _x, float _y, float _r ) {
    radius = _r;
    makeABody( _x, _y, _r );
  }
  
  //
  //
  //

  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    
    pushMatrix();
    translate(pos.x, pos.y);
    fill(242,84,42);
    noStroke();
    ellipse(0,0,radius*2,radius*2);    
    popMatrix();
    
    ghosts.add( new Ghost(pos.x,pos.y) );
  }
  
  void makeABody( float _x, float _y, float _r){
    BodyDef bd = new BodyDef();
    bd.position = box2d.coordPixelsToWorld( _x, _y );
    bd.type = BodyType.DYNAMIC;
    bd.bullet = true;
    body = box2d.world.createBody(bd);
    
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(_r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 1.2;
    fd.friction = 0.005;
    fd.restitution = .7;
    
    body.createFixture(fd);
    body.setUserData(this);
  }
  
  void applyLinearImpulse( Vec2 force ){
    Vec2 pos = body.getWorldCenter();
    body.applyLinearImpulse(force, pos);
  }
  
  void destroy(){
    box2d.destroyBody(body);
  }
}
