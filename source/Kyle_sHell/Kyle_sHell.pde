void settings(){
  promptUser();
  while(!gameWindowOpen){}
  if(newGame){
    generateNewSave(currentNewSaveName);  
  }else{
    println(currentSaveName);  
  }
  fullScreen();
  println(resolutionMode);
}

void setup(){
  //size(500, 500);
  
}

void draw(){
  
}
