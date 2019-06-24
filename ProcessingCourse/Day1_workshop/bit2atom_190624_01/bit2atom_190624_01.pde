//initiate block
void setup(){
  size(600, 400);
  background(255);
}

int x = 0;
int y = 200;

//loop block
void draw(){
  fill(100, 10);
  rect(0,0,width,height);
  fill(200);
  ellipse(x, y, 50, 50);
  x = x + 1;
}
