import ddf.minim.*;
Minim minim;
AudioPlayer drumClap, drumFinish, drumNormal, normalFinish, normalNormal;
AudioPlayer softClap, softFinish, softWhistle, sliderSlide;
import processing.sound.*;
SoundFile backmusic;
float lowspeed=800,hitTime; 
float radius=40;
float goodhit=400,perfecthit=300;
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
void draw(){
  background(0);
  image(img,0,0,width,height);
  tint(255,128);
  fill(147,199,231); textSize(20);
  text(" combo ",0,1030);
  textSize(30);
  text(combo,25,1060);
  fill(255,0,0);
  rect(0,0,health*4,30);
  float t=millis();
  for(int i=0;i<dx.length;i++){
    if(!hit[i] && t>=s_T[i]){
      if(t-s_T[i]<lowspeed){
         float ratio=1-(t-s_T[i])/lowspeed;
         float CR=radius*(2+ratio*2);
         noFill(); stroke(200); strokeWeight(3); ellipse(dx[i]*3+100,dy[i]*2+30,CR,CR);
      }
      fill(255,255,255); noStroke(); ellipse(dx[i]*3+100,dy[i]*2+30,radius*2+10,radius*2+10);
      fill(60,160,255); noStroke(); ellipse(dx[i]*3+100,dy[i]*2+30,radius*2,radius*2);
      fill(0); noStroke(); text(N[i],dx[i]*3+100-7,dy[i]*2+30+9);
      if(t-s_T[i]>lowspeed){
         hit[i]=true; 
         println("miss");
         if(health>0) health-=10;
         if(health<0) health=0;
         combo=0;
      }
    }
  }
}
void Handhit(){
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
    if(mindt<=perfecthit){
       ardio(mc[index]);
       println("perfect");
       if(health<100) health+=5;
       combo++;
    }else if(mindt<=goodhit){
       ardio(mc[index]);
       println("good");
       if(health<100) health++;
       combo++;
    }else{
       println("miss");
       if(health>0) health-=10;
       if(health<0) health=0;
       combo=0;
    }
  }
}
void keyPressed(){
  if(key=='w'||key=='W'||key=='e'||key=='E') Handhit();
}
