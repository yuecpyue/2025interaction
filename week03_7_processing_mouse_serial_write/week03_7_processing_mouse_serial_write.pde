//week03_7_processing_mouse_serial_write
import processing.serial.*;
Serial myPort;
void setup(){
  size(400,400);
  myPort= new Serial(this,"COM3",9600);//COM幾要看電腦
}
void mousePressed(){
   myPort.write("b");//用USB來傳字母b 
}
void draw(){
  if(mousePressed) background(#FF0000);
  else background(#0000FF);
}
