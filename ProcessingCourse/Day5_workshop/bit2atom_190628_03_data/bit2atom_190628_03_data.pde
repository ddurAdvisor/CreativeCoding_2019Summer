
PrintWriter output;
int ballNum = 10;
boolean dataSave = false;

PVector[] ballAttribute;

void setup() {
  size(600, 600);
  ballAttribute = new PVector[ballNum];
  output = createWriter("data.csv");
  generateData();
}

void draw() {
  background(255);
  visualize();
  if (dataSave) {
    saveData();
    dataSave = false;
  }
}

void keyPressed() {
  if (key == 'r') {
    generateData();
  }
}

void saveData() {
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
}

void generateData() {
  for (int i = 0; i < ballAttribute.length; i ++) {
    float xx = random(width);
    float yy = random(height);
    float dd = random(20, 50);
    output.println(xx+","+yy+","+dd);
    ballAttribute[i] = new PVector(xx, yy, dd);
  }
  dataSave = true;
}

void visualize() {
  for (int i = 0; i < ballAttribute.length; i ++) {
    ellipse(ballAttribute[i].x, ballAttribute[i].y, ballAttribute[i].z, ballAttribute[i].z);
  }
}
