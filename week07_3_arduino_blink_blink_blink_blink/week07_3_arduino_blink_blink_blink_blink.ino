//week07_3_arduino_blink_blink_blink_blink
//改自week07_2_arduino_blink_blink
void setup() {
  pinMode(10,OUTPUT);//把第10支腳OUTPUT
  pinMode(11,OUTPUT);//把第11支腳OUTPUT
  pinMode(12,OUTPUT);//把第12支腳OUTPUT
  pinMode(13,OUTPUT);//把第13支腳OUTPUT
}

void loop() {
  for(int i=10;i<=13;i++){
    digitalWrite(13,LOW);//暗掉
    digitalWrite(i-1,LOW);//暗掉
    digitalWrite(i,HIGH);//發亮
    delay(500);
  }
}
