class Terrain {
  private int length, width, posX, posY;
  private PriorityQueue<Target> targets;

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
    fill(currentFill);
    drawTargets();
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