void settings(){
  promptUser();
  while(!gameWindowOpen){}
  loadResources();
  initTiles();
  initGameState();
  initSaveState();
  if(newGame){
    generateNewSave(currentNewSaveName);
  }else{
    loadSave(); 
  }
  switch(resolutionMode){
    case 0:
      size(1280, 720, P2D);
      screenScale = 1280.0/1920.0;
      screenOffset = 0;
      screenOffsetDir = false;
      break;
    case 1:
      size(1920, 1080, P2D);
      screenScale = 1;
      screenOffset = 0;
      screenOffsetDir = false;
      break;
    case 2:
      //size(1000, 500);
      fullScreen(P2D, 1);
      break;
    case 3:
      fullScreen(P2D, 2);
      break;
  }
  noSmooth();
}

void setup(){
  if(resolutionMode >= 2){
    if(width/1920.0 < height/1080.0){
      screenScale = width/1920.0;
      screenOffset = -(1080 - (height / screenScale)) / 2.0;
      screenOffsetDir = false;
    }else{
      screenScale = height/1080.0;
      screenOffset = -(1920 - (width / screenScale)) / 2.0;
      screenOffsetDir = true;
    }
  }
  startRun();
}

void draw(){
  background(50);
  scale(screenScale);
  if(screenOffsetDir){
    translate(screenOffset, 0);
  }else{
    translate(0, screenOffset);
  }
  clip(0, 0, 1920, 1080);
  gameState.renderGame();
  gameState.tickGame();
}
