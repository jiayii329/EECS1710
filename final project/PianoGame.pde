 import ddf.minim.*;
 

Minim minim;
AudioPlayer sou_,dou,re,mi,fa,sou,la,si,boom,music;
PFont title;
PImage background,start_background,symbol1,symbol2,symbol3,symbol4,number0,number1,number2,number3,number4,number5,number6,number7;

int Mode = 1;

ArrayList<Piece> symbolList = new ArrayList<Piece>();
ArrayList<Piece> numberList = new ArrayList<Piece>();
int[] song = new int[]{1,2,3,1,1,2,3,1,3,4,5,3,4,5,5,6,5,4,3,1,5,6,5,4,3,1,2,0,1,2,0,1};
String currentNumber = "-1";
boolean start_flag;
int hit = 0;
float dampLow = 0.65;
float dampHigh = 0.9;
float wallDamp = 0.99;

int maxVel = 100;
int maxGroundTime = 300;
int[] scale = {0, 2, 3, 7, 14, 15 }; 
 
int scaleOct = 4;
float windModeH = 4;
float windModeV = 0.2 * 1.3;

boolean applyWind = true; 
boolean play,record;
int index = 0; 
PVector gravity, wind, acc;
color c;

float t = 0;
int chordIndex = 0;
int musicCount = 24;
int indexCount = 0;
String state = "waiting";
boolean isPiano = true;
ArrayList<Music> musics = new ArrayList<Music>();
ArrayList<Ball> balls;
AudioPlayer[] players1;
void setup(){
  size(600,968);
  frameRate(60);
    symbolList = new ArrayList<Piece>();
  numberList = new ArrayList<Piece>();
 musics = new ArrayList<Music>();
  start_flag = false;
  background = loadImage("image/background.jpg");
  start_background = loadImage("image/start_background2.jpg");
  
       //字体加载
  title = createFont("fonts/font.TTF",40);
  textFont(title);
  
  //音乐加载
    minim =  new Minim(this);
    sou_ = minim.loadFile("audio/0.mp3");
    dou = minim.loadFile("audio/1.mp3");
    re = minim.loadFile("audio/2.mp3");
    mi = minim.loadFile("audio/3.mp3");
    fa = minim.loadFile("audio/4.mp3");
    sou = minim.loadFile("audio/5.mp3");
    la = minim.loadFile("audio/6.mp3");
    si = minim.loadFile("audio/7.mp3");
    boom = minim.loadFile("audio/boom.mp3");
 
  
    
    

    //音符加载
    symbol1 = loadImage("image/symbol1.png");
    symbol2 = loadImage("image/symbol2.png");
    symbol3 = loadImage("image/symbol3.png");
    symbol4 = loadImage("image/symbol4.png");
    number0 = loadImage("image/0.png");
    number1 = loadImage("image/1.png");
    number2 = loadImage("image/2.png");
    number3 = loadImage("image/3.png");
    number4 = loadImage("image/4.png");
    number5 = loadImage("image/5.png");
    number6 = loadImage("image/6.png");
    number7 = loadImage("image/7.png");
    

    //随机生成运动的音符
    symbolList.add(new Piece("symbol1",new PVector(random(0.2, 0.8)*width,random(0.2, 0.8)*height),random(0.5,1)));
    symbolList.add(new Piece("symbol1",new PVector(random(0.2, 0.8)*width,random(0.2, 0.8)*height),random(0.5,1)));
    symbolList.add(new Piece("symbol2",new PVector(random(0.2, 0.8)*width,random(0.2, 0.8)*height),random(0.5,1)));
    symbolList.add(new Piece("symbol2",new PVector(random(0.2, 0.8)*width,random(0.2, 0.8)*height),random(0.5,1)));
    symbolList.add(new Piece("symbol3",new PVector(random(0.2, 0.8)*width,random(0.2, 0.8)*height),random(0.5,1)));
    symbolList.add(new Piece("symbol3",new PVector(random(0.2, 0.8)*width,random(0.2, 0.8)*height),random(0.5,1)));
    symbolList.add(new Piece("symbol4",new PVector(random(0.2, 0.8)*width,random(0.2, 0.8)*height),random(0.5,1)));
    symbolList.add(new Piece("symbol4",new PVector(random(0.2, 0.8)*width,random(0.2, 0.8)*height),random(0.5,1)));
    
    //生成数字音符
    for(int i = 0;i<song.length;i++){ 
        numberList.add(new Piece(song[i]+"",new PVector(280,100-i*200),1));
    }
    
   players1 = new AudioPlayer[musicCount];
 
  for(int i = 0;i<musicCount;i++){
    players1[i] = minim.loadFile(i+".mp3");   
  }
 
  gravity = new PVector(0, 0.2);
  wind = new PVector(random(-0.1, 0.1), 0);
 

  balls = new ArrayList<Ball>();

}

