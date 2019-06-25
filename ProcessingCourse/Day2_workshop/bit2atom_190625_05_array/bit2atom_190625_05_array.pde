PVector[] location;
float[] dd;
PVector[] speed;
PVector[] acc;
int elliLength = 50;

void setup() {
  size(600, 600);
  location = new PVector[elliLength];
  dd = new float[elliLength];
  speed = new PVector[elliLength];
  acc = new PVector[elliLength];

  for (int i = 0; i < elliLength; i ++) {
    location[i] = new PVector(random(width), random(height));
    dd[i] = random(30, 60);
    speed[i] = new PVector(random(1, 5), random(1, 5));
    acc[i] = new PVector(0, 0);
  }
}

void draw() {
  background(0);
  collision();
  //connection();
  edge();
  
  drawEllipse();
  drawArrow();
}

void collision(){
  for (int i = 0; i < elliLength; i ++) {
    for (int j = 0; j < elliLength; j ++) {
      if (i != j) {
        float ddist = PVector.dist(location[i], location[j]);
        if (ddist < (dd[i] + dd[j])/2) {
          PVector pong = PVector.sub(location[i], location[j]);
          pong.normalize();
          pong.mult(50/dd[i]);
          acc[i].add(pong);
        }
      }
    }
  }
}

void drawArrow(){
  for (int i = 0; i < elliLength; i ++) {
    float ang = speed[i].heading();
    stroke(#D0D317);
    line(location[i].x, location[i].y, location[i].x+10*speed[i].mag()*cos(ang), location[i].y+10*speed[i].mag()*sin(ang));
  }
}

void drawEllipse() {
  for (int i = 0; i < elliLength; i ++) {
    ellipse(location[i].x, location[i].y, dd[i], dd[i]);
    speed[i].add(acc[i]);
    location[i].add(speed[i]);
    acc[i] = new PVector(0, 0);
  }
}

void connection() {
  for (int i = 0; i < elliLength; i ++) {
    for (int j = 0; j < elliLength; j ++) {
      if (i != j) {
        float ddist = PVector.dist(location[i], location[j]);
        if (ddist < 50) {
          stroke(#9ED12A);
          line(location[i].x, location[i].y, location[j].x, location[j].y);
        }
      }
    }
  }
}

void edge() {
  for (int i = 0; i < elliLength; i ++) {

    if (location[i].x + dd[i]/2 > width) {
      location[i].x = width - dd[i]/2;
      speed[i].x = speed[i].x *-1;
    }

    if (location[i].x - dd[i]/2 < 0) {
      location[i].x = dd[i]/2;
      speed[i].x = speed[i].x *-1;
    }

    if (location[i].y + dd[i]/2 > height) {
      location[i].y = height - dd[i]/2;
      speed[i].y *=-1;
    }

    if (location[i].y  - dd[i]/2 < 0) {
      location[i].y = dd[i]/2;
      speed[i].y *=-1;
    }
  }
}
