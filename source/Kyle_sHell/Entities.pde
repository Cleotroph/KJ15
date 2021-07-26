abstract class Entity{
  float x;
  float y;
  Entity(float x, float y){
    this.x = x;
    this.y = y;
  }
  abstract void onTick();
}
