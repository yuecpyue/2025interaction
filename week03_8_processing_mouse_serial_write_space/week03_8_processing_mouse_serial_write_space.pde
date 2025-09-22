//week03_8_processing_mouse_serial_write_space
import processing.serial.*;
Serial myPort;
void setup(){
  size(400,400);
  myPort= new Serial(this,"COM3",9600);//COM幾要看電腦
}
void mousePressed(){
   if(mouseButton==LEFT) myPort.write('b');//用USB來傳字母b 
   if(mouseButton==RIGHT) myPort.write(' ');//傳空格
}
void draw(){
  if(mousePressed) background(#FF0000);
  else background(#0000FF);
}
