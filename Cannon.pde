class Cannon extends StationaryObject{
  Barrel barrel = new Barrel();
  Base base = new Base();
  int posX, posY, posZ;

  public Cannon() {
  }

  public Cannon (Barrel barrel, Base base) {
    this();
    setBarrel(barrel);
    setBase(base);
  }

  public void drawCannon() {
    pushMatrix();
    base.update();
    base.drawBase();
    translate(0, 0, base.getHeight() + barrel.getRadius());
    barrel.update();
    barrel.drawBarrel();
    popMatrix();
  }

  public void setBarrel(Barrel barrel) {
    this.barrel =  barrel;
  }

  public Barrel getBarrel() {
    return barrel;
  }

  public void setBase(Base base) {
    this.base = base;
  }

  public Base getBase() {
    return base;
  }

  public void rotateCounterClockwise(boolean rotateCounterClockwise){
    barrel.setRotateCounterClockwise(rotateCounterClockwise);
    base.setRotateCounterClockwise(rotateCounterClockwise);
  }
  
  public void rotateClockwise(boolean rotateClockwise) {
    barrel.setRotateClockwise(rotateClockwise);
    base.setRotateClockwise(rotateClockwise);
  }
  
  public void increaseBarrelAngle(boolean increaseBarrelAngle){
    barrel.setRotateUp(increaseBarrelAngle);
  }
  
  public void decreaseBarrelAngle(boolean decreaseBarrelAngle){
    barrel.setRotateDown(decreaseBarrelAngle);
  }

}