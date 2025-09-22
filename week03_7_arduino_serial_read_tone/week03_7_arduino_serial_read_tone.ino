//week03_7_arduino_serial_read_tone
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);//設定USB傳輸速度
  pinMode(8,OUTPUT); 
}
void serialEvent(){//等USB事件
  while(Serial.available()){//有資料的話
    Serial.read();//讀資料
    tone(8,800,200);
  }
}
void loop() {
  // put your main code here, to run repeatedly:

}
