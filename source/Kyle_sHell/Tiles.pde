// Data container for static tile properties
class TileProperty{
  boolean breakable;
  int miningLevel;
  int hardness;
  TileProperty(boolean breakable, int miningLevel, int hardness){
    this.breakable = breakable;
    this.miningLevel = miningLevel;
    this.hardness = hardness;
  }
}

// Data container for instance tile properties
abstract class Tile {
  float x;
  float y;
  Tile(float x, float y){
    this.x = x;
    this.y = y;
  }
  abstract void renderTile();
  abstract void onBreak();
}

class TileStone extends Tile {
  TileStone(float x, float y){
    super(x, y);
  }
  
  void renderTile(){
    
  }
  
  void onBreak() {
    
  }
}
