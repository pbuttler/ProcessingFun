// Pinball Game
//
// Author: Peter Buttler

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
ArrayList<Surface> surfaces;
ArrayList<Bumper> bumpers;
ArrayList<Mover> movers;
ArrayList<Ghost> ghosts;
Ball ball;
Spring spring;
Launcher launcher;
Flipper lFlip;
Flipper rFlip;

float pinballWizardPower;

RevoluteJointDef rjdLeft;
RevoluteJoint leftJoint;
RevoluteJointDef rjdRight;
RevoluteJoint rightJoint;

int score = 0;

void setup(){
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0,-10);
  box2d.listenForCollisions();
  
  size( 500, 700 );
  surfaces = new ArrayList<Surface>();
  bumpers = new ArrayList<Bumper>();
  movers = new ArrayList<Mover>();
  ghosts = new ArrayList<Ghost>();
  pinballWizardPower = 0;
  float x,y;
  ArrayList<Vec2> points = new ArrayList<Vec2>();
  
  // LeftGuard --------------------------------------------
  points = new ArrayList<Vec2>();
  points.add(new Vec2(200,550));
  points.add(new Vec2(120,508));
  points.add(new Vec2(120,450)); 
  surfaces.add( new Surface(points,true,0) );
  
  // RightGuard --------------------------------------------
  points = new ArrayList<Vec2>();
  points.add(new Vec2(300,550));
  points.add(new Vec2(380,508));
  points.add(new Vec2(380,400)); 
  surfaces.add( new Surface(points,true,0) );
  
  // Backboard -------------------------------------------
  points = new ArrayList<Vec2>();
  points.add(new Vec2(180,600));
  points.add(new Vec2(430,640));
  points.add(new Vec2(430,690));
  points.add(new Vec2(450,690));
  for( int i=0; i< 180; i++ ){
    x = cos(radians(i))*200;
    y = sin(radians(i))*200;
    points.add(new Vec2(250+x,210-y));
  }
  points.add(new Vec2(50,600));
  surfaces.add( new Surface(points,true,42) );
  
  // Launch guard ----------------------------------------
  points = new ArrayList<Vec2>();
  points.add(new Vec2(430,600));
  for( int i=0; i<45; i += 1 ){
    x = cos(radians(i))*200;
    y = sin(radians(i))*200-i;
    points.add(new Vec2(230+x,210-y));
  }
  points.add(new Vec2(372,160));
  points.add(new Vec2(400,200));
  points.add(new Vec2(400,525));
  points.add(new Vec2(320,575));
  points.add(new Vec2(320,600));
  points.add(new Vec2(430,600));
  surfaces.add( new Surface(points,true,150) );
  
  // Bottom&Left ------------------------------------------
  points = new ArrayList<Vec2>();
  points.add(new Vec2(180,600));
  points.add(new Vec2(180,575));
  points.add(new Vec2(80,525));
  points.add(new Vec2(80,480));
  for( int i=-90; i<90; i++ ){
    x = cos(radians(i))*30;
    y = sin(radians(i))*(50 + (i*i*i*i)/2000000);
    points.add(new Vec2(80+x,400-y));
  }
  points.add(new Vec2(80,320));
  for( int i=185; i>120; i-- ){
    x = cos(radians(i))*100;
    y = sin(radians(i))*200;
    points.add(new Vec2(180+x,280-y));
  }
  for( int i=250; i>30; i-- ){
    x = cos(radians(i))*25;
    y = sin(radians(i))*25;
    points.add(new Vec2(150+x,70-y));
  }
  points.add(new Vec2(220,40));
  for( int i=180; i>0; i-- ){
    x = cos(radians(i))*25;
    y = sin(radians(i))*25;
    points.add(new Vec2(250+x,40-y));
  }
  points.add(new Vec2(380,60));
  for( int i=50; i<180; i++ ){
    x = cos(radians(i))*200;
    y = sin(radians(i))*200;
    points.add(new Vec2(250+x,210-y));
  }
  points.add(new Vec2(50,600));  
  surfaces.add( new Surface(points,true,150) );
  
  // LeftCatch ----------------------------------------------
  points = new ArrayList<Vec2>();
  for( int i=180; i<260; i++ ){
    x = cos(radians(i))*40;
    y = sin(radians(i))*40;
    points.add(new Vec2(220+x,220-y));
  }
  surfaces.add( new Surface(points,true,0) );
  
  // RightCatch ----------------------------------------------
  points = new ArrayList<Vec2>();
  for( int i=0; i>-80; i-- ){
    x = cos(radians(i))*40;
    y = sin(radians(i))*40;
    points.add(new Vec2(280+x,220-y));
  }
  surfaces.add( new Surface(points,true,0) );
  
  //
  
  // Spring -------------------------------------------------
  spring = new Spring();
  
  // Launcher -------------------------------------------------
  launcher = new Launcher(440,640,false);
  Launcher launchAnchor = new Launcher(440,700,true);
  DistanceJointDef djd = new DistanceJointDef();
  djd.bodyA = launcher.body;
  djd.bodyB = launchAnchor.body;
  djd.length = box2d.scalarPixelsToWorld(50);
  djd.frequencyHz = 7;
  djd.dampingRatio = 0;
  DistanceJoint dj = (DistanceJoint) box2d.world.createJoint(djd);
  
  // Ball ---------------------------------------------------
  ball = new Ball( 440,600,8 );
  
  // LeftFlipper ------------------------------------------
  lFlip = new Flipper(200,550,true);
  rjdLeft = new RevoluteJointDef();
  rjdLeft.initialize( lFlip.body , surfaces.get(0).body, box2d.coordPixelsToWorld(new Vec2(200,550)));  
  rjdLeft.enableMotor = true;
  rjdLeft.motorSpeed = PI*2;
  rjdLeft.maxMotorTorque = 3000.0;
  rjdLeft.enableLimit = true;
  rjdLeft.lowerAngle = radians(-30);
  rjdLeft.upperAngle = radians(30);
  leftJoint = (RevoluteJoint) box2d.world.createJoint(rjdLeft);
  
  // RightFlipper ------------------------------------------
  rFlip = new Flipper(300,550,false);
  rjdRight = new RevoluteJointDef();
  rjdRight.initialize( rFlip.body , surfaces.get(1).body, box2d.coordPixelsToWorld(new Vec2(300,550)));
  rjdRight.enableMotor = true;
  rjdRight.motorSpeed = -PI*2;
  rjdRight.maxMotorTorque = 3000.0;
  rjdRight.enableLimit = true;
  rjdRight.lowerAngle = radians(-210);
  rjdRight.upperAngle = radians(-150);
  rightJoint = (RevoluteJoint) box2d.world.createJoint(rjdRight);
  
  // Bumper 1
  points = new ArrayList<Vec2>();
  for( int i=0; i<359; i++ ){
    x = cos(radians(i))*10;
    y = sin(radians(i))*10;
    points.add(new Vec2(148+x,67-y));
  }
  bumpers.add( new Bumper(points,true,10));
  
  // Bumper 2
  points = new ArrayList<Vec2>();
  for( int i=0; i<359; i++ ){
    x = cos(radians(i))*20;
    y = sin(radians(i))*20;
    points.add(new Vec2(250+x,180-y));
  }
  bumpers.add( new Bumper(points,true,20));
  
  // Bumper 3
  points = new ArrayList<Vec2>();
  for( int i=0; i<359; i++ ){
    x = cos(radians(i))*10;
    y = sin(radians(i))*10;
    points.add(new Vec2(220+x,220-y));
  }
  bumpers.add( new Bumper(points,true,10));
  
  // Bumper 4
  points = new ArrayList<Vec2>();
  for( int i=0; i<359; i++ ){
    x = cos(radians(i))*10;
    y = sin(radians(i))*10;
    points.add(new Vec2(280+x,220-y));
  }
  bumpers.add( new Bumper(points,true,10));
  
  // Bumper 5
  points = new ArrayList<Vec2>();
  for( int i=0; i<359; i++ ){
    x = cos(radians(i))*10;
    y = sin(radians(i))*10;
    points.add(new Vec2(250+x,35-y));
  }
  bumpers.add( new Bumper(points,true,10));
  
  // Bumper 6
  points = new ArrayList<Vec2>();
  for( int i=0; i<359; i++ ){
    x = cos(radians(i))*20;
    y = sin(radians(i))*20;
    points.add(new Vec2(140+x,350-y));
  }
  bumpers.add( new Bumper(points,true,10));
  
  // Mover 1
  points = new ArrayList<Vec2>();
  points.add(new Vec2(180,510));
  points.add(new Vec2(150,487));
  points.add(new Vec2(150,450));
  points.add(new Vec2(180,510));
  movers.add( new Mover(points,true,10, new Vec2(20,50)));
  
  // Mover 2
  points = new ArrayList<Vec2>();
  points.add(new Vec2(320,510));
  points.add(new Vec2(350,487));
  points.add(new Vec2(350,450));
  points.add(new Vec2(320,510));
  movers.add( new Mover(points,true,10, new Vec2(-20,50)));
  
  // Mover 2
  points = new ArrayList<Vec2>();
  points.add(new Vec2(368,160));
  points.add(new Vec2(369,114));
  points.add(new Vec2(366,114));
  points.add(new Vec2(365,160));
  points.add(new Vec2(368,160));  
  movers.add( new Mover(points,true,10, new Vec2(-50,0)));
  
  // Mover 2
  points = new ArrayList<Vec2>();
  points.add(new Vec2(385,330));
  points.add(new Vec2(378,300));
  points.add(new Vec2(389,300));
  points.add(new Vec2(392,330));
  points.add(new Vec2(385,330)); 
  movers.add( new Mover(points,true,10, new Vec2(0,100)));
  
  
}

