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
  for(int i = 0; i < 1500; i++){
    genNextColumn(i * 32);
  }
}

abstract class GameStateContainer{
  abstract void renderGame();
  abstract void tickGame();
}

class RunGameStateContainer extends GameStateContainer{
  ArrayList<Entity> entityMap;
  ArrayList<ProjectileSpear> projectileEntityMap;
  ArrayList<ArrayList<Tile>> tileMap;
  boolean dead = false;
  int scroll;
  int scrollSpeed = 1;
  
  // Player Attributes
  PlayerEntity player;
    
  
  RunGameStateContainer(){
    entityMap = new ArrayList<Entity>();
    tileMap = new ArrayList<ArrayList<Tile>>();
    projectileEntityMap = new ArrayList<ProjectileSpear>();
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
    for(int i = projectileEntityMap.size() - 1; i >= 0; i--){
      projectileEntityMap.get(i).renderEntity();  
    }
  }
  
  void tickGame(){
    if(!dead){
      scroll += scrollSpeed;
      for(int i = entityMap.size() - 1; i >= 0; i--){
        entityMap.get(i).onTick();  
      }
      for(int i = projectileEntityMap.size() - 1; i >= 0; i--){
        projectileEntityMap.get(i).onTick();  
      }
    }
  }
}

class HubGameStateContainer extends GameStateContainer{
  void renderGame(){
    
  }
  
  void tickGame(){
    
  }
}

class PlayerEntity extends GravityEntity{
  int cooldown = 0;
  PlayerEntity(){
    super(128, 532, 0.3);
  }
  
  void onGravityTick(){
    cooldown--;
    dx = 0;
    if(KEY.BINDING_RIGHT.isPressed()){
      dx+=4;
    }
    if(KEY.BINDING_LEFT.isPressed()){
      dx-=4;
    }
    if(KEY.BINDING_UP.isPressed() && (onGround || runState.tileMap.get(floor((x + 16) / 32)).get(floor((y + 12 + 16) / 32)).propertyContainer.climbable)){
      dy = -7.5;
    }
    if(x + 32 < runState.scroll){
      sounds.get("lose" + floor(random(0, 7))).play();
      runState.scrollSpeed = 0;
      runState.dead = true;
    }
    if(x > 400 * 32){
      sounds.get("win0").play();
      runState.scrollSpeed = 0;
      runState.dead = true;
    }
    if(KEY.BINDING_DOWN.isPressed() && cooldown <= 0){
      cooldown = 100;
      runState.projectileEntityMap.add(new ProjectileSpear(x + 32, y + random(-100, 100)));
    }
  }
  
  void renderEntity(){
    image(textures.get("player"), x, y);
  }
}
