class MiniMapTarget {
  private int posX, posY;
  private Rectangle icon;
  private int iconWidth = 5;

  public MiniMapTarget(int posX, int posY) {
    if (posX < 0 || posX > width || posY < 0 || posY > height) throw new IllegalArgumentException();
    icon = new Rectangle(iconWidth, iconWidth);
    this.posX = posX;
    this.posY = posY;
  }

  public void drawMiniMapTarget() {
    int fillColor = g.fillColor;
    fill(255, 0, 0);
    rect(this.getPosX(), this.getPosY(), this.getIconWidth(), this.getIconWidth());
    fill(fillColor);
  }
  public Rectangle getIcon() {
    return icon;
  }

  public int getPosX() {
    return posX;
  }

  public int getPosY() {
    return posY;
  }
  
  public int getIconWidth(){
    return iconWidth; 
  }

  public void setIconWidth(int iconWidth) {
    if (iconWidth < 0) throw new IllegalArgumentException();
    this.iconWidth = iconWidth;
  }
  
  @Override
  public boolean equals(Object obj){
    if (obj == null) return false;
    if (obj == this) return true;
    if(!(obj instanceof MiniMapTarget)) return false;
    return(this.getPosX() == ((MiniMapTarget)obj).getPosX() && this.getPosY() == ((MiniMapTarget)obj).getPosY());
  }
}