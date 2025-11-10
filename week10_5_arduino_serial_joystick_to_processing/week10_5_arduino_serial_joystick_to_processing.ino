//week10_5_arduino_serial_joystick_to_processing
//修改自week10_4_arduino_serial_monitar_joystick_Serial_println
//但是不用Serial.println()，改用Serial.write() 0~1023 vs 0~255差四倍
void setup() {
  Serial.begin(9600);
  pinMode(2, INPUT_PULLUP);
  pinMode(8, OUTPUT);
}

void loop() {
  delay(30);
  int now=analogRead(A3)/4;//需除4才可以用Serial.write()送出
  Serial.write(now);
  if(now>200) tone(8,784,100);
  if(now<50) tone(8,523,100);
}
