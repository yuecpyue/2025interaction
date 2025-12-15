float lowspeed=1416,hitTime; 
float radius=30;
float goodhit=200,perfecthit=100;
float[] s_T;
float[] dx;
float[] dy;
int health=100,combo=0;
boolean[] hit;
void setup(){
 size(512*2,384*2);
 loadData("music_circle.txt");
}
void loadData(String s){
  String[] circle=loadStrings(s);
  if(circle!=null){
    int num=circle.length;
    dx=new float[num];
    dy=new float[num];
    s_T=new float[num];
    hit=new boolean[num];
    for(int i=0;i<num;i++){
       String line=circle[i].trim();
       String[] oneline=split(line,',');
       if(oneline.length>=3){
          dx[i]=float(oneline[0].trim()); 
          dy[i]=float(oneline[1].trim());
          s_T[i]=float(oneline[2].trim());
       }
    }
  }
}
void draw(){
  background(15);
  fill(147,199,231); textSize(20);
  text(" combo ",0,363*2);
  textSize(30);
  text(combo,25,380*2);
  fill(255,0,0);
  rect(0,0,health*4,30);
  float t=millis();
  for(int i=0;i<dx.length;i++){
    if(!hit[i] && t>=s_T[i]){
      if(t-s_T[i]<lowspeed){
         float ratio=1-(t-s_T[i])/lowspeed;
         float CR=radius*(2+ratio*2);
         noFill(); stroke(200); strokeWeight(3); ellipse(dx[i]*2,dy[i]*2,CR,CR);
      }
      fill(255,255,255); noStroke(); ellipse(dx[i]*2,dy[i]*2,radius*2+6,radius*2+6);
      fill(60,160,255); noStroke(); ellipse(dx[i]*2,dy[i]*2,radius*2,radius*2);
      //add
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
  for(int i=0;i<dx.length;i++){
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
       if(health<100) health+=5;
       combo++;
    }else if(dt<=goodhit){
       hit[index]=true;
       println("good");
       if(health<100) health++;
       combo++;
    }else{
       hit[index]=true;
       println("miss");
       if(health>0) health-=10;
       if(health<0) health=0;
       combo=0;
    }
  }
}
void mousePressed(){
 Handhit(); 
}
