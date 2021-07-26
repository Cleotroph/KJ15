import processing.sound.*;

HashMap<String, PImage> textures;
HashMap<String, SoundFile> sounds;

void loadResources(){
  loadTextures();
  loadSounds();
}

void loadTextures(){
  File path = new File(dataPath("assets/textures"));
  textures = new HashMap<String, PImage>();
  for(String s : path.list()){
    textures.put(s.substring(0, s.length() - 4), loadImage("assets/textures/" + s));
  }
}

void loadSounds(){
  File path = new File(dataPath("assets/sounds"));
  sounds = new HashMap<String, SoundFile>();
  for(String s : path.list()){
    sounds.put(s.substring(0, s.length() - 4), new SoundFile(this, "assets/sounds/" + s));
  }
}
