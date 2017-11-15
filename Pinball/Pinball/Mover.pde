class Mover {
  
  ArrayList<Vec2> points;
  boolean show;
  float fill;
  Body body;
  Vec2 direction;
  
  Mover( ArrayList<Vec2> _points, boolean _show, float _fill, Vec2 _direction ){
    show = _show;
    fill = _fill;
    points = _points;
    direction = _direction;    
    
    Vec2[] vertices = new Vec2[points.size()];    
    for (int i = 0; i < vertices.length; i++) {
      vertices[i] = box2d.coordPixelsToWorld(points.get(i));
    }
    
    ChainShape chain = new ChainShape();
    chain.createChain(vertices, vertices.length);

    BodyDef bd = new BodyDef();
    body = box2d.world.createBody(bd);

    body.createFixture(chain, 1);
    body.setUserData(this);
  }
  
  void launch(){
    ball.applyLinearImpulse(direction);
    fill = 255;
    //println("CHECK");
  }
  
  void display(){
    if( fill > 0 ){
      fill -= 2;
    }
    if(show){
      fill(0,fill);
      strokeWeight(2);
      stroke(80,160,240);
      beginShape();
      for (Vec2 v: points) {
        vertex(v.x, v.y);
      }
      endShape();
    }
  }
}