void draw(){
  
  if(start_flag){
   
    if(Mode==1){
    Mode1();
    }else{
    Mode2();
    }
  
  }else{
  showStart();
  
  }
 
}

void Mode2(){
  background(255);
  if(record){
  //if (random(0, 1) < (0.1 / frameRate)) changeChord();

  float noiseX = map(noise(t * 0.5), 0, 1, -windModeH, windModeH);
  float noiseY = map(noise(t + 1), 0, 1, -windModeV, windModeV);
  wind = new PVector(noiseX, noiseY);
  pushMatrix();

  colorMode(HSB);
  fill(150, 180, 180, map(abs(noiseX), 0, windModeH, 0, 180));
  noStroke();
  rect(width/2, 20, map(wind.x, -windModeH, windModeH, -width / 2, width / 2), 10);
  fill(150, 180, 180, map(abs(noiseY), -windModeV, windModeV, 0, 180));
  rect(20, height /2, 10, map(wind.y, -windModeV, windModeV, -height / 2, height / 2));

  popMatrix();
  if (balls.size() > 0) {
    for (int i = 0; i < balls.size(); i++) {

      Ball ball = balls.get(i);
      ball.applyForce(gravity);
      if (applyWind)
        ball.applyForceWeighted(wind);

      if (ball.update()) {
        ball.show();
      } else {
        balls.remove(i);
        i = 1 - 1;
       
      }
    }
  }
  t += 0.01 * 0.5;
 
  }

  
  
  //fill(158,10,10);
  textSize(15);
  text("press r to record,p to play:"+state,50,50);
  
  if(play){
     int gap = (int)((musics.get(indexCount+1).time-musics.get(indexCount).time)*1.0/1000*30);
     if(gap<=0){
     gap=1;
     }
    if(indexCount<musics.size()-2){
     players1[musics.get(indexCount+1).number].play();
       players1[index].shiftGain(players1[index].getGain(),-20,gap*100);
      players1[musics.get(indexCount+1).number].rewind();
     println(indexCount);
     fill(random(255),random(255),random(255));
     float r = random(50,100);
     ellipse(random(width),random(height),r,r);
    }
      if(frameCount%gap == 0&&indexCount<musics.size()-2){
        indexCount++;
      
      }
  
  }
}

void showStart(){
  background(start_background);
  textSize(40);
   fill(255);
    text("Piano Game",100,350);
    
    textSize(20);
    //fill(158,10,10);
    text("Mode1:     PIANO(E)",100,500);
     //fill(255);
    text("Mode2:Music Ball(D)",100,550);
 
    
      fill(255,205,67);
      textSize(20);
    text("Press s to Restart",100,680);
  
}

