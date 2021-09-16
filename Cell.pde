//Jeffrey Andersen

class Cell {
  PVector pos; //position
  PVector velocity;
  float r; //radius
  float c[] = { 0, 0, 0 }; //cell color
  
  Cell(float x, float y, float _r) {
    pos = new PVector(x, y);
    velocity = new PVector(0, 0);
    r = _r;
    c[0] = random(255);
    c[1] = random(255);
    c[2] = random(255);
  }
  
  Cell(PVector _pos, float _r, float c0, float c1, float c2, float xVelocity, float yVelocity) {
    pos = _pos.copy();
    r = _r;
    c[0] = c0;
    c[1] = c1;
    c[2] = c2;
    velocity = new PVector(xVelocity, yVelocity);
  }
  
  Cell split() {
    r *= pow(2.0, -1.0/3.0); //multiply by one over the cubed root of 2 (the theoretical volume of the cell is splitting in half)
    float c0 = random(32), c1 = random(32), c2 = random(32);
    c[0] = min(223, c[0] + c0);
    c[1] = min(223, c[1] + c1);
    c[2] = min(223, c[2] + c2);
    float theta = random(TWO_PI);
    velocity.x = 8 * cos(theta); //multiplying velocity by a constant still gives the illusion that larger cells have more mass as they (because of their scale) appear to move less far
    velocity.y = 8 * sin(theta); //multiplying velocity by a constant still gives the illusion that larger cells have more mass as they (because of their scale) appear to move less far
    return new Cell(pos, r, max(0, c[0] + c0), max(0, c[1] + c1), max(0, c[2] + c2), 8 * -cos(theta), 8 * -sin(theta)); //multiplying velocity by a constant still gives the illusion that larger cells have more mass as they (because of their scale) appear to move less far
  }
  
  void update() {
    pos.add(PVector.random2D());
    pos.add(velocity);
    if (pos.x < r) {
      pos.x = r;
      velocity.x = 0;
    }
    else if (pos.x > width - r) {
      pos.x = width - r;
      velocity.x = 0;
    }
    if (pos.y < r) {
      pos.y = r;
      velocity.y = 0;
    }
    else if (pos.y > height - r) {
      pos.y = height - r;
      velocity.y = 0;
    }
    velocity.mult(0.96);
    if (abs(velocity.x) < 0.001) {
      velocity.x = 0;
    }
    if (abs(velocity.y) < 0.001) {
      velocity.y = 0;
    }
  }
  
  void show() {
    fill(c[0], c[1], c[2], 100);
    stroke(c[0], c[1], c[2]);
    strokeWeight(r / 4);
    circle(pos.x, pos.y, 2 * 7 * r / 8);
  }
}
