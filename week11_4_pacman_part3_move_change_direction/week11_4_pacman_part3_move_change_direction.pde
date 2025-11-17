//week11_4_pacman_part3_move_change_direction
//修改自week11_3_pacman_part2_move_x_y_void_keyPressed
//小精靈張嘴(要動)，移動時嘴巴方向改變
void setup(){
 size(500,500); 
}
int x=250,y=250,dx=0,dy=0,dir=0;
float m=0,dm=0.05;//mouth，dm為嘴巴變化量
void draw(){
  background(0);
  fill(255,255,0);
  float m0=dir*PI/2;
  arc(x,y,30,30,m0+m,m0+PI*2-m);//弧度
  x+=dx;
  y+=dy;
  if(m>=1 || m<0) dm=-dm;//正負倒過來
  m+=dm;
}
void keyPressed(){
   if(keyCode==LEFT) { dx=-1;dy=0; dir=2;}//向左PI
   if(keyCode==RIGHT) { dx=1;dy=0; dir=0;}//向右0度
   if(keyCode==UP) { dx=0;dy=-1; dir=3;}//向上PI*3/2
   if(keyCode==DOWN) { dx=0;dy=1; dir=1;}//向下PI/2
}
