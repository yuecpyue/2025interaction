float x=200,y=300,spawnTime=0,lowspeed=800,hitTime; 
float radius=30;
float goodhit=200,perfecthit=100;
float[] s_T={0,1000,1400,1800,2200,2600,3000,3400,3800,4200};
float[] dx={0,20,40,60,80,100,120,140,160,180};
float[] dy={0,20,40,60,80,100,120,140,160,180};
boolean[] hit=new boolean[10];
void setup(){
 size(800,600); 
}
void draw(){
  background(15);
  float t=millis();
  for(int i=0;i<10;i++){
    if(!hit[i] && t>=s_T[i]){
      if(t-s_T[i]<lowspeed){
         float ratio=1-(t-s_T[i])/lowspeed;
         float CR=radius*(2+ratio*2);
         noFill(); stroke(200); strokeWeight(3); ellipse(x+dx[i],y+dy[i],CR,CR);
      }
      fill(255,255,255); noStroke(); ellipse(x+dx[i],y+dy[i],radius*2+5,radius*2+5);
      fill(60,160,255); noStroke(); ellipse(x+dx[i],y+dy[i],radius*2,radius*2);
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
    }else if(dt<=goodhit){
       hit[index]=true;
       println("good");
    }else{
       hit[index]=true;
       println("miss");
    }
  }
}
void mousePressed(){
 Handhit(); 
}
