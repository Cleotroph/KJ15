enum KEY{
  BINDING_UP('w', UP),
  BINDING_LEFT('a', LEFT),
  BINDING_RIGHT('d', RIGHT);
  
  private char s;
  private int code;
  private boolean pressed = false;
  private KEY(char s, int code){
    this.s = s;
    this.code = code; 
  }
  private KEY(char s){
    this.s = s;
  }
  private KEY(int code){
    this.code = code;  
  }
  
  void checkPress(int code){
     if(this.code == code){
       pressed = true;
     }
  }
  
  void checkRelease(int code){
     if(this.code == code){
       pressed = false;
     }
  }
  
  void checkPress(char keyName){
    if(Character.toLowerCase(keyName) == s){
      pressed = true;  
    }
  }
  
  void checkRelease(char keyName){
    if(Character.toLowerCase(keyName) == s){
      pressed = false;  
    }
  }
  
  boolean isPressed(){
    return pressed;
  }
}

void keyPressed(){
  for(int i = 0; i < KEY.values().length; i++){
    if(key == CODED){
      KEY.values()[i].checkPress(keyCode);
    }else{
      KEY.values()[i].checkPress(key);
    }
  }
}

void keyReleased(){
  for(int i = 0; i < KEY.values().length; i++){
    if(key == CODED){
      KEY.values()[i].checkRelease(keyCode);
    }else{
      KEY.values()[i].checkRelease(key);
    }
  }
}
