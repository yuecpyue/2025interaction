//week06_1_sound_library_SoundFile_play
//Sketch-Library-ManageLibraries，找sound安裝
import processing.sound.*;
SoundFile sound;

void setup(){
  size(500,400);
  background(#00FF00);
  sound=new SoundFile(this,"music.mp3");
  //把music.mp3拉進程式裡
  sound.play();
}
void draw(){
  
}
