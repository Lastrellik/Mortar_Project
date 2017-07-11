class Cannon extends StationaryObject {
  Barrel barrel = new Barrel();
  Base base = new Base();
  ArrayList<Projectile> projectiles;
  int posX, posY, posZ;

  public Cannon() {
    projectiles = new ArrayList<Projectile>();
  }

  public Cannon (Barrel barrel, Base base) {
    this();
    setBarrel(barrel);
    setBase(base);
  }

  public void drawCannon() {
    pushMatrix();
    rotateZ(radians(horizontalAngle));
    this.update();
    base.update();
    base.drawBase();
    translate(0, 0, base.getHeight() + barrel.getRadius());
    barrel.update();
    barrel.drawBarrel();
    popMatrix();
    drawProjectiles();
  }

  private void drawProjectiles() {
      for (Projectile p : projectiles) {
      pushMatrix();
      p.updateProjectile();
      popMatrix();
    }
  }

  public void fire() {
    Projectile projectile = new Projectile(cannon);
    projectile.fire();
    projectiles.add(projectile);
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

  public void rotateCounterClockwise(boolean rotateCounterClockwise) {
    setRotateCounterClockwise(rotateCounterClockwise);
  }

  public void rotateClockwise(boolean rotateClockwise) {
    setRotateClockwise(rotateClockwise);
  }

  public void increaseBarrelAngle(boolean increaseBarrelAngle) {
    barrel.setRotateUp(increaseBarrelAngle);
  }

  public void decreaseBarrelAngle(boolean decreaseBarrelAngle) {
    barrel.setRotateDown(decreaseBarrelAngle);
  }
  
  public void setBaseColor(int colorR, int colorG, int colorB){
    base.setColor(colorR, colorG, colorB); 
  }
  
  public void setBarrelColor(int colorR, int colorG, int colorB){
    barrel.setColor(colorR, colorG, colorB); 
  }
  
  public void setProjectileColor(int colorR, int colorG, int colorB){
    if(projectiles.size() > 0) projectiles.get(projectiles.size() - 1).setColor(colorR, colorG, colorB); 
  }
}