class gridKeeper {
  // Inital setup of the grid
  void createGrid(int gridWidth, int gridHeight, int cellSize){
    
    // Compute the dimensions of the grid
    int cols = gridWidth / cellSize;
    int rows = gridHeight / cellSize;
    
    //Create a map for tracking each grid cell as a 'bucket'
    HashMap<Integer,ArrayList> spatialBuckets = new HashMap<Integer,ArrayList>(cols * rows);
    //Name each 'bucket'
    for (int i = 0; i < cols * rows; i++){
      spatialBuckets.put(i, new ArrayList<Vehicle>());
    }
      
  }
  
  // Reset the buckets
  void ResetGrid(){
    // TODO
  }
  
  // Place an object in it's appropriate bucket
  void placeObject(Vehicle obj){
   //TODO 
  }
  
}