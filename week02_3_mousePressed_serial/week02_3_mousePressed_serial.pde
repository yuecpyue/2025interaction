//week02_3_mousePressed_serial
import processing.serial.*;
Serial myPort;//宣告USB的Serial變數myPort
void mousePressed(){
  myPort.write(' ');//mouse按下去，就把" "送出去
}
void setup(){
 size(400,400); 
 myPort = new Serial(this,"COM4",9600);//準備好
}
void draw(){
  if(mousePressed) background(#FF1234);
  else background(#24FF45);
}
