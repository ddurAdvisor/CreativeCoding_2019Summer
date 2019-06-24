int index = 0;

void setup(){
  size(600, 600);
  background(0);
}

void draw(){
  float d = random(20, 50);
  noStroke();
  fill(random(255), random(255), random(255));
  ellipse(random(width), random(height), d, d);
  index ++;
}

void keyPressed(){
  if(key == 's'){
    saveFrame("./design/page"+index+".png");
    //index +=1; //++; //= index + 1;
  }
}
