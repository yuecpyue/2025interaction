//week07_2_arduino_blink_blink
//改自week07_1_arduino_blink
void setup() {
  pinMode(12,OUTPUT);
  pinMode(13,OUTPUT); //把第13支腳OUTPUT
}

void loop() {
  digitalWrite(12,LOW);//暗掉
  digitalWrite(13,HIGH);//發亮
  delay(500);
  digitalWrite(13,LOW);//暗掉
  digitalWrite(12,HIGH);//發亮
  delay(500);
}
