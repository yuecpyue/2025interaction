//week10_3_arduino_analogRead_A3
//把joystick的Y的線，經由麵包板接到makeruno A3
//只能接有~符號的，代表analog訊號
void setup() {
  pinMode(2, INPUT_PULLUP);
  pinMode(8, OUTPUT);
}

void loop() {
  int now = analogRead(A3);
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
