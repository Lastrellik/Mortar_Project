class Terrain {
  private int length, width, posX, posY;

  public Terrain(int length, int width) {
    if (length <= 0  || width <= 0) throw new IllegalArgumentException();
    this.length = length;
    this.width = width;
    this.posX = -width / 2;
    this.posY = 0;
  }

  public void drawTerrain() {
    int currentFill = g.fillColor;
    fill(51);
    noStroke();
    rect(posX, posY, width, length);
    fill(currentFill);
  }

  public int getWidth() {
    return width;
  }

  public int getLength() {
    return length;
  }

  public int getPosX() {
    return posX;
  }

  public int getPosY() {
    return posY;
  }
}