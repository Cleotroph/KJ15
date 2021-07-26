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
  ArrayList<Entity> entitieMap;
  ArrayList<ArrayList<Tile>> tileMap;
  int scroll;
  
  // Player Attributes
    int maxHealth;
    int health;
    
  
  RunGameStateContainer(){
    entitieMap = new ArrayList<Entity>();
    tileMap = new ArrayList<ArrayList<Tile>>();
  }
  
  void renderGame(){
    translate(-scroll, 0);
    for(ArrayList<Tile> column : tileMap){
      for(Tile t : column){
        t.renderTile();  
      }
    }
  }
  
  void tickGame(){
    scroll++;
  }
}

class HubGameStateContainer extends GameStateContainer{
  void renderGame(){
    
  }
  
  void tickGame(){
    
  }
}