void draw(){
  box2d.step();
  background(71,77,119);
  
  for( Surface s : surfaces ){
    s.display();
  }
  for( Bumper b : bumpers ){
    b.display();
  }
  for( Mover m : movers ){
    m.display();
  }
  for( Ghost g : ghosts ){
    g.display();
  }
  
  if( ghosts.size() > 50 ){
    ghosts.remove(0);
  }
  
  spring.update(mouseX,mouseY);
  launcher.display();
  
  rFlip.display();
  lFlip.display();
  ball.display();
  
  fill(230,220,150);
  textSize(27);
  text( "Score: " + score,60,656 );
  
  textSize(14);
  fill( 80,220,255 );
  text( "PINBALL WIZARD POWER!!",60,680 );
  stroke( 255-pinballWizardPower, pinballWizardPower, 255-pinballWizardPower);
  line( 60, 690, 60+pinballWizardPower, 690);
  
  if(pinballWizardPower > 255){
    textSize(42);
    fill( 80,220,255 );
    text( "PINBALL\nWIZARD\nPOWER!!",170,320 );
    score += 5;
  }
  if( pinballWizardPower > 0 ){
    pinballWizardPower -=.025;
  }
  
  if( score < 900 ){
    fill(242,84,42);
    textSize(16);
    text( "Grab and Pull to Launch ->",210,655 );
  
    textSize(16);
    text( "Arrow Keys\nFor Flippers",56,568 );
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      rightJoint.setMotorSpeed(PI*7);
    }
    else if (keyCode == LEFT) {
      leftJoint.setMotorSpeed(-PI*7);
    }    
  }
  if (key == ' ') {
    //
  }
}
void keyReleased() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      rightJoint.setMotorSpeed(-PI*2);
    }
    else if (keyCode == LEFT) {
      leftJoint.setMotorSpeed(PI*2);
    }    
  }
  if (key == ' ') {
    //
  }
}

void mouseReleased() {
  spring.destroy();
}

void mousePressed() {
  if (launcher.contains(mouseX, mouseY)) {
    spring.bind(mouseX,mouseY,launcher);
  }
}

void beginContact(Contact c){
  Fixture f1 = c.getFixtureA();
  Fixture f2 = c.getFixtureB();
  
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  
  if( o1 instanceof Bumper ){
    Bumper tempBump = (Bumper) o1;
    tempBump.setOutline(255);
    score += tempBump.getScore();
    pinballWizardPower += 8;
  }
  if( o2 instanceof Bumper ){
    Bumper tempBump = (Bumper) o2;
    tempBump.setOutline(255);
    score += tempBump.getScore();
    pinballWizardPower += 8; 
  }
  
  if( o1 instanceof Mover ){
    Mover tempMove = (Mover) o1;
    tempMove.launch();
    score += 10;
    pinballWizardPower += 8;
  }
  if( o2 instanceof Mover ){
    Mover tempMove = (Mover) o2;
    tempMove.launch();
    score += 10;  
    pinballWizardPower += 8;
  }
}