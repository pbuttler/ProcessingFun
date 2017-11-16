class Hunter extends Vehicle {
  
  PVector target;
  
  Hunter(float x_, float y_, float r_, float maxSpeed_, float maxForce){
    super(x_, y_, r_, maxSpeed_, maxForce);
    target = new PVector(-1000,-1000);
  }
  
  void display(){
    fill( 131,223,235 );
    pushMatrix();
    translate(position.x, position.y);
    ellipse(0, 0, 2*radius, 2*radius);
    popMatrix();
  }
  
  void calcSteeringForces(){
    target = getNearPrey();
    PVector force = new PVector(0, 0);
    if (target != null) {
      force.add(PVector.mult(steering.seek(target), 150));
    }
    
    if (offStage(50)) {
      randVec = new PVector(random(70,width-70),random(70,height-70));
      force.add(PVector.mult(steering.seek(randVec),100));
    }
  
    for (int i = 0; i < 7; i++) {
      force.add(PVector.mult(steering.avoidObstacle(surfaces[i], 80), 200));
    }
//    for (int i = 0; i < hunters.size(); i++) {
//      if (hunters.get(i) == this ){
//        continue;
//      }
//      force.add(PVector.mult(steering.avoidObstacle(hunters.get(i), 80), 200));
//    }

    //could add other steering forces here
    force.limit(maxForce);
    applyForce(force);
  }
  
  PVector getNearPrey(){
//    if( dist(target.x, target.y, position.x, position.y) < 100 ){
//      return target;
//    }
    Prey champion = null;
    float high = 10000;
    float temp;
    for( Prey p : prey ){
      temp = dist(position.x, position.y, p.position.x, p.position.y);
      if ( temp < 24 ){
        p.eaten();
      }
      if ( temp < high ){
        high = temp;
        champion = p;
      }
    }
    try{
      return champion.position;
    }
    catch(NullPointerException e){
      return randVec = new PVector(random(70,width-70),random(70,height-70));
    }
  }
  
}
