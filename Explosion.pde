class Explosion {
  private Particle[] particles; 
  private int radiusMax = 5;

  public Explosion(int numOfParticles) {
    particles = new Particle[numOfParticles];
    for (int i = 0; i < particles.length; i++) particles[i] = new Particle((float)Math.random() * radiusMax);
  }

  public void explode() {
    noStroke();
    for(Particle p : particles){
       p.update();
       p.drawParticle();
    }
  }
}