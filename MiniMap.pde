import java.awt.Rectangle;

class MiniMap {
  private int posX, posY, miniMapWidth, miniMapLength;
  private int margin = 10;
  private ArrayList<Rectangle> miniMapTargets;
  private Terrain terrain;
  private Cannon cannon;

  public MiniMap(Terrain terrain, Cannon cannon) {
    this.cannon = cannon;
    this.terrain = terrain;
    this.miniMapLength = terrain.getLength() / 4;
    this.miniMapWidth = terrain.getWidth() / 4;
    this.posX = width - miniMapWidth - margin;
    this.posY = margin;
    miniMapTargets = new ArrayList<Rectangle>();
  }

  public void drawMiniMap() {
    int fillColor = g.fillColor;
    fill(100, 100, 100, 100);
    tint(100, 100);
    rect(posX, posY, miniMapWidth, miniMapLength);
    fill(fillColor);
    drawPoints();
  }

  private void drawPoints() {
    for (Rectangle r : miniMapTargets) {
      int fillColor = g.fillColor;
      fill(255, 0, 0);
      rect((float)r.getX(), (float)r.getY(), (float)r.getWidth(), (float)r.getHeight()); 
      fill(fillColor);
    }
  }

  public void markTarget(int x, int y) {
    if (containsPoint(x, y)) {
      int terrainTargetXPos = (((x - posX) * terrain.getWidth()) / miniMapWidth) - (terrain.getWidth() / 2);
      int terrainTargetYPos = terrain.getLength() - ((y - posY) * terrain.getLength()) / miniMapLength;
      miniMapTargets.add(new Rectangle(x, y, 5, 5));
      cannon.addTarget(new Target(terrainTargetXPos, terrainTargetYPos));
    }
  }

  public boolean containsPoint(int x, int y) {
    return !((x < posX || x > width - margin) || (y > posY + miniMapLength || y < margin));
  }
}