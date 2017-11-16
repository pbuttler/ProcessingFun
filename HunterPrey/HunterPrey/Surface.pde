class Surface {
  // class for representing solid objects/obstacles
  float radius;
  PVector position;

  Surface(float x_, float y_, float r_) {
    position = new PVector(x_, y_);
    radius = r_;
  }

  void display() {
    fill( 97,133,129 );
    pushMatrix();
    translate(position.x, position.y);
    ellipse(0, 0, 2*radius, 2*radius);
    popMatrix();
  }
  
}
