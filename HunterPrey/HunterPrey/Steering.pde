class Steering {
  Vehicle vehicle;

  Steering (Vehicle _vehicle) {
    vehicle = _vehicle;
  }

  // steering force towards a target
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, vehicle.position);  
    desired.normalize();
    desired.mult(vehicle.maxSpeed);
    PVector steer = PVector.sub(desired, vehicle.velocity);
    return steer;
  }
  
  PVector avoidObstacle (Surface obst, float safeDistance) {
    PVector steer = new PVector(0, 0);

    //vecToCenter is a vector from the character to the center of the obstacle
    PVector vecToCenter = PVector.sub(obst.position, vehicle.position);
    float dist = vecToCenter.mag();

    //return a zero vector if obstacle is too far to concern us
    if (dist > safeDistance + obst.radius + vehicle.radius)
      return steer;

    //return a zero vector if obstacle is behind us
    if (vecToCenter.dot(vehicle.forward) < 0)
      return steer;

    //return a zero vector if we can pass safely
    float rightDotVTC = vecToCenter.dot(vehicle.right);
    if (abs(rightDotVTC) > obst.radius + vehicle.radius)
      return steer;
    
    //If we get this far we are on a collision course and must steer
    PVector desiredVelocity;
    
    //The obstacle is on the right, so we steer to the left
    if (rightDotVTC > 0)
      desiredVelocity = PVector.mult(vehicle.right, -vehicle.maxSpeed * safeDistance / dist);
    else
      //The obstacle is on the left so we steer to the right
      desiredVelocity = PVector.mult(vehicle.right, vehicle.maxSpeed * safeDistance / dist);

    //compute the force to change current velocity to desired velocity
    steer = PVector.sub(desiredVelocity, vehicle.velocity);
    return steer;
  }
}
