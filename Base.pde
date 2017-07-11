class Base extends StationaryObject {
  int length = 12;
  int width = 6;
  int height = 2;

  public Base() {
  }

  public Base(int length, int width, int height) {
    setLength(length);
    setWidth(width);
    setHeight(height);
  }

  public void drawBase() {
    int currentFill = g.fillColor;
    fill(colorR, colorG, colorB);
    pushMatrix();
    translate(getLength() / 2, 0, getHeight() / 2);
    box(length, width, height);
    popMatrix();
    fill(currentFill);
  }

  public void setLength(int length) {
    if (length <= 0) throw new IllegalArgumentException();
    this.length = length;
  }

  public void setWidth(int width) {
    if (width <= 0) throw new IllegalArgumentException();
    this.width = width;
  }

  public void setHeight(int height) {
    if (height <= 0) throw new IllegalArgumentException();
    this.height = height;
  }

  public int getLength() {
    return length;
  }

  public int getWidth() {
    return width;
  }

  public int getHeight() {
    return height;
  }
}