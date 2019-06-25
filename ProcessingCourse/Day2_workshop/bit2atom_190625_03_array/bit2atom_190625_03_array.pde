float[] xx;
float[] yy;
float[] dd;
int elliLength = 200;

void setup() {
  size(600, 600);
  xx = new float[elliLength];
  yy = new float[elliLength];
  dd = new float[elliLength];

  for (int i = 0; i < elliLength; i ++) {
    xx[i] = random(width);
    yy[i] = random(height);
    dd[i] = random(10, 30);
  }
}

void draw() {
  background(0);
  for (int i = 0; i < elliLength; i ++) {
    ellipse(xx[i], yy[i], dd[i], dd[i]);
    for (int j = 0; j < elliLength; j ++) {
      if (i != j) {
        float ddist = dist(xx[i], yy[i], xx[j], yy[j]);
        if(ddist < 50){
          stroke(#9ED12A);
          line(xx[i], yy[i], xx[j], yy[j]);
        }
      }
    }
  }
}
