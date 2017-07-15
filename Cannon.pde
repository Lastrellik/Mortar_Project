import java.util.PriorityQueue;

class Cannon extends StationaryObject {
  private Barrel barrel = new Barrel();
  private Base base = new Base();
  private ArrayList<Projectile> projectiles;
  private PriorityQueue<Target> targets;
  private double velocityCMPerFrame = 16.666666667; //10 meters per second default
  private final float gravityInCM = 981;
  private final float gravityInM = -9.8;
  private final int CENTIMETERS_PER_METER = 100;
  private final int FRAME_RATE = 60;

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
    drawBase();
    translate(0, 0, base.getHeight() + barrel.getRadius());
    drawBarrel();
    popMatrix();
    drawProjectiles();
    drawTargets();
  }

  private void drawBase() {
    base.update();
    base.drawBase();
  }

  private void drawBarrel() {
    barrel.update();
    barrel.drawBarrel();
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

  public void autoFireOne() {
    if (targets.peek() == null) return;
    Target currentTarget = targets.peek(); 
    double distance = currentTarget.getDistanceToCannon() / CENTIMETERS_PER_METER;
    double cannonHeightInMeters = cannon.getBase().getHeight() / (double)CENTIMETERS_PER_METER;
    double firstTermInFormula = -Math.pow(10, 2);//-Math.pow(getVelocity_metersPerSecond(), 2);
    println("first term in formula: " + firstTermInFormula);
    double secondTermInFormula = Math.sqrt(Math.pow(10, 4) - Math.pow(gravityInM, 2) * Math.pow(distance, 2) - (2 * Math.pow(10, 2) * cannonHeightInMeters * gravityInM));
    //Math.sqrt(Math.pow(getVelocity_metersPerSecond(), 4) - Math.pow(gravityInM, 2) * Math.pow(distance, 2) - (2 * Math.pow(getVelocity_metersPerSecond(), 2) * cannonHeightInMeters * gravityInM));
    println("second term in formula: " + secondTermInFormula);
    double thirdTermInFormula = gravityInM * distance;
    println("third term in formula: " + thirdTermInFormula);
    double horizontalAngle = Math.atan((float)currentTarget.getPosY() / (float)currentTarget.getPosX());
    if (horizontalAngle < 0) horizontalAngle += PI;
    double verticalAngle = Math.atan((firstTermInFormula - secondTermInFormula) / thirdTermInFormula); 
    //if(verticalAngle < 0) verticalAngle += PI;
    setHorizontalAngle(degrees((float)horizontalAngle));
    barrel.setVerticalAngle(degrees((float)verticalAngle));
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

  public PriorityQueue<Target> getTargets() {
    return targets;
  }

  public void setVelocity_cmPerSecond(double velocity) {
    if (velocity < 0) throw new IllegalArgumentException();
    this.velocityCMPerFrame = velocity / FRAME_RATE;
  }

  public void setVelocity_metersPerSecond(double velocity) {
    if (velocity < 0) throw new IllegalArgumentException();
    this.velocityCMPerFrame = (velocity * CENTIMETERS_PER_METER) / 60;
  }
  
  public void setVelocity_cmPerFrame(double velocity){
    if (velocity < 0) throw new IllegalArgumentException();
     this.velocityCMPerFrame = velocity; 
  }

  public double getVelocity_cmPerSecond() {
    return velocityCMPerFrame * FRAME_RATE;
  }
  
  public double getVelocity_metersPerSecond(){
    return FRAME_RATE * CENTIMETERS_PER_METER * velocityCMPerFrame;
  }
  
  public double getVelocity_cmPerFrame(){
    return velocityCMPerFrame; 
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