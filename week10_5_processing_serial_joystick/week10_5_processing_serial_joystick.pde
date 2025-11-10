//week10_5_processing_serial_joystick
import processing.serial.*;
Serial myPort;
void setup(){
  size(512,200);
  myPort=new Serial(this,"COM3",9600);
}
int now=255;
void draw(){
  background(now);
  ellipse(now,100,8,8);//顯示位置
  if(myPort.available()>0){
     now=myPort.read(); 
  }
}
