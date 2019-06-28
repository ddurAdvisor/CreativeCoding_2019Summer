String[] data;

void setup() {
  size(600, 600);
  data = loadStrings("data.csv");
}

void draw() {
  background(255);
  parseData();
}

void parseData() {
  for (int i = 0; i < data.length; i ++) {
    String[] dataLines = split(data[i], ',');
    float xx = float(dataLines[0]);
    float yy = float(dataLines[1]);
    float dd = float(dataLines[2]);
    ellipse(xx, yy, dd, dd);
  }
}
