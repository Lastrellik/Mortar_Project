class Projectile {
  private boolean projectileFired = false;
  private PVector positionVector;
  private PVector velocityVector;
  private final PVector GRAVITY = new PVector(0, 0, -.27222222222);//DO NOT CHANGE THIS! REMEMBER SECONDS SQUARED
  private float radius = 1;
  private Cannon cannon;
  private Barrel barrel;
  int colorR = 70;
  int colorG = 102;
  int colorB = 255;


  public Projectile(Cannon cannon) {
    this.cannon = cannon;
    this.barrel = cannon.getBarrel();
  }

  public void fire() {
    positionVector = new PVector(cos(radians(cannon.getHorizontalAngle())) * Math.abs(cos(radians(barrel.getVerticalAngle()))), sin(radians(cannon.getHorizontalAngle())) * cos(radians(barrel.getVerticalAngle())), sin(radians(barrel.getVerticalAngle())));
    positionVector.normalize();
    velocityVector = new PVector(positionVector.x, positionVector.y, positionVector.z);
    velocityVector.mult((float)cannon.getVelocity_cmPerFrame());
    projectileFired = true;
  }

  public void updateProjectile() {
    int currentFill = g.fillColor;
    fill(colorR, colorG, colorB);
    if (projectileFired) {
      if (positionVector.z > -cannon.getBase().getHeight()) {
        positionVector.add(velocityVector);
        velocityVector.add(GRAVITY);
      }
      if (positionVector.z < -cannon.getBase().getHeight()) {
        accountForLandingBelowGround();
        //velocityVector.z *= -.9;
      }
      pushMatrix();
      translate(positionVector.x, positionVector.y, cannon.getBase().getHeight() + positionVector.z);
      sphere(radius);
      popMatrix();
    }
    fill(currentFill);
  }

  private void accountForLandingBelowGround() {
    velocityVector.mult(-.1); 
    while (positionVector.z < -cannon.getBase().getHeight()) {
      positionVector.add(velocityVector);
    }
    positionVector.z = -cannon.getBase().getHeight();
  }

  public void setRadius(float radius) {
    if (radius <= 0) throw new IllegalArgumentException();
    this.radius = radius;
  }

  public float getRadius() {
    return radius;
  }

  public boolean isFired() {
    return projectileFired;
  }

  public void setBarrel(Barrel barrel) {
    if (barrel == null) throw new NullPointerException();
    this.barrel =  barrel;
  }

  public void setColor(int colorR, int colorG, int colorB) {
    if (colorR > 255 || colorR < 0 || colorG > 255 || colorG < 0 || colorB > 255 || colorB < 0) throw new IllegalArgumentException();
    this.colorR = colorR;
    this.colorG = colorG;
    this.colorB = colorB;
  }
}