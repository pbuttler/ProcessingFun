class Flipper{
  
  Body body;
  boolean left;
  
  Flipper( float _x, float _y, boolean _left ) {
    left = _left;
    makeABody( _x, _y, left);
  }
  
   void display(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float angle = body.getAngle();
    Fixture f = body.getFixtureList();
    PolygonShape ps = (PolygonShape) f.getShape();
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-angle);
    fill(240,210,20);
    noStroke();
    //
    // DRAW THE FLIPPER HERE
    ellipse(0,0,10,10);
    
    beginShape();
    for(int i=0; i < ps.getVertexCount(); i++) {
      Vec2 v = box2d.vectorWorldToPixels(ps.getVertex(i));
      vertex(v.x,v.y);
    }
    endShape(CLOSE);
    //
    popMatrix();
  }
  
  void makeABody( float _x, float _y, boolean left){
    BodyDef bd = new BodyDef();
    bd.position = box2d.coordPixelsToWorld( _x, _y );
    bd.type = BodyType.DYNAMIC;
    body = box2d.world.createBody(bd);
    
    // Circle shape (flipper base)
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(5);
    
    // Trapezoid shape (flipper arm)
    Vec2[] vertices = new Vec2[4];  // An array of 4 vectors
    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(0, -5));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(40, -3));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(40, 3));
    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(0, 5));
    PolygonShape ps = new PolygonShape();
    ps.set(vertices, vertices.length);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 1;
    fd.friction = 0.01;
    fd.restitution = .7;
    
    body.createFixture(fd);
    fd.shape = ps;
    body.createFixture(fd);
    body.setUserData(this);
  }
  
  void destroy(){
    box2d.destroyBody(body);
  }
}