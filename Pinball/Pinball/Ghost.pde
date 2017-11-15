class Ghost{
  
  float x,y;
  float trans = 128;
  float r,g,b;
   
  Ghost( float _x, float _y ){
    x = _x;
    y = _y;
    r = random(255);
    g = random(255);
    b = random(255);
  }
  
  void display(){
    noStroke();
    fill(r,g,b,trans);
    ellipse(x,y,16-((255-trans)/32),16-((255-trans)/32));
    trans -= 3;
  }
}
  
