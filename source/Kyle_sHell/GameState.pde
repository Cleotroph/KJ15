GameStateContainer gameState;

void initGameState(){
  gameState = new GameStateContainer();
}

class GameStateContainer{
  ArrayList<Entity> entities;
  ArrayList<ArrayList<Tile>> tiles;
  
  // Player Attributes
    int maxHealth;
    int health;
    
  
  GameStateContainer(){
    entities = new ArrayList<Entity>();
    tiles = new ArrayList<ArrayList<Tile>>();
  }
  
  void renderGame(){
    
  }
}
