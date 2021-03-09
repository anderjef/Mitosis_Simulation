//Jeffrey Andersen

class Cell {
  PVector pos = new PVector(0, 0);
  float r; //cell radius
  float[] c = {random(255), random(255), random(255)}; //cell color
  PVector velocity = new PVector(0, 0);
  
  Cell(float x, float y, float _r) {
    pos.x = x;
    pos.y = y;
    r = _r;
  }
  
  Cell(float x, float y, float _r, float c0, float c1, float c2) {
    pos.x = x;
    pos.y = y;
    r = _r;
    c[0] = c0;
    c[1] = c1;
    c[2] = c2;
  }
  
  Cell split() {
    float theta = random(2 * PI);
    float c0 = random(32);
    float c1 = random(32);
    float c2 = random(32);
    c[0] = min(223, c[0] + c0);
    c[1] = min(223, c[1] + c1);
    c[2] = min(223, c[2] + c2);
    r *= 0.7937; //0.7937 is approximately the cubed root of 2 (the theoretical volume of the cell is splitting in half)
    Cell cell = new Cell(pos.x, pos.y, r, max(0, c[0] + c0), max(0, c[1] + c1), max(0, c[2] + c2));
    velocity.x = r * cos(theta) / 32;
    velocity.y = r * sin(theta) / 32;
    cell.velocity.x = r * -cos(theta) / 32;
    cell.velocity.y = r * -sin(theta) / 32;
    return cell;
  }
  
  void update() {
    pos.add(PVector.random2D());
    if (pos.x + velocity.x < r / 2 + r / 16) {
      pos.x = r / 2 + r / 16;
      velocity.x = 0;
    }
    else if (pos.x + velocity.x > width - r / 2 - r / 16) {
      pos.x = width - r / 2 - r / 16;
      velocity.x = 0;
    }
    if (pos.y + velocity.y < 0 + r / 2 + r / 16) {
      pos.y = r / 2 + r / 16;
      velocity.y = 0;
    }
    else if (pos.y + velocity.y > height - r / 2 - r / 16) {
      pos.y = height - r / 2 - r / 16;
      velocity.y = 0;
    }
    pos.x += velocity.x;
    pos.y += velocity.y;
    velocity.mult(0.96);
    if (velocity.x < 0.00008 & velocity.x > -0.00008) {
      velocity.x = 0;
    }
    if (velocity.y < 0.00008 & velocity.y > -0.00008) {
      velocity.y = 0;
    }
  }
  
  void show() {
    fill(c[0], c[1], c[2], 100);
    stroke(c[0], c[1], c[2]);
    strokeWeight(r / 8);
    ellipse(pos.x, pos.y, r, r);
  }
}
