float rotSeconds = 0;
float rotMinutes = 0;
float rotHours = 0;
int lastSecond = 0;
int lastMinute = 0;
int lastHour = 0;
 
float faceSize = 500;
float lengthSecondHand = 180;
float lengthMinuteHand = 100;
float lengthHourHand = 220;
 
color outlineCol = color(122, 189, 115);
color secondCol = color(220, 122, 122);
color faceCol = color(115, 115, 189);


void setup() {
  size(800, 600, P2D);
  strokeWeight(2);

}
 
void draw() {
  
  int s = second();
  int m = minute();
  int h = hour();
  
  if(s != lastSecond){
    rotSeconds = ((float) s / 60) * TWO_PI;
    lastSecond = s;
  }
  
  if(s != lastMinute){
      rotMinutes = ((float) h / 60) * TWO_PI;
      lastMinute = m;
  }
  if(s != lastHour){
      rotHours = ((float) s / 12) * TWO_PI;
      println(h);
      lastHour = h;
  }
  
  fill(faceCol);
  stroke(outlineCol);
  ellipse(width/2, height/2, faceSize, faceSize);
  
  stroke(0, 127, 255, 44);
  for(int i=0; i<12; i++) {
    float rot = ((float) i/12) * TWO_PI;
    pushMatrix();
    translate(width/2, height/2);
    rotate(rot);
    line(0, faceSize/5, 0, faceSize/2);
    popMatrix();
  }
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(rotSeconds);
  fill(secondCol);
  stroke(secondCol);
  line(0, 0, 0, -lengthSecondHand);
  ellipse(0, -lengthSecondHand, 50, 50);
  popMatrix();
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(rotMinutes);
  fill(0);
  stroke(outlineCol);
  line(0, 0, 0, -lengthMinuteHand);
  ellipse(0, -lengthMinuteHand, 50, 50);
  popMatrix();
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(rotHours);
  line(0, 0, 0, -lengthSecondHand);
  ellipse(0, -lengthHourHand, 50, 50);
  popMatrix();
  
  fill(faceCol);
  ellipse(width/2, height/2, 50, 50);
}
