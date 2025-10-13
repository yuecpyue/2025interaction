//week06_4_arduino_slow_jogging
void setup() {
  pinMode(8,OUTPUT);// 8 Buzzer
}

void loop() {
  tone(8,780,60);//自己決定的頻率，pin8,780Hz,60ms
  delay(333);//等0.333秒,換下個音
  tone(8,320,60);//自己決定的頻率，pin8,320Hz,60ms
  delay(333);//等0.333秒,換下個音
}
