class Barrel extends StationaryObject {
  int sides = 10;
  float radius = 1;
  float length = 12;
  public Barrel() {
  }

  public Barrel(int sides, float radius, float length) {
    this();
    setSides(sides);
    setRadius(radius);
    setLength(length);
  }

  public void drawBarrel() {
    pushMatrix();
    int previousFillColor = g.fillColor;
    fill(colorR, colorG, colorB);
    rotateY(radians((float)-getVerticalAngle() + 90));
    float angle = 360 / sides, circleX, circleY;
    beginShape();
    for (int i = 0; i < sides; i++) {
      circleX = cos(radians( i * angle)) * radius;
      circleY = sin(radians(i*angle)) * radius;
      vertex(circleX, circleY, 0);
    }
    endShape(CLOSE);

    beginShape();
    for (int i = 0; i < sides; i++) {
      circleX = cos(radians( i * angle)) * radius;
      circleY = sin(radians(i*angle)) * radius;
      vertex(circleX, circleY, length);
    }
    endShape(CLOSE);

    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
      circleX = cos(radians(i * angle)) * radius;
      circleY = sin(radians(i * angle)) * radius;
      vertex(circleX, circleY, length);
      vertex(circleX, circleY, 0);
    }
    endShape(CLOSE);
    fill(previousFillColor);
    popMatrix();
  }

  public void setSides(int sides) {
    if (sides <= 0) throw new IllegalArgumentException();
    this.sides = sides;
  }

  public void setRadius(float radius) {
    if (radius <= 0) return;
    this.radius = radius;
  }

  public void setLength(float length) {
    if (length <= 0) throw new IllegalArgumentException();
    this.length = length;
  }

  public int getSides() {
    return sides;
  }

  public float getRadius() {
    return radius;
  }

  public float getLength() {
    return length;
  }
}