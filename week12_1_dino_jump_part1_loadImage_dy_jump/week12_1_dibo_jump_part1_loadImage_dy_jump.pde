//week12_1_dibo_jump_part1_loadImage_dy_jump
//恐龍跳跳
PImage img;
void setup(){
  size(300,300);
  img=loadImage("dino.jpg");
}
float x=200,y=400,dy=0,dx=0;
void draw(){
  background(255);
  //image(img,mouseX,mouseY,100,100);
  image(img,x,y,100,100);
  y+=dy;
  if(y<400) dy+=0.98;
  else dy=0;
}
void keyPressed(){
   if(keyCode==UP) dy=-15; 
}
