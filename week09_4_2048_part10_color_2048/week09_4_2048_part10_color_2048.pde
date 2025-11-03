//week09_4_2048_part10_color_2048
//改自week09_3_2048_part9_ketPressed_keyCode_UP_merge
//新增剩餘色彩，從week08_4就已新增好
color [] c ={#CEC2B9,#EFE5DA,#EDE1CA,#EFB37E,#F69462,#EF7F63,#F76543,#EDCF73,#EDCC62,#EDC850,#EDC53F,#EDC22D};//2的1,2,3,4,5次方
color [] c2={#776E66,#776E66,#776E66,#FDF8F5,#FDF8F5,#FDF8F5,#FDF8F5,#FDF8F5,#FDF8F5,#FDF8F5,#FDF8F5,#FDF8F5};//文字顏色
int [] N={0,2,4,8,16,32,64,128,256,512,1024,2048};//對應的數字
int [][] B={ {0,0,0,0}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0} };//板子
void keyPressed(){
  if(keyCode==RIGHT){
     for(int i=0;i<4;i++){
       int now=3;
       for(int j=3;j>=0;j--){//從右往左找
          if(B[i][j]>0){//找到有板子
              B[i][now]=B[i][j];
              while(now<3 && B[i][now+1]==B[i][now]){
                 B[i][now+1]++;//編號變大，就新的板子出現
                 now++;
              }
              now--;
          }
       }//到這裡結束時，now的左邊不要放東西，都歸零
       for(int j=now;j>=0;j--){//剩下的放零
          B[i][j]=0; 
       }
     }
  }else if(keyCode==LEFT){
     for(int i=0;i<4;i++){
       int now=0;
       for(int j=0;j<4;j++){//從左往右找
          if(B[i][j]>0){//找到有板子
              B[i][now]=B[i][j];
              while(now>0 && B[i][now-1]==B[i][now]){
                 B[i][now-1]++;//編號變大，就新的板子出現
                 now--;
              }
              now++;
          }
       }//到這裡結束時，now的右邊不要放東西，都歸零
       for(int j=now;j<4;j++){//剩下的放零
          B[i][j]=0; 
       }
     }
  }else if(keyCode==UP){
    for(int j=0;j<4;j++){
       int now=0;
       for(int i=0;i<4;i++){
          if(B[i][j]>0){
              B[now][j]=B[i][j];
              while(now>0 && B[now-1][j]==B[now][j]){
                 B[now-1][j]++;
                 now--;
              }
              now++;
          }
       }
       for(int i=now;i<4;i++){//剩下的放零
          B[i][j]=0; 
       }
     }
  }else if(keyCode==DOWN){
    for(int j=0;j<4;j++){
       int now=3;
       for(int i=3;i>=0;i--){
         if(B[i][j]>0){
           B[now][j]=B[i][j];
           while(now<3&&B[now+1][j]==B[now][j]){
             B[now+1][j]++;
             now++;
           }
           now--;
         }
       }
       for(int i=now;i>=0;i--){
         B[i][j]=0;
       }
    }
  }
  genTwo();
}
void genTwo(){
   int zero=0;
   for(int i=0;i<4;i++){
    for(int j=0;j<4;j++){
       if(B[i][j]==0) zero++; 
    }
   }
   //用亂數決定哪格放2
   int ans=int(random(zero));//看如果有十格，找到0~9格
   for(int i=0;i<4;i++){
     for(int j=0;j<4;j++){
        if(B[i][j]==0){
          if(ans==0){
            B[i][j]=1;//變成1，就是2的1次方
            return;
          }
          else ans--;//用掉一個要--
        }
     }
   }
}
void setup(){
  size(410,410);
}
void draw(){
  background(188,174,162);
  for(int i=0;i<4;i++){
    for(int j=0;j<4;j++){
       int id=B[i][j];
       fill(c[id]);
       noStroke();
       rect(j*100+10,i*100+10,90,90,5);
       fill(c2[id]);
       textAlign(CENTER, CENTER);//文字置中
       textSize(40);
       text(N[id],j*100+55,i*100+55);//增加文字在板子中間
    }
  }
}
