String currentSaveName;

String[] getSaveNames(){
  return new String[] {"a", "b", "CCCCCCCCCC"};
}

void generateNewSave(String name){
  println("new save: " + name);
  currentSaveName = name;
}
