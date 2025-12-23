import ddf.minim.*;
Minim minim;
AudioPlayer drumClap, drumFinish, drumNormal, normalFinish, normalNormal;
AudioPlayer softClap, softFinish, softWhistle, sliderSlide;
import processing.sound.*;
SoundFile backmusic;
float lowspeed=800,hitTime; 
float radius=40;
float goodhit=350,perfecthit=250;
float[] s_T,dx,dy;
int[] N,mc;
int health=100,combo=0;
boolean[] hit;
boolean start=true;
PImage img;
void setup(){
 size(1920,1080);
 loadData("music_circle.txt");
 img=loadImage("background.png");
 backmusic=new SoundFile(this,"audio.mp3");
 backmusic.play();
 minim=new Minim(this);
 loadardio();
}
void loadData(String s){
  String[] circle=loadStrings(s);
  if(circle!=null){
    int num=circle.length;
    println(num);
    dx=new float[num];
    dy=new float[num];
    s_T=new float[num];
    hit=new boolean[num];
    N=new int[num];
    mc=new int[num];
    for(int i=0;i<num;i++){
       String line=circle[i].trim();
       String[] oneline=split(line,',');
       if(oneline.length>=5){
          dx[i]=float(oneline[0].trim()); 
          dy[i]=float(oneline[1].trim());
          s_T[i]=float(oneline[2].trim());
          N[i]=int(oneline[3].trim());
          mc[i]=int(oneline[4].trim());
       }
    }
  }
}
void loadardio(){
  drumNormal = minim.loadFile("drum-hitnormal.wav");
  normalFinish = minim.loadFile("normal-hitfinish.wav");
  normalNormal = minim.loadFile("normal-hitnormal.wav");
  softClap = minim.loadFile("soft-hitclap.wav");
  softFinish = minim.loadFile("soft-hitfinish.wav");
  softWhistle = minim.loadFile("soft-hitwhistle.wav");
}
void ardio(int i){
    if(i==0) return;
    if(i==3){
      drumNormal.rewind();
      drumNormal.play();
    }
    if(i==4){
      normalFinish.rewind();
      normalFinish.play();
    }
    if(i==5){
      normalNormal.rewind();
      normalNormal.play();
    }
    if(i==6){
      softClap.rewind();
      softClap.play();
    }
    if(i==7){
      softFinish.rewind();
      softFinish.play();
    }
    if(i==8){
      softWhistle.rewind();
      softWhistle.play();
    }
    if(i==68){
      softClap.rewind();
      softWhistle.rewind();
      softClap.play();
      softWhistle.play();
    }
    if(i==48){
      normalFinish.rewind();
      softWhistle.rewind();
      normalFinish.play();
      softWhistle.play();
    }
    if(i==37){
      drumNormal.rewind();
      softFinish.rewind();
      drumNormal.play();
      softFinish.play();
    }
    if(i==468){
      normalFinish.rewind();
      softClap.rewind();
      softWhistle.rewind();
      normalFinish.play();
      softClap.play();
      softWhistle.play();
    }
}
float x,y;
float avg;
void draw(){
  background(0);
  image(img,0,0,width,height);
  tint(255,128);
  fill(147,199,231); textSize(20);
  text(" combo ",50,950);
  textSize(30);
  text(combo,50,980);
  fill(255,0,0);
  rect(0,0,health*4,30);
  float t=millis();
  if(start){
    for(int i=dx.length-1;i>=0;i--){
      if(!hit[i] && t>=s_T[i]){
        x=dx[i]*1.5+500;
        y=dy[i]*1.5+300;
        if(t-s_T[i]<lowspeed){
           float ratio=1-(t-s_T[i])/lowspeed;
           float CR=radius*(2+ratio*2);
           noFill(); stroke(200); strokeWeight(3); ellipse(x,y,CR,CR);
        }
        fill(255,255,255); noStroke(); ellipse(x,y,radius*2+10,radius*2+10);
        fill(60,160,255); noStroke(); ellipse(x,y,radius*2,radius*2);
        fill(0); noStroke(); textAlign(CENTER); text(N[i],x,y+6);
        
        if(t-s_T[i]>lowspeed){
           hit[i]=true; 
           result="miss";
           miss++;
           if(health>0) health-=10;
           if(health<0) health=0;
           combo=0;
        }
      }
    }
  }
  if(start){
     boolean check=true;
     for(int i=0;i<dx.length;i++){
        if(!hit[i]){
           check=false;
           break;
        }
     }
     if(health<=0){
        start=false;
        backmusic.stop();
     }
     if(check) start=false;
  }
  if(!start){
    textSize(50);
    String end="";
    if(health>0) end="Congratulations";
    else end="Game Over";
    if(end=="Congratulations") fill(#FFF303);
    text(end,960,540);
    textSize(50);
    fill(255);
    text("Final combo:"+combo,960,600);
    text("accuracy:"+nf(avg,1,1)+ "%", 960,660);
  }
  if (resultStartTime > 0) {
    float elapsed = millis() - resultStartTime;
    float duration = 300; // 顯示 900 毫秒

    if (elapsed < duration) {
      textSize(20); 
      textAlign(CENTER);
      fill(255);
      text(result,rx,ry);
    } else {
      // 超過時間，清除結果
      resultStartTime = 0; 
      result = "";
    }
    textAlign(LEFT); // 恢復預設對齊
  }
  float total=perfect+ok+miss;
  avg=(perfect+ok)/total*100;
  fill(255); // 白色文字
  textSize(20);
  textAlign(CENTER);
  text("accuracy:"+nf(avg,1,1)+ "%", width-100, 50);
}
String result="";
float rx,ry,resultStartTime=0;
int perfect=0,ok=0,miss=0;
void Handhit(){
  if(!start) return;
  result="";
  int index=0;
  float mindt=goodhit+1;
  for(int i=0;i<dx.length;i++){
     if(!hit[i] && millis()>=s_T[i]){
         hitTime=s_T[i]+lowspeed;
         float dt=abs(millis()-hitTime);
         if(dt<=goodhit && dt<mindt){
            mindt=dt;
            index=i;
         }
     }
  }
  if(index>=0){
    hit[index]=true;
    resultStartTime=millis();
    rx=x;
    ry=y;
    if(mindt<=perfecthit){
       ardio(mc[index]);
       result="PERFECT";
       perfect++;
       if(health<100) health+=30;
       combo++;
    }else if(mindt<=goodhit){
       ardio(mc[index]);
       result="OK";
       ok++;
       if(health<100) health+=10;
       combo++;
    }else{
       result="MISS";
       miss++;
       if(health>0) health-=10;
       if(health<0) health=0;
       combo=0;
    }
  }
}
void keyPressed(){
  if(key=='w'||key=='W'||key=='e'||key=='E') Handhit();
}
