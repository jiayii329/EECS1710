color wowColor = color(130, 123, 5);
float circleSize = 100;

void setup() {
  size(800, 600, P2D);
  background(wowColor);
}

void draw() {
  if (mousePressed) {
    rectMode(CENTER);
    fill(255, 110, 0);
    stroke(50, 0, 0);
    line(mouseX, mouseY, mouseX, mouseY);
    ellipse(mouseX, mouseY, circleSize, circleSize/4);
  }
}
