class Projectile {
  private boolean projectileFired = false;
  private PVector positionVector;
  private PVector velocityVector;
  private final PVector gravity = new PVector(0, 0, -.27222222222);//DO NOT CHANGE THIS! REMEMBER SECONDS SQUARED
  private float radius = 1;
  private float velocity = 16.666666667;
  private Cannon cannon;
  private Barrel barrel;
  private final int CENTIMETERS_PER_METER = 100;
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
    println(positionVector.mag());
    velocityVector = new PVector(positionVector.x, positionVector.y, positionVector.z);
    velocityVector.mult(velocity);
    projectileFired = true;
  }

  public void updateProjectile() {
    int currentFill = g.fillColor;
    fill(colorR, colorG, colorB);
    if (projectileFired) {
      if (positionVector.z > -cannon.getBase().getHeight()) {
        positionVector.add(velocityVector);
        velocityVector.add(gravity);
      }
      if (positionVector.z < -cannon.getBase().getHeight()) {
        accountForLandingBelowGround();
        //velocityVector.z *= -.9;
      }
      pushMatrix();
      translate(positionVector.x, positionVector.y, cannon.getBase().getHeight() + radius + positionVector.z);
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

  public void setVelocity(float velocity) {
    if (velocity < 0) throw new IllegalArgumentException();
    this.velocity = (velocity * CENTIMETERS_PER_METER) / frameRate;
  }

  public float getVelocity() {
    return (velocity * frameRate) / CENTIMETERS_PER_METER;
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