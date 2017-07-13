import java.util.PriorityQueue;

class Cannon extends StationaryObject {
  private Barrel barrel = new Barrel();
  private Base base = new Base();
  private ArrayList<Projectile> projectiles;
  private PriorityQueue<Target> targets;
  private double velocity = 0;//16.666666667; //10 meters per second default
  private final float gravityInCM = 981;
  private final int CENTIMETERS_PER_METER = 100;

  public Cannon() {
    projectiles = new ArrayList<Projectile>();
    targets = new PriorityQueue<Target>();
  }

  public Cannon (Barrel barrel, Base base) {
    this();
    setBarrel(barrel);
    setBase(base);
  }

  public void drawCannon() {
    pushMatrix();
    rotateZ(radians(getHorizontalAngle()));
    this.update();
    base.update();
    base.drawBase();
    translate(0, 0, base.getHeight() + barrel.getRadius());
    barrel.update();
    barrel.drawBarrel();
    popMatrix();
    drawProjectiles();
    drawTargets();
  }

  private void drawProjectiles() {
    for (Projectile p : projectiles) {
      p.updateProjectile();
    }
  }

  private void drawTargets() {
    for (Target t : targets) {
      pushMatrix();
      translate(0, 0, -base.getHeight());
      t.drawTarget();
      popMatrix();
    }
  }

  public void fire() {
    Projectile projectile = new Projectile(cannon);
    projectile.fire();
    projectiles.add(projectile);
  }
  
  public void autoFireOne(){
    if(targets.peek() == null) return;
    Target currentTarget = targets.peek(); 
    double horizontalAngle = Math.atan((float)currentTarget.getPosY() / (float)currentTarget.getPosX());
    if(horizontalAngle < 0) horizontalAngle += PI;
    double verticalAngle = Math.atan((float)((currentTarget.getDistanceToCannon() - 12) * gravityInCM) / (float)(Math.pow(CENTIMETERS_PER_METER * getVelocity(), 2)) * 2.0);
    setHorizontalAngle(degrees((float)horizontalAngle));
    barrel.setVerticalAngle(degrees((float)verticalAngle));
    println(degrees((float)verticalAngle));
    fire();
    targets.poll();
  }

  public void addTarget(Target target) {
    target.setDistanceToCannon(Math.sqrt(Math.pow(target.getPosX(), 2) + Math.pow(target.getPosY(), 2)));
    targets.add(target);
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
  
  public void setVelocity(double velocity) {
    if (velocity < 0) throw new IllegalArgumentException();
    this.velocity = velocity;
  }

  public double getVelocity() {
    return velocity;
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

  public void setBaseColor(int colorR, int colorG, int colorB) {
    base.setColor(colorR, colorG, colorB);
  }

  public void setBarrelColor(int colorR, int colorG, int colorB) {
    barrel.setColor(colorR, colorG, colorB);
  }

  public void setProjectileColor(int colorR, int colorG, int colorB) {
    if (projectiles.size() > 0) projectiles.get(projectiles.size() - 1).setColor(colorR, colorG, colorB);
  }
}