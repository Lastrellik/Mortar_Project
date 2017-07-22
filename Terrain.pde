class Terrain {
  private int length, width, posX, posY;
  private PriorityQueue<Target> targets;
  private final PVector GRAVITY = new PVector(0, 0, -.27222222222);//DO NOT CHANGE THIS! REMEMBER SECONDS SQUARED
  private PVector Wind = new PVector(0, 0);
  private double windMagnitude = 0;
  private float windDirectionInDegrees;
  private boolean rotateClockwise = false, rotateCounterClockwise = false;
  private float rotationSensitivity = .4;

  public Terrain(int length, int width) {
    if (length <= 0  || width <= 0) throw new IllegalArgumentException();
    this.length = length;
    this.width = width;
    this.posX = -width / 2;
    this.posY = 0;
    targets = new PriorityQueue<Target>();
  }

  public void drawTerrain() {
    int currentFill = g.fillColor;
    fill(51);
    noStroke();
    rect(posX, posY, width, length);
    if(rotateClockwise) setWindDirectionInDegrees(windDirectionInDegrees - rotationSensitivity);
    if(rotateCounterClockwise) setWindDirectionInDegrees(windDirectionInDegrees + rotationSensitivity);
    fill(currentFill);
    drawTargets();
  }
  
  private void setWindDirectionInDegrees(float windDirectionInDegrees){
    this.windDirectionInDegrees = windDirectionInDegrees;
    Wind.x = cos(radians(windDirectionInDegrees));
    Wind.y = sin(radians(windDirectionInDegrees));
    Wind.mult((float)windMagnitude);
  }
  
  public float getWindDirectionInDegrees(){
    return windDirectionInDegrees;
  }
  
  public void setRotateClockwise(boolean rotateClockwise) {
    this.rotateClockwise = rotateClockwise;
  }

  public void setRotateCounterClockwise(boolean rotateCounterClockwise) {
    this.rotateCounterClockwise = rotateCounterClockwise;
  }
  
  public void setWindMagnitude(double windMagnitude){
    if(windMagnitude < 0) return;
    if(Wind.x == 0 || Wind.y == 0) setWindDirectionInDegrees(windDirectionInDegrees);
    this.windMagnitude = windMagnitude; 
    this.Wind.normalize();
    this.Wind.mult((float)this.windMagnitude);
  }
  
  public double getWindMagnitude(){
    return windMagnitude; 
  }
  
  private void drawTargets() {
    for (Target t : targets) {
      t.drawTarget();
    }
  }
  
  public void addTarget(Target target) {
    target.setDistanceToCannon(Math.sqrt(Math.pow(target.getPosX(), 2) + Math.pow(target.getPosY(), 2)));
    targets.add(target);
  }
  
  public void clearTargets(){
    targets.clear(); 
  }
  
  public PriorityQueue<Target> getTargets() {
    return targets;
  }

  public int getWidth() {
    return width;
  }

  public int getLength() {
    return length;
  }

  public int getPosX() {
    return posX;
  }

  public int getPosY() {
    return posY;
  }
}