//Jeffrey Andersen

ArrayList<Cell> cells = new ArrayList<Cell>();

void setup() {
  size(800, 800);
  cells.add(new Cell(width / 2, height / 2, sqrt(width * height) / 2));
}

void draw() {
  background(255);
  for (Cell c : cells) {
    c.show();
    c.update();
  }
}

void mousePressed() {
  for (Cell c : cells) {
    if (dist(mouseX, mouseY, c.pos.x, c.pos.y) <= c.r / 2 + c.r / 16) {
      cells.add(c.split());
      return;
    }
  }
}
