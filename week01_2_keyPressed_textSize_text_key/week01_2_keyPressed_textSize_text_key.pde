//week01_2_keyPressed_textSize_text_key
void setup(){
  size(500,500); 
}
void draw(){
 if(keyPressed){//小心輸入法
   background(#FF0000);
   textSize(100);//改字型大小
   text(""+key,width/2,height/2);
   fill(0,0,255);
 }
}
