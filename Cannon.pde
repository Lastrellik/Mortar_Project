class Cannon extends StationaryObject{
  Barrel barrel;
  Base base;
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
    rotateZ(radians(horizontalAngle - 90));
    base.drawBase();
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

  public void rotateCounterClockwise(){
    barrel.increaseHorizontalAngle();
    base.increaseHorizontalAngle();
  }
  
  public void rotateClockwise() {
    barrel.decreaseHorizontalAngle();
    base.increaseHorizontalAngle();
  }
  
  public void increaseBarrelAngle(){
     barrel.increaseHorizontalAngle();
  }
  
  public void decreaseBarrelAngle(){
    barrel.decreaseHorizontalAngle(); 
  }

}