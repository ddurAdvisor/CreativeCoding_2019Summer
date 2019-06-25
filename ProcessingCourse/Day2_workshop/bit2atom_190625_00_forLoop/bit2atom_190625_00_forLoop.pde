int index = 0;
int elliTotalCol = 100; //the total num of ellipses
int elliTotalRow = 50;

void setup() {
  size(1000, 600);
  background(0);
  frameRate(1);
}

//comments
void myFunction() {
}

void draw() {
  background(0);
  for (int i = 0; i < elliTotalCol; i++) {
    for (int j = 0; j < elliTotalRow; j ++) {
      float d = 10;//random(20, 50);
      noStroke();
      fill(random(255), random(255), random(255));
      ellipse(d*i, d*j, d, d);
      index ++;
    }
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("./design/page"+index+".png");
    //index +=1; //++; //= index + 1;
  }
}
