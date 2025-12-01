import processing.serial.*;
Serial arduino;

ArrayList<Note> notes = new ArrayList<Note>();
float approachTime = 1200;
int combo = 0;
int score = 0;
float perfectWindow = 100;
float goodWindow = 200;

void setup() {
  size(800,600);
  println(Serial.list());
  arduino = new Serial(this, Serial.list()[0], 9600);
  arduino.bufferUntil('\n');

  // 範例譜面（單位 ms，相對於 startTime）
  int start = 0; // 等 2 秒後開始
  int[] dx={100,150,200,250,300};
  int[] dy={100,150,200,250,300};
  int[] times = {start+0, start+1000, start+2000, start+2700, start+3500};
  int c=0;
  for (int t : times) {
    notes.add(new Note(dx[c], dy[c], t, approachTime));
    c++;
  }
}

void draw() {
  background(15);
  fill(255); textSize(18);
  text("Score: "+score+"   Combo: "+combo, 100,30);

  for (int i = 0; i < notes.size(); i++) {
    Note n = notes.get(i);
    n.draw();
    // 若超過判定區間且沒被打 → MISS
    if (!n.hit && millis() > n.hitTime + goodWindow) {
      n.hit = true;
      n.result = "MISS";
      combo = 0;
    }
  }
}

void serialEvent(Serial s) {
  String in = s.readStringUntil('\n');
  if (in != null) {
    in = in.trim();
    if (in.equals("Z") || in.equals("X")) handleHit(in);
  }
}

void mousePressed() { handleHit("MOUSE"); }

void handleHit(String key) {
  // 找下一個尚未被打的 note（最靠前）
  for (Note n : notes) {
    if (!n.hit) {
      float dt = abs(millis() - n.hitTime);
      if (dt <= perfectWindow) {
        n.hit = true; n.result = "PERFECT"; score += 300; combo++; return;
      } else if (dt <= goodWindow) {
        n.hit = true; n.result = "GOOD"; score += 100; combo++; return;
      } else {
        // 早按或晚按：視為 MISS（可選擇不馬上設 MISS）
        n.hit = true; n.result = "MISS"; combo = 0; return;
      }
    }
  }
}

class Note {
  float x,y,spawnTime,approach,hitTime;
  boolean hit=false;
  String result="";
  float radius = 30;
  float resultStartTime = -1;
  float resultDuration=1000;
  Note(float x_, float y_, float spawn_, float approach_) { x=x_; y=y_; spawnTime=spawn_; approach=approach_; hitTime=spawnTime+approach; }
  void draw() {
    float t = millis()-spawnTime;
    if (t < approach) {
      float ratio = 1 - t/approach;
      float R = radius * (2 + ratio*2);
      noFill(); stroke(200); strokeWeight(4); ellipse(x,y,R,R);
    }
    if (!hit && millis() >= spawnTime) {
      fill(255,255,255); noStroke(); ellipse(x,y,radius*2+5,radius*2+5);
      fill(60,160,255); noStroke(); ellipse(x,y,radius*2,radius*2);
    }
    if (result.length() > 0) {
      if (resultStartTime == -1) { // 設置顯示開始時間
        resultStartTime = millis();
      }
      
      // 如果顯示時間過了 1 秒鐘，則不再顯示文字
      if (millis() - resultStartTime <= resultDuration) {
        fill(255);
        textSize(20);
        text(result, x, y - 80);
      } else {
        result = ""; // 結果顯示過後清空
      }
    }
  }
}
