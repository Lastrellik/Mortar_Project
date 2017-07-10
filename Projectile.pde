class Projectile {
  private boolean projectileFired = false;
  private PVector positionVector;
  private PVector velocityVector;
  private PVector gravity = new PVector(0, 0, -.25);
  private float radius = 1;
  private float velocity = 12;
  private Cannon cannon;
  private Barrel barrel;


  public Projectile(Cannon cannon) {
    this.cannon = cannon;
    this.barrel = cannon.getBarrel();
  }

  public void fire() {
    positionVector = new PVector(cos(radians(cannon.getHorizontalAngle())) * Math.abs(cos(radians(barrel.getVerticalAngle()))), sin(radians(cannon.getHorizontalAngle())) * cos(radians(barrel.getVerticalAngle())), sin(radians(barrel.getVerticalAngle())));
    velocityVector = new PVector(positionVector.x, positionVector.y, positionVector.z);
    velocityVector.mult(velocity);
    projectileFired = true;
  }

  public void updateProjectile() {
    if (projectileFired) {
      if (positionVector.z > 0) {
        positionVector.add(velocityVector);
        velocityVector.add(gravity);
      }
      if (positionVector.z < 0) {
        accountForLandingBelowGround();
      }
      pushMatrix();
      translate(positionVector.x, positionVector.y, cannon.getBase().getHeight() + radius + positionVector.z);
      sphere(radius);
      popMatrix();
    }
  }

  private void accountForLandingBelowGround() {
    velocityVector.mult(-.1); 
    while (positionVector.z < 0) {
      positionVector.add(velocityVector);
      println(positionVector.z);
    }
    positionVector.z = 0;
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
    this.velocity = velocity;
  }

  public float getVelocity() {
    return velocity;
  }

  public boolean isFired() {
    return projectileFired;
  }

  public void setBarrel(Barrel barrel) {
    if (barrel == null) throw new NullPointerException();
    this.barrel =  barrel;
  }
}