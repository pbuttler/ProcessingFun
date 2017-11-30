class gridKeeper {
  
  HashMap<Integer,ArrayList> spatialBuckets;
  int cols, rows;
  
  // Inital setup of the grid
  void createGrid(int gridWidth, int gridHeight, int cellSize){
    
    // Compute the dimensions of the grid
    cols = gridWidth / cellSize;
    rows = gridHeight / cellSize;
    
    //Create a map for tracking each grid cell as a 'bucket'
    spatialBuckets = new HashMap<Integer,ArrayList>(cols * rows);
    //Name each 'bucket'
    for (int i = 0; i < cols * rows; i++){
      spatialBuckets.put(i, new ArrayList<Vehicle>());
    }
      
  }
  
  // Reset the buckets
  void ResetGrid(){
    spatialBuckets.clear();
    for (int i = 0; i < cols * rows; i++){
      spatialBuckets.put(i, new ArrayList<Vehicle>());
    }
  }
  
  // Place an object in it's appropriate bucket
  void placeObject(Vehicle obj){
   ArrayList<Integer> parentBuckets = getBucketsForVehicle(obj);
   // Loop through the list of 'parentBuckets'
   //    Add the obj to that bucket in 'spatialBuckets'
   
  }
  
  //Get the list of cells in which an object resides
  ArrayList<Integer> getBucketsForVehicle(Vehicle obj){
    ArrayList<Integer> buckets = new ArrayList<Integer>(4);
    //TODO
    // return a list of buckets
    // will be between 1 and 4
    //TODO
    return buckets;
  }
  
}