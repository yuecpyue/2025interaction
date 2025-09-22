//week03_5_pin2_BUTTON_digitalRead_digitalWrite
void setup() {
  pinMode(2,INPUT_PULLUP);//按鈕Button預設是2號，按下拉高
  for(int i=3;i<=13;i++){
    pinMode(i,OUTPUT);//讓3~13都可以發光
  }
}
int now=3;
void loop() {
  if(digitalRead(2)==LOW){//按下去
    now++;
    if(now>13) now==3;
    for(int i=3;i<=13;i++){
      digitalWrite(i,LOW);//全部先不亮
    }
    digitalWrite(now,HIGH);//now負責亮
    delay(500); 
  }
}
