//week10_4_arduino_serial_monitar_joystick_Serial_println
//改自week10_3_arduino_analogRead_A3
//把joystick的Y的線，經由麵包板接到makeruno A3
//只能接有~符號的，代表analog訊號
void setup() {
  Serial.begin(9600);
  pinMode(2, INPUT_PULLUP);
  pinMode(8, OUTPUT);
}

void loop() {
  delay(100);//慢一點，避免processing來不及處理
  int now = analogRead(A3);
  Serial.println(now);
  //利用serial monitor看訊號
  if (now > 800) {
    tone(8, 523, 100);
    delay(100);
    tone(8, 784, 100);
    delay(200);
  } else if (now < 200) {
    tone(8, 784, 100);
    delay(100);
    tone(8, 523, 100);
    delay(200);
  }
}
