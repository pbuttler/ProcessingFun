class Surface {
  
  ArrayList<Vec2> points;
  boolean show;
  float fill;
  Body body;
  
  Surface( ArrayList<Vec2> _points, boolean _show, float _fill ){
    show = _show;
    fill = _fill;
    points = _points;    
    
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
    if(show){
      fill(0,fill);
      strokeWeight(2);
      stroke(255);
      beginShape();
      for (Vec2 v: points) {
        vertex(v.x, v.y);
      }
      endShape();
    }
  }
}
