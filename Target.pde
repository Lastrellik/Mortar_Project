class Target {
  private int posX, posY, posZ, size = 5;

  public Target(int posX, int posY) {
    this(posX, posY, 0);
  }

  public Target(int posX, int posY, int posZ) {
    this.posX = posX;
    this.posY = posY;
    this.posZ = posZ;
  }

  public int getPosX() {
    return posX;
  }

  public int getPosY() {
    return posY;
  }

  public int getPosZ() {
    return posZ;
  }

  public void setSize(int size) {
    this.size = size;
  }

  public int getSize() {
    return this.size;
  }

  public void drawTarget() {
    pushMatrix();
    fill(255, 0, 0);
    translate(posX, posY, size);
    box(size, size, size);
    popMatrix();
  }
}