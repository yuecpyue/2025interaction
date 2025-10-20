//week07_4_arduino_analogWrite
void setup() {
  pinMode(11,OUTPUT);//第11個pin腳輸出
}
//3,5,6,9,10,11個pin腳，可以控制亮的程度
int a=0;
void loop() {
  analogWrite(11,a);//管理11pin腳亮的程度
  a=(a+1) % 256;//會再亮一點點
  delay(10);
}
