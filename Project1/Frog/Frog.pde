
PImage background,frog,frog2,fly,eagle;
float frogX,frogY;
int[] xs = new int[]{120,208,355,600,980,1220,1160,970,290,80};
int[] ys = new int[]{90,327,280,64,115,125,595,720,730,610};
int index = 0;
ArrayList<Fly> flies = new ArrayList<Fly>();
boolean gameover = false;
boolean change = false;
void setup(){
  size(1280,800);
  background = loadImage("background.jpg");
  frog = loadImage("frog1.png");
  frog2 = loadImage("frog2.png");
  fly = loadImage("fly.png");
  eagle = loadImage("eagle.png");
  for(int i = 0;i<50;i++){
    flies.add(new Fly());
  }


}


void draw(){
   image(background,0,0,width,height);
   change = false;
  if(!gameover){
     frogX = xs[index];
  frogY = ys[index];
    push();
  imageMode(CENTER);
    for(Fly fly:flies){
    fly.update();
    fly.show();
  
  }
  if(change){
  image(frog2,frogX,frogY,100,100);
  }else{
  image(frog,frogX,frogY,100,100);
  }
  
   
  
    if(frameCount%100==0){
  if(index<xs.length-1){
  index++;
  }else{
  index=0;
  }
  }
  
  
  

  image(eagle,mouseX,mouseY,200,200);
   pop();
   float value = random(1);
   if(dist(mouseX,mouseY,frogX,frogY)<100&&value>0.3){
     index++;  
      }
   if(dist(mouseX,mouseY,frogX,frogY)<100&&value<0.3){
     gameover = true;  
      }
  
  }else{
  
    fill(158,10,10);
    textSize(100);
    text("OVER",480,height/2);
  
  }

 
}

class Fly{
  
  float x,y;
  float speedX,speedY;
  boolean dead;
  int count;
  
  Fly(){
    x = random(width);
    y = random(height);
    speedX = random(-5,5);
    speedY = random(-5,5);
  
  }
  
  void show(){
    if(!dead){
      image(fly,x,y,50,50);  
  if(dist(x,y,frogX,frogY)<100){
    noFill();
    stroke(220,76,64);
    strokeWeight(3);
    ellipse(x,y,100,100);
    line(x,y,frogX,frogY);
    count++;
    if(count>=10){
      dead = true;
      change = true;
    
    }
  
  }
    }

  }
  
  void update(){
    x+=speedX;
    y+=speedY;
    if(x<0||x>width){
      speedX*=-1;
    }
      if(y<0||y>height){
      speedY*=-1;
    }
  
  
  }


}
