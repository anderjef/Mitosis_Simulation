//started 09/16/19
//inspiration: https://www.youtube.com/watch?v=jxGS3fKPKJA

ArrayList<Cell> cells = new ArrayList<Cell>();

void setup() {
  size(800, 800);
  cells.add(new Cell(width / 2, height / 2, sqrt(width * height) / 2));
}

void draw() {
  background(255);
  for (int i = 0; i < cells.size(); ++i) {
    cells.get(i).show();
    cells.get(i).update();
  }
}

void mousePressed() {
  for (int i = 0; i < cells.size(); ++i) {
    if (dist(mouseX, mouseY, cells.get(i).pos.x, cells.get(i).pos.y) <= cells.get(i).r / 2 + cells.get(i).r / 16) {
      cells.add(cells.get(i).split());
      return;
    }
  }
}
