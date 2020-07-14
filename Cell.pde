class Cell {
  PVector pos = new PVector(0, 0);
  float r;
  float[] c = {random(255), random(255), random(255)};
  float velX = 0;
  float velY = 0;
  
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
    this.c[0] = min(223, this.c[0] + c0);
    this.c[1] = min(223, this.c[1] + c1);
    this.c[2] = min(223, this.c[2] + c2);
    this.r *= 0.7937; //0.7937 is approximately the cubed root of 2 (the theoretical volume of the cell is splitting in half)
    Cell cell = new Cell(this.pos.x, this.pos.y, this.r, max(0, this.c[0] + c0), max(0, this.c[1] + c1), max(0, this.c[2] + c2));
    this.velX = this.r * cos(theta) / 32;
    this.velY = this.r * sin(theta) / 32;
    cell.velX = this.r * -cos(theta) / 32;
    cell.velY = this.r * -sin(theta) / 32;
    return cell;
  }
  
  void update() {
    pos.add(PVector.random2D());
    if (pos.x + velX < r / 2 + r / 16) {
      pos.x = r / 2 + r / 16;
      velX = 0;
    }
    else if (pos.x + velX > width - r / 2 - r / 16) {
      pos.x = width - r / 2 - r / 16;
      velX = 0;
    }
    if (pos.y + velY < 0 + r / 2 + r / 16) {
      pos.y = r / 2 + r / 16;
      velY = 0;
    }
    else if (pos.y + velY > height - r / 2 - r / 16) {
      pos.y = height - r / 2 - r / 16;
      velY = 0;
    }
    pos.x += velX;
    pos.y += velY;
    velX *= 0.96;
    velY *= 0.96;
    if (velX < 0.00008 & velX > -0.00008) {
      velX = 0;
    }
    if (velY < 0.00008 & velY > -0.00008) {
      velY = 0;
    }
  }
  
  void show() {
    fill(c[0], c[1], c[2], 100);
    stroke(c[0], c[1], c[2]);
    strokeWeight(r / 8);
    ellipse(pos.x, pos.y, r, r);
  }
}
