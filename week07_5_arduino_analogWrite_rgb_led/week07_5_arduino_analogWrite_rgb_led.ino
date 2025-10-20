//week07_5_arduino_analogWrite_rgb_led
void setup() {
  pinMode(3,OUTPUT);//第3個pin腳輸出，接紅色
  pinMode(6,OUTPUT);//第6個pin腳輸出，接藍色
  pinMode(5,OUTPUT);//第5個pin腳輸出，綠色
  //RGB LED最長的要接地GND
}//3,5,6,9,10,11個pin腳，可以控制亮的程度

int a=0;
void loop() {
  analogWrite(6,0);//藍色關掉
  analogWrite(3,255);//最亮的紅色
  delay(500);
  analogWrite(3,0);//紅色關掉
  analogWrite(5,255);//最亮的綠色
  delay(500);
  analogWrite(5,0);//綠色關掉
  analogWrite(6,255);//最亮的藍色
  delay(500);
}
