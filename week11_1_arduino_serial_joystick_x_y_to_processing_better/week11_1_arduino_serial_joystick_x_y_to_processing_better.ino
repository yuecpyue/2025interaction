//week11_1_arduino_serial_joystick_x_y_to_processing_better
//修改自week10_7_arduino_serial_joystick_x_y_to_processing
void setup() {
  Serial.begin(9600);
  pinMode(2, INPUT_PULLUP);
  pinMode(8, OUTPUT);
}
int count=0 , totalX=0 , totalY=0 ;
int x0=512,y0=512;
void loop() {
  delay(30);//慢一點，避免processing來不及處理
  int x=analogRead(A0);//把搖桿的x接到A2
  int y=analogRead(A1);//把搖桿的y接到A3
  if(count<20){
    totalX += x;//加總，算平均值
    totalY += y;//加總，算平均值
    count++;//讀到一筆
    x0=totalX/count;//算平均
    y0=totalY/count;
  }
  //Serial.write(x/4);//把0~1023變成0~255
  //Serial.write(y/4);
  if(abs(x-x0)<25) x=128;//數值變化太小，直接放128
  else x=(x-x0)/4.4+128;//有大的數值就減掉中間值，再/4+128
  if(abs(y-y0)<25) y=128;//數值變化太小，直接放128
  else y=(y-y0)/4.4+128;//有大的數值就減掉中間值，再/4+128
  Serial.write(x);
  Serial.write(y);
  if(x>900) tone(8,784,100);
  if(x<100) tone(8,523,100);
  if(y>900) tone(8,659,100);
  if(y<100) tone(8,500,100);
}