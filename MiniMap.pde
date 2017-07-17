import java.awt.Rectangle;

class MiniMap {
  private int posX, posY, miniMapWidth, miniMapLength;
  private int margin = 10;
  private Terrain terrain;

  public MiniMap(Terrain terrain) {
    this.terrain = terrain;
    this.miniMapLength = terrain.getLength() / 4;
    this.miniMapWidth = terrain.getWidth() / 4;
    this.posX = width - miniMapWidth - margin;
    this.posY = margin;
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
    if(terrain.getTargets() == null) return;
    for (Target t : terrain.getTargets()) {
      t.getMiniMapTarget().drawMiniMapTarget();
    }
  }

  public void markTarget(int x, int y) {
    if (containsPoint(x, y)) {
      int terrainTargetXPos = (((x - posX) * terrain.getWidth()) / miniMapWidth) - (terrain.getWidth() / 2);
      int terrainTargetYPos = terrain.getLength() - ((y - posY) * terrain.getLength()) / miniMapLength;
      Target currentTarget = new Target(terrainTargetXPos, terrainTargetYPos);
      MiniMapTarget miniMapTarget = new MiniMapTarget(x, y);
      currentTarget.setMiniMapTarget(miniMapTarget);
      terrain.addTarget(currentTarget);
    }
  }

  public boolean containsPoint(int x, int y) {
    return !((x < posX || x > width - margin) || (y > posY + miniMapLength || y < margin));
  }
}