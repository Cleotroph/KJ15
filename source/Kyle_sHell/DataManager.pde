String currentSaveName;

String[] getSaveNames(){
  
  File path = new File(dataPath("saves"));
  String[] paths = path.list();
  for(int i = 0; i < paths.length; i++){
    paths[i] = paths[i].substring(0, paths[i].length() - 5);
  }
  return paths;
}

void saveCurrentState(){
  JSONObject save = new JSONObject();
  for(int i = 0; i < saveState.size(); i++){
    save.setBoolean("" + i, saveState.get(i).getState());
  }
  for(String k : saveStateProperties.keySet()){
    save.setInt(k, saveStateProperties.get(k));
  }
  saveJSONObject(save, "data/saves/" + currentSaveName + ".json");
}

void generateNewSave(String name){
  currentSaveName = name;
  saveCurrentState();
}

void loadSave(){
  JSONObject save = loadJSONObject("data/saves/" + currentSaveName + ".json");
  for(int i = 0; i < saveState.size(); i++){
    saveState.get(i).loadState(save.getBoolean("" + i, false));
  }
  for(String k : saveStateProperties.keySet()){
    saveStateProperties.put(k, save.getInt(k, 0));
  }
}
