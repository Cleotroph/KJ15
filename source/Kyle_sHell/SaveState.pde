ArrayList<SaveStateObject> saveState;

void initSaveState(){
  saveState = new ArrayList<SaveStateObject>();
  saveState.add(new SaveStateObject(){
    public void onActivate(){
      println("activated");
    }
  });
}

abstract class SaveStateObject{
  boolean active = false;
  abstract void onActivate();
  void activate(){
    active = true;
    onActivate();
  }
  boolean getState(){
    return active;  
  }
  void loadState(boolean state){
    this.active = state;
    if(active){
      onActivate();  
    }
  }
}
