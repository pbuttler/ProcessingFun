// Hunter-Prey
//
// Author: Peter Buttler

//
// Collections
Surface[] surfaces;
ArrayList<Prey> prey;
ArrayList<Prey> eaten;
ArrayList<Hunter> hunters; 
// Globals

void setup(){
  size( 777,777 );
  background( 131,163,41 );
  
  surfaces = new Surface[7];
  for (int i = 0; i < 7; i++) {
    surfaces[i] = new Surface(random(50, width-50), random(50, height-50),random(10, 40));
  }
  
  prey = new ArrayList<Prey>();
  for(int i=0; i<random(15,20) ; i++){
    prey.add( new Prey(random(50, width-50), random(50, height-50),random(2,6),6, 0.3));
  }
  
  hunters = new ArrayList<Hunter>();
  for(int i=0; i<2; i++){
    hunters.add( new Hunter(random(50, width-50), random(50, height-50),12,7, 0.2));
  }
  
  eaten = new ArrayList<Prey>();
  
}

void draw(){
  background( 131,163,41 );
  //draw all objects
  for( Surface s : surfaces ) {
    s.display();
  }
  for( Prey p : prey ) {
    p.update();
    p.display();
  }
  for( Hunter h : hunters ){
    h.update();
    h.display();
  }
  //update all objects
  for( Prey rE : eaten ){
   prey.remove( rE );
  }
}
