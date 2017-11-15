class Bumper {
  
  ArrayList<Vec2> points;
  boolean show;
  float fill;
  Body body;
  float outline;
  int rad;
  
  Bumper( ArrayList<Vec2> _points, boolean _show, int _rad ){
    show = _show;
    points = _points; 
    outline = 0;
    rad = _rad;   
    
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
  
  void update(){
    //
  }
  
  void display(){
    if(outline > 0){
      outline -= 3;
    }
    if(show){
      fill(100,100,50);
      stroke(255,outline);
      beginShape();
      for (Vec2 v: points) {
        vertex(v.x, v.y);
      }
      endShape();
    }
  }
  
  void setOutline( float o ){
    outline = o;
  }
  
  int getScore(){
    return 100-rad;
  }
}
