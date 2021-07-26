abstract class Entity{
  float x;
  float y;
  Entity(float x, float y){
    this.x = x;
    this.y = y;
  }
  abstract void onTick();
  abstract void renderEntity();
}

abstract class PhysicsEntity extends Entity{
  float dx, dy;
  PhysicsEntity(float x, float y){
    super(x, y);
  }
  void onTick(){
    x+=dx;
    y+=dy;
    onPhysicsTick();
  }
  abstract void onPhysicsTick();
  abstract void renderEntity();
}

abstract class GravityEntity extends PhysicsEntity{
  float g;
  GravityEntity(float x, float y, float g){
    super(x, y);
    this.g = g;
  }
  void onPhysicsTick(){
    dy += g;
    onGravityTick();
  }
  abstract void onGravityTick();
  abstract void renderEntity();
}

class PlayerEntity extends GravityEntity{
  PlayerEntity(){
    super(0, 532, 0.05);
  }
  
  void onGravityTick(){
    dx = 0;
    if(KEY.BINDING_RIGHT.isPressed()){
      dx+=4;
    }
    if(KEY.BINDING_LEFT.isPressed()){
      dx-=4;
    }
  }
  
  void renderEntity(){
    image(textures.get("player"), x, y);
  }
}
