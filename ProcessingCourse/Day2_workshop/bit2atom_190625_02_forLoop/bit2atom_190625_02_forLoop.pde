int index = 0;
int elliTotalCol = 200; //the total num of ellipses
int elliTotalRow = 120;
int m = 10;

void setup() {
  size(1000, 600);
  background(0);
  frameRate(1);
}

//comments 20*20 grid
void myFunction(float xx, float yy) {
  strokeWeight(5);
  float status = random(2);
  if(status > 1){
  line(xx-10, yy -10, xx +10, yy +10);
  }else{
    line(xx+10, yy -10, xx -10, yy +10);
  }
}

void draw() {
  background(51);
  for (int i = 0; i < 50; i++) {
    for (int j = 0; j < 50; j ++) {
      //float d = 5;//random(20, 50);
      //noStroke();
      stroke(random(255), random(255), random(255));
      //fill(255);
      //if(j >= 20 && j <= 30){
      //  fill(255, 0, 100);
      //}
      
      //color elliFill = (int)map(j%m, 0, m, 0, 255);
      //fill(elliFill);
      //ellipse(d*i, d*j, d, d);
      myFunction(i*20, j*20);
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
