int[] lines;

void setup(){
  lines = new int[8];
  lines[0] = 60;
  lines[1] = 100;
  lines[2] = 40;
  lines[3] = 156;
  lines[4] = 80;
  lines[5] = 105;
  lines[6] = 90;
  lines[7] = 70;
  
  size(1000,800);
  background(0, 0, 0);
}

void draw(){
  clear();
  for(int i = 0; i<lines.length; i++){
    rect((width/16)*(i*2-1) + width/16+width/36, height-(height/16)-lines[i], width/16, lines[i]);
    textSize(15);
    text("Project:"+(i+1)+"\nTime of\nlearn:"+lines[i],
    (width/16)*(i*2-1)+width/16+width/36,
    height-(height/8)-(height/32)-lines[i]);
  }
}
