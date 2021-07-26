GameStateContainer gameState;
RunGameStateContainer runState;

void initGameState(){
  runState = new RunGameStateContainer();
  gameState = new HubGameStateContainer();
}

void startRun(){
  runState = new RunGameStateContainer();
  applySaveState();
  gameState = runState;  
}

abstract class GameStateContainer{
  abstract void renderGame();
  abstract void tickGame();
}

class RunGameStateContainer extends GameStateContainer{
  ArrayList<Entity> entities;
  ArrayList<ArrayList<Tile>> tiles;
  
  // Player Attributes
    int maxHealth;
    int health;
    
  
  RunGameStateContainer(){
    entities = new ArrayList<Entity>();
    tiles = new ArrayList<ArrayList<Tile>>();
  }
  
  void renderGame(){
    
  }
  
  void tickGame(){
    
  }
}

class HubGameStateContainer extends GameStateContainer{
  void renderGame(){
    
  }
  
  void tickGame(){
    
  }
}
