float scaleAmp = 1000;
float scaleFreq = 1000;
PImage imgA;

void setup() {
  size(800, 600, P2D);  
  setupSound();
  imgA = loadImage("quanji.jpg");
}

void draw() {
  background(127);
  imageMode(CORNER);
  image(imgA, 0, 0, width, height);
  updateSound();
  
  println("amp: " + amp + " freq: " + freq);

  rectMode(CENTER);
  float fillValR = constrain(map(freq, 0, scaleFreq, 0, 255), 0, scaleFreq);
  float fillValG = constrain(map(freq, 0, scaleFreq, 0, 127), 0, scaleFreq);
  float fillValB = constrain(map(freq, 0, scaleFreq, 0, 63), 0, scaleFreq);
  fill(fillValR, fillValG, fillValB);
  rect(width - (amp * scaleAmp), height*1/4, 250, amp * scaleAmp);

}
