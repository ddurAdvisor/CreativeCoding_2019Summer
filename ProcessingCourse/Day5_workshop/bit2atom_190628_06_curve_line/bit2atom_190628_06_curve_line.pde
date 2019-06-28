String[] data;

void setup() {
  size(600, 600);
  data = loadStrings("serialTempData.csv");
}

void draw() {
  background(255);
  parseData();
}

void parseData() {
  beginShape();
  for (int i = 0; i < data.length; i ++) {
    String[] dataLines = split(data[i], ',');
    float xx = float(dataLines[0]);
    float yy = float(dataLines[1]);
    curveVertex(xx*2, yy);
  }
  endShape();
}
