float x=width/2,y=height/2,spawnTime=0,lowspeed=1000; 
float radius=30;
boolean hit=false;
void setup(){
 size(800,600); 
}
void draw(){
  background(15);
  float t=millis();
  if(t<lowspeed){
     float ratio=1-t/lowspeed;
     float CR=radius*(2+ratio*2);
     noFill(); stroke(200); strokeWeight(4); ellipse(x,y,CR,CR);
  }
  if (!hit && millis() >= spawnTime) {
     fill(255,255,255); noStroke(); ellipse(x,y,radius*2+8,radius*2+8);
     fill(60,160,255); noStroke(); ellipse(x,y,radius*2,radius*2);
   }
}
