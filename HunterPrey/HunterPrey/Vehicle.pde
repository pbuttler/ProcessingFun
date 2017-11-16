abstract class Vehicle {
  // Base class for all moving entities
  // extend for prey&predator
  ArrayList<PVector> history = new ArrayList<PVector>();
  Steering steering;

  PVector position;
  PVector velocity;
  PVector acceleration;
  
  PVector forward;
  PVector right;
  PVector randVec;
  
  float mass = 1.0; 
  float radius;  
  float maxForce; 
  float maxSpeed; 

  Vehicle(float x_, float y_, float r_, float maxSpeed_, float maxForce_) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(random(-2,2), random(-2,2));
    position = new PVector(x_, y_);
    forward = new PVector(1, 0);
    right = new PVector(0, 1);
    radius = r_;
    maxSpeed = maxSpeed_;
    maxForce = maxForce_;
    steering = new Steering(this);
  }
  abstract void calcSteeringForces();
  abstract void display();
  
  void update() {
    calcSteeringForces();
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    
    forward = velocity.get();
    forward.normalize();
    right = new PVector(-forward.y, forward.x);
    acceleration.mult(0);
  }


  void applyForce(PVector force) {
    acceleration.add(PVector.div(force, mass));
  }
  
  boolean offStage(float dist) {
    boolean off = false;
    if (position.x < dist) off = true;
    else if (position.x > width - dist) off = true;
    else if (position.y < dist) off = true;
    else if (position.y > height - dist) off = true;
    return off;
  }
  
}  
