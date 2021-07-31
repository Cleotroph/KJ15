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

abstract class ColliderEntity extends Entity{
  float dx, dy;
  boolean onGround = false;
  ColliderEntity(float x, float y){
    super(x, y);
  }
  void onTick(){
    onGround = false;
    float newX = x + dx;
    float newY = floor(y + dy);
    if(dx > 0){
      int tileX = floor(newX + 32) / 32;
      int tileY1 = floor(y + 1 + 12) / 32;
      int tileY2 = floor(y + 31 + 12) / 32;
      if(!(runState.tileMap.get(tileX).get(tileY1).propertyContainer.solid || runState.tileMap.get(tileX).get(tileY2).propertyContainer.solid)){
        x+=dx;
      }else{
        dx = 0;
        x = (tileX - 1) * 32;
      }
    }
    if(dx < 0){
      int tileX = floor(newX) / 32;
      int tileY1 = floor(y + 1 + 12) / 32;
      int tileY2 = floor(y + 31 + 12) / 32;
      if(!(runState.tileMap.get(tileX).get(tileY1).propertyContainer.solid || runState.tileMap.get(tileX).get(tileY2).propertyContainer.solid)){
        x+=dx;
      }else{
        dx = 0;
        x = (tileX + 1) * 32;
      }
    }
    
    if(dy > 0){
      int tileY = floor(newY + 12 + 32) / 32;
      int tileX1 = floor(x + 1) / 32;
      int tileX2 = floor(x + 31) / 32;
      /*noFill();
      stroke(255, 255, 0);
      strokeWeight(1.5);
      rect(tileX1 * 32, tileY * 32 - 12, 32, 32);
      rect(tileX2 * 32, tileY * 32 - 12, 32, 32);*/
      if(!(runState.tileMap.get(tileX1).get(tileY).propertyContainer.solid || runState.tileMap.get(tileX2).get(tileY).propertyContainer.solid)){
        y+=dy;
      }else{
        dy = 0;
        onGround = true;
        y = (tileY - 1) * 32 - 12;
      }
    }
    if(dy < 0){
      int tileY = floor(newY + 12) / 32;
      int tileX1 = floor(x + 1) / 32;
      int tileX2 = floor(x + 31) / 32;
      if(!(runState.tileMap.get(tileX1).get(tileY).propertyContainer.solid || runState.tileMap.get(tileX2).get(tileY).propertyContainer.solid)){
        y+=dy;
      }else{
        dy = 0;
        y = (tileY + 1) * 32 - 12;
      }
    }
    onPhysicsTick();
  }
  abstract void onPhysicsTick();
  abstract void renderEntity();
}

abstract class GravityEntity extends ColliderEntity{
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

class EnemyRat extends GravityEntity{
  int cooldown = 100;
  EnemyRat(float x, float y){
    super(x, y, 0.3);
  }
  void onGravityTick(){
    cooldown--;
    for(int i = runState.projectileEntityMap.size() - 1; i >= 0; i--){
        if(dist(x, y, runState.projectileEntityMap.get(i).x, runState.projectileEntityMap.get(i).y) < 32){
          runState.entityMap.remove(this);
          runState.projectileEntityMap.remove(i);
        }
      }
    if(cooldown == 0){
      runState.entityMap.add(new ProjectileTear(x, y));
      
      //testfor projectile
      
      
      
      cooldown = 100;
    }
  }
  void renderEntity(){
    image(textures.get("rat"), x, y);
  }
}

abstract class Projectile extends PhysicsEntity{
  Projectile(float x, float y){
    super(x, y);
  }
  void onPhysicsTick(){
    if(x < 0 || runState.tileMap.get(floor((x + 16) / 32)).get(floor((y + 12 + 16) / 32)).propertyContainer.solid){
      runState.entityMap.remove(this);
      return;
    }
    onProjectilesTick();
  }
  abstract void onProjectilesTick();
  abstract void renderEntity();
}

class ProjectileTear extends Projectile{
  ProjectileTear(float x, float y){
    super(x, y);
    dx = -2.5;
  }
  void onProjectilesTick(){
    if(dist(x, y, runState.player.x, runState.player.y) < 32){
      sounds.get("lose" + floor(random(0, 7))).play();
      runState.scrollSpeed = 0;
      runState.dead = true;  
    }
  }
  void renderEntity(){
    image(textures.get("tear"), x, y);
  }
}

class ProjectileSpear extends Projectile{
  ProjectileSpear(float x, float y){
    super(x, y);
    dx = 2.5;
  }
  void onProjectilesTick(){
    
  }
  void renderEntity(){
    image(textures.get("spear"), x - 32, y);
  }
}
