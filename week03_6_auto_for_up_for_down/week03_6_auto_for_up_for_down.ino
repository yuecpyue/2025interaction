//week03_6_auto_for_up_for_down
void setup() {
  for(int i=3;i<=13;i++){
    pinMode(i,OUTPUT);
  }
}

void loop() {
  for(int i=3;i<=13;i++){
    for(int j=3;j<=13;j++) digitalWrite(j,LOW);
    digitalWrite(i,HIGH);
    delay(200);
  }

  for(int i=13;i>=3;i--){
    for(int j=13;j>=3;j--) digitalWrite(j,LOW);
    digitalWrite(i,HIGH);
    delay(200);
  }
}
