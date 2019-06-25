int index = 0;
int elliTotalCol = 200; //the total num of ellipses
int elliTotalRow = 120;
int m = 10;

void setup() {
  size(1000, 600);
  background(0);
  //frameRate(1);
}

//comments
void myFunction() {
}

void draw() {
  background(0);
  for (int i = 0; i < elliTotalCol; i++) {
    for (int j = 0; j < elliTotalRow; j ++) {
      float d = 5;//random(20, 50);
      noStroke();
      //fill(random(255), random(255), random(255));
      //fill(255);
      //if(j >= 20 && j <= 30){
      //  fill(255, 0, 100);
      //}
      
      color elliFill = (int)map(j%m, 0, m, 0, 255);
      fill(elliFill);
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
  if(key == 'a'){
    m ++;
  }
  if(key == 'z'){
    if(m > 2){
      m --;
    }
  }
}
