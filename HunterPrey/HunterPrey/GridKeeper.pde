class gridKeeper {
  
  HashMap<Integer,ArrayList> spatialBuckets;
  int cols, rows;
  int cellSize;
  
  // Inital setup of the grid
  void createGrid(int gridWidth, int gridHeight, int _cellSize){
    // Set the size of the cells, for tuning performance
    cellSize = _cellSize;
    
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
    
    // Two vectors from which we will construct the 4 corners
    PVector topCorner = new PVector((obj.position.x - obj.radius), (obj.position.y - obj.radius));
    PVector bottomCorner = new PVector((obj.position.x + obj.radius), (obj.position.y + obj.radius));
    
    // Determine size of buckets
    float bucketWidth = width / cellSize;
    
    //Compute the top left corner
    AddBucket(topCorner, bucketWidth, buckets);
    //Compute the top right corner
    AddBucket(new PVector(bottomCorner.x, topCorner.y), bucketWidth, buckets);
    //Compute the bottom right corner
    AddBucket(bottomCorner, bucketWidth, buckets);
    //Compute the bottom left corner
    AddBucket(new PVector(topCorner.x, bottomCorner.y), bucketWidth, buckets);
    
    return buckets;
  }
  
  // Take a vector (position of a vehicle), float (width of a bucket), and a list
  //    Add the bucket housing the vector to the tracking list
  void AddBucket(PVector vector, float bucketWidth, ArrayList listOfBuckets){
    
  }
  
}