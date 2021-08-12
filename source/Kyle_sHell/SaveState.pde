ArrayList<SaveStateObject> saveState;
HashMap<String, Integer> saveStateProperties; 

void initSaveState(){
  saveState = new ArrayList<SaveStateObject>();
  saveState.add(new SaveStateObject(){
    public void onApply(){
      println("activated");
    }
  });
  saveStateProperties = new HashMap<String, Integer>();
  saveStateProperties.put("gold", 0);
}

void applySaveState(){
  for(SaveStateObject s : saveState){
    s.apply();
  }
}

abstract class SaveStateObject{
  boolean active = false;
  abstract void onApply();
  void activate(){
    active = true;
  }
  
  boolean getState(){
    return active;  
  }
  
  void apply(){
    if(active){
      onApply();  
    }  
  }
  
  void loadState(boolean state){
    this.active = state;
  }
}
