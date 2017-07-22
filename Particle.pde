class Particle {
  private float radius;
  private PVector position;
  private PVector velocity;
  private final PVector GRAVITY = new PVector(0, 0, -.27222222222);
  private int colorR, colorG, colorB;

  public Particle(float radius) {
    this.radius = radius;
    this.position = new PVector(0, 0, 0);
    velocity = PVector.random3D();
    if(velocity.z < 0) velocity.z *= -1;
    colorR = (int)Math.round(Math.random() * 255);
    colorG = (int)Math.round(Math.random() * 255);
    colorB = (int)Math.round(Math.random() * 255);
    velocity.mult(10);
  }

  public void setVelocity(PVector velocity) {
    this.velocity = velocity;
  }

  public void setMagnitude(float magnitude) {
    velocity.normalize();
    velocity.mult(magnitude);
  }

  public void update() {
    position.add(velocity);
    velocity.add(GRAVITY);
    velocity.add(terrain.Wind);
    if(radius > 0) radius -= .05;
    if(position.z < 0) velocity.z *= -1;
  }

  public void drawParticle() {
    pushMatrix();
    int currentColor = g.fillColor;
    fill(colorR, colorG, colorB);
    translate(position.x, position.y, position.z);
    sphere(radius);
    fill(currentColor);
    popMatrix();
  }
}