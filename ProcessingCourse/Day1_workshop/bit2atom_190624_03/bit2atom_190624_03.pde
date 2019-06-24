//mouseX, mouseY, pmouseX, pmouseY,
boolean invert = false;

int index = 0;

void setup() {
  size(600, 600);
  background(0);
}


void draw() {
  if (!invert) {
    index ++;
  }
  if (invert) {
    index --;
  }

  if (index >= 255) {
    invert = true;
  }
  if (index <= 0) {
    invert = false;
  }

  stroke(index);
  
  float dd = dist(pmouseX, pmouseY, mouseX, mouseY);
  if (dd > 0) {
    strokeWeight(dd/10);
  } else {
    strokeWeight(1);
  }
  
  line(pmouseX, pmouseY, mouseX, mouseY);
}
