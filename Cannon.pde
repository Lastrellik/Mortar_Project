import java.util.*;

class Cannon extends StationaryObject {
  private Barrel barrel = new Barrel();
  private Base base = new Base();
  private ArrayList<Projectile> projectiles;
  private double velocityCMPerFrame = 16.666666667; //10 meters per second default
  private final float gravityInM = -9.807;
  private final int CENTIMETERS_PER_METER = 100;
  private final int FRAME_RATE = 60;
  private Target[] targets;
  private int targetIterator = 0;
  private boolean rapidFire = false;
  private boolean bounce = false;
  private Queue<Target> hitTargets = new LinkedList<Target>();
  
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
    rotateZ(radians((float)getHorizontalAngle()));
    this.update();
    drawBase();
    translate(0, 0, base.getHeight() + barrel.getRadius());
    drawBarrel();
    if(rapidFire && frameCount % 5 == 0) fire();
    popMatrix();
    drawProjectiles();
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
      p.drawProjectile();
      for(Target t : terrain.getTargets()) if(t.containsProjectile(p) && !t.isHit()) hitTargets.add(t);
    }
    for(Target t : hitTargets) {
      if(!t.isHit()) t.destroy();
      if(t.getFramesSinceDestruction() >= 150) terrain.getTargets().remove(t);
    }
  }

  public void fire() {
    Projectile projectile = new Projectile(cannon);
    projectile.setBounce(bounce);
    projectile.fire();
    projectiles.add(projectile);
  }

  public void autoFireOne() {
    if (targets == null || targets.length == 0 || targetIterator >= targets.length) return;
    Target currentTarget = targets[targetIterator]; 
    double distance = currentTarget.getDistanceToCannon() / CENTIMETERS_PER_METER;
    double cannonHeightInMeters = cannon.getBase().getHeight() / 10.0;// The denominator should be (float)CENTIMETERS_PER_METER. Somewhere in my math is an error.
    double firstTermInFormula = -Math.pow(getVelocity_metersPerSecond(), 2);
    double secondTermInFormula = Math.sqrt(Math.pow(getVelocity_metersPerSecond(), 4) - Math.pow(gravityInM, 2) * Math.pow(distance, 2) - (2 * Math.pow(getVelocity_metersPerSecond(), 2) * cannonHeightInMeters * gravityInM));
    double thirdTermInFormula = gravityInM * distance;
    float horizontalAngle = (float)Math.atan((double)currentTarget.getPosY() / (float)currentTarget.getPosX());
    float verticalAngle = (float)Math.atan((firstTermInFormula - secondTermInFormula) / thirdTermInFormula); 
    if (horizontalAngle < 0) horizontalAngle += PI;
    if(Float.isNaN(verticalAngle)) return;
    targetIterator++;
    setHorizontalAngle(degrees(horizontalAngle));
    barrel.setVerticalAngle(degrees(verticalAngle));
    fire();
  }

  public void updateTargets(){
    targets = new Target[terrain.getTargets().size()];
    targets = terrain.getTargets().toArray(targets); 
    Arrays.sort(targets);
    targetIterator = 0;
  }
  
  public void clearProjectiles(){
    projectiles.clear(); 
  }

  public void clearTargets(){
    targets = null; 
  }
  
  public void setBounce(boolean bounce){
    this.bounce = bounce; 
  }
  
  public boolean getBounce(){
    return this.bounce; 
  }
  
  public void setRapidFire(boolean rapidFire){
    this.rapidFire = rapidFire;
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

  public void setVelocity_cmPerSecond(double velocity) {
    if (velocity < 0) throw new IllegalArgumentException();
    this.velocityCMPerFrame = velocity / FRAME_RATE;
  }

  public void setVelocity_metersPerSecond(double velocity) {
    if (velocity < 0) return;
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
    return (FRAME_RATE * velocityCMPerFrame) / CENTIMETERS_PER_METER;
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