void Mode1(){
  
  //主界面
  //currentNumber = "-1";
  background(background);
  textSize(20);
  text("HIT:"+hit,50,50);
 

  //更新随机运动的音符
  for(Piece piece:symbolList){
  
    switch(piece.getName()){
      case "symbol1":image(symbol1,piece.getVector().x,piece.getVector().y,65,65);break;
      case "symbol2":image(symbol2,piece.getVector().x,piece.getVector().y,65,65);break;
      case "symbol3":image(symbol3,piece.getVector().x,piece.getVector().y,65,65);break;
      case "symbol4":image(symbol4,piece.getVector().x,piece.getVector().y,65,100);break;


    }
         piece.setVector(new PVector(piece.getVector().x+piece.getDivX(),piece.getVector().y+piece.getDivY()));
      //边界检测
      if((piece.getVector().x+piece.getDivX())<0 || piece.getVector().x+piece.getDivX()>width){
        piece.setDivX(-1*piece.getDivX()); 

      }
        if((piece.getVector().y+piece.getDivY())<0 || piece.getVector().y+piece.getDivY()>width){
        piece.setDivY(-1*piece.getDivY()); 

      }


  }

    //更新下落的音符
  for(Piece piece:numberList){
  
  if(piece.getVector().y<690){
      switch(piece.getName()){
      case "0":image(number0,piece.getVector().x,piece.getVector().y,65,65);break;
      case "1":image(number1,piece.getVector().x,piece.getVector().y,65,65);break;
      case "2":image(number2,piece.getVector().x,piece.getVector().y,65,65);break;
      case "3":image(number3,piece.getVector().x,piece.getVector().y,65,100);break;
      case "4":image(number4,piece.getVector().x,piece.getVector().y,65,100);break;
      case "5":image(number5,piece.getVector().x,piece.getVector().y,65,100);break;
      case "6":image(number6,piece.getVector().x,piece.getVector().y,65,100);break;
      case "7":image(number7,piece.getVector().x,piece.getVector().y,65,100);break;
    }
    if(piece.getVector().y>580&&piece.getVector().y<730){
      currentNumber = piece.getName();
      //println(currentNumber);
    
    }
  piece.setVector(new PVector(piece.getVector().x,piece.getVector().y+1));
   
  }
      


  }
 
}

void keyPressed(){
  if(start_flag){
    switch(keyCode){
  case '0':
  if(currentNumber.equals("0")){
  sou_.play();hit++;
  sou_.rewind();}else{boom();}
  break;
    case '1':
    if(currentNumber.equals("1")){
  dou.play();hit++;
  dou.rewind();}else{boom();}break;
    case '2':
    if(currentNumber.equals("2")){
  re.play();hit++;
  re.rewind();}else{boom();}break;
    case '3':
    if(currentNumber.equals("3")){
  mi.play();hit++;
  mi.rewind();}else{boom();}break;
    case '4':
    if(currentNumber.equals("4")){
  fa.play();hit++;
  fa.rewind();}else{boom();}break;
    case '5':
    if(currentNumber.equals("5")){
  sou.play();hit++;
  sou.rewind();}else{boom();}break;
    case '6':
    if(currentNumber.equals("6")){
  la.play();hit++;
  la.rewind();}else{boom();}break;
    case '7':
    if(currentNumber.equals("7")){
  si.play();hit++;
  si.rewind();}else{boom();}break; 

} 
   if (key == 's') {
 setup();
 }
  }else{
      
    switch(keyCode){
  
  case 'E': Mode = 1;start_flag=true;break;
  case 'D': Mode = 2;start_flag=true;break;
   

  
  }}

if(Mode==2){
 if (key == ' ') {
 isPiano = !isPiano;
 }
  if (key == 's') {
 setup();
 }
  
  
  if (key == 'r') {
    state = "recording";
    record = true;
    play = false;
    musics.clear();
    indexCount = 0;
     
  }
   if (key == 'p') {
       for(int i = 0;i<musicCount;i++){
    players1[i].setGain(0); 
  }
     state = "playing";
       record = false;
    play = true;
    indexCount = 0;
    balls.clear();
  }
}

}
void boom(){
  boom.play();
  boom.rewind();
}

void mousePressed() {
  if(record){
   balls.add(new Ball());
  }
 
 
}

 
class Music{
  int number;
  int time;
  Music(int number, int time){
    this.number = number;
    this.time = time;
  
  }


}
 
