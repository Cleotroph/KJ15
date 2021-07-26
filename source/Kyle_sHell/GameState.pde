GameStateContainer gameState;
RunGameStateContainer runState;

void initGameState(){
  runState = new RunGameStateContainer();
  gameState = new HubGameStateContainer();
}

void startRun(){
  initGenerator();
  runState = new RunGameStateContainer();
  applySaveState();
  gameState = runState;  
}

abstract class GameStateContainer{
  abstract void renderGame();
  abstract void tickGame();
}

class RunGameStateContainer extends GameStateContainer{
  ArrayList<Entity> entityMap;
  ArrayList<ArrayList<Tile>> tileMap;
  int scroll;
  
  // Player Attributes
  PlayerEntity player;
    
  
  RunGameStateContainer(){
    entityMap = new ArrayList<Entity>();
    tileMap = new ArrayList<ArrayList<Tile>>();
    player = new PlayerEntity();
    entityMap.add(player);
  }
  
  void renderGame(){
    translate(-scroll, 0);
    for(ArrayList<Tile> column : tileMap){
      for(Tile t : column){
        t.renderTile();  
      }
    }
    for(Entity e : entityMap){
      e.renderEntity();  
    }
  }
  
  void tickGame(){
    //scroll++;
    for(Entity e : entityMap){
      e.onTick();  
    }
  }
}

class HubGameStateContainer extends GameStateContainer{
  void renderGame(){
    
  }
  
  void tickGame(){
    
  }
}
