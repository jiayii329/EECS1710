PImage background,snowman,happy,unhappy,cloud0,cloud1,cloud2,cloud3,cloud4;
ArrayList<Cloud> clouds = new ArrayList<Cloud>();
int[] x = new int[]{70,300,580,540,670,780,980,1200};
int[] y = new int[]{280,480,180,380,680,380,380,580};
float posX,posY,speedX,speedY,distance,dis;
boolean run,reach;
int index = 1;
int count=0;
boolean runEnd;
boolean gameover,win;
void setup(){
  size(1280,720);
  background = loadImage("background.jpg");
  snowman = loadImage("snowman.png");
  happy = loadImage("happy.png");
  unhappy = loadImage("unhappy.png");
  cloud0 = loadImage("cloud0.png");
  cloud1 = loadImage("cloud1.png");
  cloud2 = loadImage("cloud2.png");
  cloud3 = loadImage("cloud3.png");
  cloud4 = loadImage("cloud4.png");
  clouds.add( new Cloud(cloud0,x[0],y[0],192,92));
  clouds.add( new Cloud(cloud1,x[1],y[1],192,92));
  clouds.add( new Cloud(cloud2,x[2],y[2],100,45));
  clouds.add( new Cloud(cloud2,x[3],y[3],100,45));
  clouds.add( new Cloud(cloud2,x[4],y[4],150,60));
  clouds.add( new Cloud(cloud3,x[5],y[5],192,92));
  clouds.add( new Cloud(cloud3,x[6],y[6],192,92));
  clouds.add( new Cloud(cloud4,x[7],y[7],160,70));
  posX = 70;
  posY = 250;
  
  
  
}

void draw(){
  image(background,0,0,width,height);
  
  if(!gameover){
    push();
  imageMode(CENTER);
    for(Cloud cloud:clouds){
    cloud.show();  
  }
  image(snowman,posX,posY,100,100);
  pop();
  fill(158,10,10);
  rect(100,50,count,10);
  fill(158,10,10);
  textSize(20);
  text("Press the mouse to control the distance",200,50);
  }else{
    if(win){
      textSize(100);
      fill(255,0,0);
      text("WIN",width/3,height/2);
       image(happy,480,395,200,100);
    
    }else{
     textSize(100);
      fill(255,0,0);
      text("FAILED",width/3,height/2);
      image(unhappy,480,395,200,100);
    }
  }
  
  
  

  
  if(mousePressed){
    count+=3;
    //println(count);
  
  } 
  if(run){
   
   
    posX+=speedX;
    posY+=speedY;
    println( dist(posX,posY,x[index],y[index]-30));
     if(reach &&  dist(posX,posY,x[index],y[index]-30)<50){
      posX = x[index];
      posY = y[index]-30;
      run = false;
      index++;
      if(index==8){
        win = true;
        gameover = true;
      
      }
    }
    if(!reach){
      if(distance<dis){
         posX+=speedX;
         posY+=speedY*5;
            if(posY>height||posY<0){
         gameover = true;
         }
      }else{
      posX+=speedX*5;
         posY+=speedY;
         if(posY>height||posY<0){
         gameover = true;
         }
      }
    
    }
   
  
  }
   
}

void mouseReleased(){
  run = true;
  dis = dist(posX,posY,x[index],y[index]-30);
     speedX = (x[index]-posX)/dis*3;
    speedY = (y[index]-posY)/dis*3;
    run = true;  
    distance = count;
     println(count,dis);
    count=0;
      if(abs(distance-dis)<100){
    reach = true;
    }else{
    reach = false;
    win = false;
    }
    println(reach);
    
   

}

class Cloud{
  int x,y;
  PImage image;
  int w,h;
  Cloud(PImage image,int x, int y,int w,int h){
    this.x =x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.image = image;     
  }
  
  void show(){
   image(image,x,y,w,h);
  }

}
