class Prey extends Vehicle {
  
  PVector center = new PVector(width/2, height/2);
  
  Prey(float x_, float y_, float r_, float maxSpeed_, float maxForce){
    super(x_, y_, r_, maxSpeed_, maxForce);
  }
  
  void display(){
    fill( 214,133,171 );
    pushMatrix();
    translate(position.x, position.y);
    ellipse(0, 0, 2*radius, 2*radius);
    popMatrix();
  }
  
  void calcSteeringForces(){
    PVector force = new PVector(0, 0);
    PVector run = hunterClose();
    if (run != null) {
      force.add(PVector.mult(flee(run), 200));
    }
    
    if (offStage(50)) {
      randVec = new PVector(random(70,width-70),random(70,height-70));
      force.add(PVector.mult(steering.seek(randVec), 100));
    }
  
    for (int i = 0; i < 7; i++) {
      force.add(PVector.mult(steering.avoidObstacle(surfaces[i], 80), 100));
    }

    //could add other steering forces here
    force.limit(maxForce);
    applyForce(force);
  }
  
  void eaten(){
    eaten.add(this);
  }
  
  PVector flee(PVector target) {
    PVector desired = PVector.sub(target, position);  
    desired.normalize();
    desired.mult(maxSpeed);
    PVector steer = PVector.sub(desired, velocity);
    return new PVector(-steer.x, -steer.y);
  }
  
  PVector hunterClose(){
    for( Hunter h : hunters ){
      if( dist( position.x, position.y, h.position.x, h.position.y ) < 100){
        return h.position;
      }
    }
    return null;
  }
      
  
  
}

