//week12_5_coins_falling_part1_PImage_image_y
//接金幣
PImage imgCoin;
void setup(){
  size(300,500);
  imgCoin=loadImage("coin.jpg");
}
float x=0,y=0;
void draw(){
  background(255);
  //image(imgCoin,mouseX.mouseY,100,100);
  image(imgCoin,x,y,100,100);
  y+=3;
}
