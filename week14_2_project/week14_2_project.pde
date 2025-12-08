float x=200,y=300,lowspeed=1200,hitTime; 
float radius=30;
float goodhit=200,perfecthit=100;
float[] s_T={0,1000,1400,1800,2200,2600,3000,3400,3800,4200};
float[] dx={0,20,60,100,140,180,220,260,300,340};
float[] dy={0,20,40,60,80,100,120,140,160,180};
int health=100,combo=0;
boolean[] hit=new boolean[10];
void setup(){
 size(800,600);
}
void draw(){
  background(15);
  fill(147,199,231); textSize(18);
  text(" combo: ",0,550);
  textSize(30);
  text(combo,20,580);
  fill(255,0,0);
  rect(0,0,health*4,30);
  float t=millis();
  for(int i=0;i<10;i++){
    if(!hit[i] && t>=s_T[i]){
      if(t-s_T[i]<lowspeed){
         float ratio=1-(t-s_T[i])/lowspeed;
         float CR=radius*(2+ratio*2);
         noFill(); stroke(200); strokeWeight(3); ellipse(x+dx[i],y+dy[i],CR,CR);
      }
      fill(255,255,255); noStroke(); ellipse(x+dx[i],y+dy[i],radius*2+6,radius*2+6);
      fill(60,160,255); noStroke(); ellipse(x+dx[i],y+dy[i],radius*2,radius*2);
      //add
      if(t-s_T[i]>lowspeed){
         hit[i]=true; 
         println("miss");
         health-=10;
         combo=0;
      }
    }
  }
}
void Handhit(){
  int index=0;
  for(int i=0;i<10;i++){
     if(!hit[i] && millis()>=s_T[i]){
         index=i;
         break;
     }
  }
  if(index>=0){
    hitTime=s_T[index]+lowspeed;
    float dt=abs(millis()-hitTime);
    if(dt<=perfecthit){
       hit[index]=true;
       println("perfect");
       health++;
       if(health>100) health=100;
       combo++;
    }else if(dt<=goodhit){
       hit[index]=true;
       println("good");
       health--;
       combo++;
    }else{
       hit[index]=true;
       println("miss");
       health-=10;
       combo=0;
    }
  }
}
void mousePressed(){
 Handhit(); 
}
