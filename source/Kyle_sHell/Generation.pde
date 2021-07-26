ArrayList<Tile> convertColumnToTiles(int[] tiles, float x){
  ArrayList<Tile> column = new ArrayList<Tile>();
  for(int i = 0; i < tiles.length; i++){
    switch(tiles[i]){
      case 0:
      column.add(new TileEmpty(x, i * 32 - 12));
        break;
      case 1:
        column.add(new TileStone(x, i * 32 - 12, x/32 > 100 ? (x/32 > 200 ? (x/32 > 300 ? 3 : 2) : 1) : 0));
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
  runState.tileMap.add(convertColumnToTiles(generateTileValues(x), x));  
}

int distToEnemy;
int distToCaveIn;
int distToElevationChange;
int currentElevation;

void initGenerator(){
  randomSeed(millis() + minute());
  distToEnemy = 15;
  distToCaveIn = 1;
  distToElevationChange = 10;
  currentElevation = 16;
}

int[] generateTileValues(float x){
  int[]column = new int[34];
  int lastElevation = currentElevation;
  column[0] = 3;
  column[33] = 3;
  distToEnemy--;
  distToCaveIn--;
  distToElevationChange--;
  
  if (distToCaveIn == 0){
    distToCaveIn+=random(6, 12);
  }
  if (distToElevationChange == 0){
    currentElevation += random(Math.max(-10, -currentElevation), Math.min(10, 31 - currentElevation));
    distToElevationChange += random(6, 12);
  }
  if (distToEnemy == 0){
    if(currentElevation != lastElevation){
      distToEnemy += 3;
    }else{
      runState.entityMap.add(new EnemyRat(x, currentElevation * 32 + 12));
      distToEnemy+=random(10, 15);
    }
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
