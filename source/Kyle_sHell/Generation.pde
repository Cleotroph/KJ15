ArrayList<Tile> convertColumnToTiles(int[] tiles, float x){
  ArrayList<Tile> column = new ArrayList<Tile>();
  for(int i = 0; i < tiles.length; i++){
    switch(tiles[i]){
      case 0:
        break;
      case 1:
        column.add(new TileStone(x, i * 32 - 12, 0));
        break;
      case 2:
        column.add(new TileLadder(x, i * 32 - 12));
        break;
      case 3:
        column.add(new TileStoneUnbreakable(x, i * 32 - 12));
        break;
    }
  }
  return column;
}

void genNextColumn(float x){
  runState.tileMap.add(convertColumnToTiles(generateTileValues(), x));  
}

int distToEnemy;
int distToCaveIn;
int distToElevationChange;
int currentElevation;

void initGenerator(){
  randomSeed(millis() + minute());
  distToEnemy = 1;
  distToCaveIn = 1;
  distToElevationChange = 10;
  currentElevation = 16;
}

int[] generateTileValues(){
  int[]column = new int[34];
  int lastElevation = currentElevation;
  column[0] = 3;
  column[33] = 3;
  distToEnemy--;
  distToCaveIn--;
  distToElevationChange--;
  if (distToEnemy == 0){
    distToEnemy+=random(5, 10);
  }
  if (distToCaveIn == 0){
    distToCaveIn+=random(6, 12);
  }
  if (distToElevationChange == 0){
    currentElevation += random(Math.max(-10, -currentElevation), Math.min(10, 31 - currentElevation));
    distToElevationChange += random(6, 12);
  }
  
 for(int i = 1; i < column.length - 1; i++){
    if(currentElevation < lastElevation){
      if (i >= currentElevation + 1 && i <= lastElevation + 1){
        column[i] = 2;  
      }else{
        column[i] = 1;
      }
    }else if(currentElevation > lastElevation){
      if (i <= currentElevation + 1 && i >= lastElevation + 1){
        column[i] = 0;  
      }else{
        column[i] = 1;
      }
    }else{
      if (i == currentElevation + 1){
        column[i] = 0;    
      }else{
        column[i] = 1;
      }
    }
  }
  return column;
}
