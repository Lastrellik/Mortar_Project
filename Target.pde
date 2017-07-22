class Target implements Comparable<Target> {
  private int posX, posY, posZ, size = 10;
  private double distanceToCannon = 0;
  private MiniMapTarget miniMapTarget;
  private Explosion explosion;
  private boolean isHit;
  private int framesSinceDestruction = 0;
  
  public Target(int posX, int posY) {
    this(posX, posY, 0);
  }

  public Target(int posX, int posY, int posZ) {
    this.posX = posX;
    this.posY = posY;
    this.posZ = posZ;
  }
  
  public void destroy(){
    isHit = true;
    explosion = new Explosion(100);
  }

  public int getPosX() {
    return posX;
  }

  public int getPosY() {
    return posY;
  }

  public int getPosZ() {
    return posZ;
  }

  public void setSize(int size) {
    this.size = size;
  }

  public int getSize() {
    return this.size;
  }
  
  public boolean isHit(){
    return isHit; 
  }

  public void drawTarget() {
    pushMatrix();
    fill(255, 0, 0);
    stroke(255);
    translate(posX, posY, size / 2.0);
    if(explosion != null){
      explosion.explode();
      framesSinceDestruction++;
    } else box(size);
    noStroke();
    popMatrix();
  }
  
  public void setDistanceToCannon(double distanceToCannon){
    if(distanceToCannon < 0) throw new IllegalArgumentException();
    this.distanceToCannon = distanceToCannon;
  }
  
  public double getDistanceToCannon(){
    return distanceToCannon; 
  }
  
  public int getFramesSinceDestruction(){
    return framesSinceDestruction; 
  }
  
  public void setMiniMapTarget(MiniMapTarget target){
     this.miniMapTarget = target;
  }
  
  public MiniMapTarget getMiniMapTarget(){
    return this.miniMapTarget; 
  }
  
  public boolean containsProjectile(Projectile projectile){
    float leftSide = posX - (size/2.0 + projectile.getRadius());
    float rightSide = posX + (size/2.0 + projectile.getRadius());
    float frontSide = posY - (size/2.0 + projectile.getRadius());
    float backSide = posY + (size/2.0 + projectile.getRadius());
     return !(projectile.getPosZ() > size || projectile.getPosX() < leftSide || projectile.getPosX() > rightSide || projectile.getPosY() < frontSide || projectile.getPosY() > backSide); 
  }
  
  public int compareTo(Target other){
    return (int)Math.round(this.getDistanceToCannon() - other.getDistanceToCannon()); 
  }
}