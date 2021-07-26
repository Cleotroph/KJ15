HashMap<String, TileProperty> tileRegistry;

void initTiles(){
  tileRegistry = new HashMap<String, TileProperty>();
  tileRegistry.put("stone0", new TileProperty(true, 0, 10, true, false));
  tileRegistry.put("stone1", new TileProperty(true, 0, 20, true, false));
  tileRegistry.put("tin", new TileProperty(true, 0, 30, true, false));
  tileRegistry.put("stone2", new TileProperty(true, 1, 25, true, false));
  tileRegistry.put("stone3", new TileProperty(true, 1, 30, true, false));
  tileRegistry.put("iron", new TileProperty(true, 1, 40, true, false));
}

// Data container for static tile properties
class TileProperty{
  boolean breakable;
  int miningLevel;
  int hardness;
  boolean solid;
  boolean climbable;
  TileProperty(boolean breakable, int miningLevel, int hardness, boolean solid, boolean climbable){
    this.breakable = breakable;
    this.miningLevel = miningLevel;
    this.hardness = hardness;
    this.solid = solid;
    this.climbable = climbable;
  }
}

// Data container for instance tile properties
abstract class Tile {
  float x;
  float y;
  TileProperty propertyContainer;
  Tile(float x, float y, TileProperty propertyContainer){
    this.x = x;
    this.y = y;
    this.propertyContainer = propertyContainer;
  }
  abstract void renderTile();
  abstract void onBreak();
}

class TileStone extends Tile {
  int tier;
  TileStone(float x, float y, int tier){
    super(x, y, null);
    this.tier = tier;
    this.propertyContainer = propertyFactory(tier);
  }
  
  TileProperty propertyFactory(int tier){
    switch(tier){
      case 0:
        return tileRegistry.get("stone0");        
      case 1:
        return tileRegistry.get("stone1");      
      case 2:
        return tileRegistry.get("stone2");      
      case 3:
        return tileRegistry.get("stone3");      
      default:
        return tileRegistry.get("stone0");      
    }
  }
  
  void renderTile(){
    image(textures.get("stone" + tier), x, y);
  }
  
  void onBreak() {
    println("bonk");
  }
}

class TileStoneUnbreakable extends Tile {
  
  TileStoneUnbreakable(float x, float y){
    super(x, y, new TileProperty(false, 0, 0, true, false));
  }
  
  void renderTile(){
    image(textures.get("stone0"), x, y);
  }
  
  void onBreak(){
    
  }
  
}

class TileLadder extends Tile {
  
  TileLadder(float x, float y){
    super(x, y, new TileProperty(false, 0, 0, false, true));
  }
  
  void renderTile(){
    image(textures.get("ladder"), x, y);
  }
  
  void onBreak(){
    
  }
  
}

class TileEmpty extends Tile {
  
  TileEmpty(float x, float y){
    super(x, y, new TileProperty(false, 0, 0, false, false));
  }
  
  void renderTile(){

  }
  
  void onBreak(){
    
  }
  
}
