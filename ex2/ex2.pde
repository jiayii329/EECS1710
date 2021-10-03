float x1 = 100, y1 = 380, s = 80, speed = 7;
PImage imgA, imgB, imgC;

void setup() {
  size(780,520);
  
  imgA = loadImage("beach.jpg");
  imgB = loadImage("sun.jpg");
  imgC = loadImage("carb.jpg");
  
}

void draw() {
  imageMode(CENTER);
  image(imgA, 390, 260, width, height);
  
  imageMode(CENTER);
  image(imgB, mouseX, mouseY, 80, 80);
  
  imageMode(CORNER);
  image(imgC, x1, y1, s, s);
  x1 += speed;
  
}
