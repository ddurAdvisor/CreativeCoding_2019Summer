float[] xx;
float[] yy;
float[] dd;
float[] speedX;
float[] speedY;
int elliLength = 200;

void setup() {
  size(600, 600);
  xx = new float[elliLength];
  yy = new float[elliLength];
  dd = new float[elliLength];
  speedX = new float[elliLength];
  speedY = new float[elliLength];

  for (int i = 0; i < elliLength; i ++) {
    xx[i] = random(width);
    yy[i] = random(height);
    dd[i] = random(10, 30);
    speedX[i] = random(1, 5);
    speedY[i] = random(1, 5);
  }
}

void draw() {
  background(0);
  for (int i = 0; i < elliLength; i ++) {
    ellipse(xx[i], yy[i], dd[i], dd[i]);
    xx[i] += speedX[i];
    yy[i] += speedY[i];

    for (int j = 0; j < elliLength; j ++) {
      if (i != j) {
        float ddist = dist(xx[i], yy[i], xx[j], yy[j]);
        if (ddist < 50) {
          stroke(#9ED12A);
          line(xx[i], yy[i], xx[j], yy[j]);
        }
      }
    }

    if (xx[i] + dd[i]/2 > width) {
      xx[i] = width - dd[i]/2;
      speedX[i] = speedX[i] *-1;
    }

    if (xx[i] - dd[i]/2 < 0) {
      xx[i] = dd[i]/2;
      speedX[i] = speedX[i] *-1;
    }

    if (yy[i] + dd[i]/2 > height) {
      yy[i] = height - dd[i]/2;
      speedY[i] = speedY[i] *-1;
    }

    if (yy[i] - dd[i]/2 < 0) {
      yy[i] = dd[i]/2;
      speedY[i] = speedY[i] *-1;
    }
  }
}
