abstract class StationaryObject {

  private double verticalAngle = 0;
  private double horizontalAngle = 90;
  private double rotationalSensitivity = 1;
  private boolean rotateClockwise = false, rotateCounterClockwise = false, rotateUp = false, rotateDown = false;
  private int posX, posY, posZ;
  int colorR = 255;
  int colorG = 255;
  int colorB = 255;

  public void setRotationSensitivity(double sensitivity) {
    if (sensitivity < 0) return;
    this.rotationalSensitivity = sensitivity;
  }

  public double getRotationSensitivity() {
    return rotationalSensitivity;
  }

  private void increaseVerticalAngle() {
    if (verticalAngle < 90) verticalAngle += rotationalSensitivity;
    if (verticalAngle > 90) verticalAngle = 90;
  }

  private void decreaseVerticalAngle() {
    if (verticalAngle > 0) verticalAngle -= rotationalSensitivity;
    if (verticalAngle < 0) verticalAngle = 0;
  }

  private void increaseHorizontalAngle() {
    if (horizontalAngle < 180) horizontalAngle += rotationalSensitivity;
    if (horizontalAngle > 180) horizontalAngle = 180;
  }

  private void decreaseHorizontalAngle() {
    if (horizontalAngle > 0) horizontalAngle -= rotationalSensitivity;
    if (horizontalAngle < 0) horizontalAngle = 0;
  }

  public void setVerticalAngle(double angle) {
    this.verticalAngle = angle;
  }

  public double getVerticalAngle() {
    return verticalAngle;
  }

  public void setHorizontalAngle(double angle) {
    this.horizontalAngle = angle;
  }

  public double getHorizontalAngle() {
    return horizontalAngle;
  } 

  public void setPosX(int posX) {
    this.posX = posX;
  }

  public int getPosX() {
    return posX;
  }

  public void setPosY(int posY) {
    this.posY = posY;
  }

  public int getPosY() {
    return posY;
  }

  public void setPosZ(int posZ) {
    this.posZ = posZ;
  }

  public int getPosZ() {
    return posZ;
  }

  public void setRotateClockwise(boolean rotateClockwise) {
    this.rotateClockwise = rotateClockwise;
  }

  public void setRotateCounterClockwise(boolean rotateCounterClockwise) {
    this.rotateCounterClockwise = rotateCounterClockwise;
  }

  public void setRotateUp(boolean rotateUp) {
    this.rotateUp = rotateUp;
  }

  public void setRotateDown(boolean rotateDown) {
    this.rotateDown = rotateDown;
  }

  public boolean getRotateClockwise() {
    return rotateClockwise;
  }

  public boolean getRotateCounterClockwise() {
    return rotateCounterClockwise;
  }

  public boolean getRotateUp() {
    return rotateUp;
  }

  public boolean getRotateDown() {
    return rotateDown;
  }

  public void setColor(int colorR, int colorG, int colorB) {
    if (colorR > 255 || colorR < 0 || colorG > 255 || colorG < 0 || colorB > 255 || colorB < 0) throw new IllegalArgumentException();
    this.colorR = colorR;
    this.colorG = colorG;
    this.colorB = colorB;
  }

  public void update() {
    if (rotateClockwise) this.decreaseHorizontalAngle();
    if (rotateCounterClockwise) this.increaseHorizontalAngle();
    if (rotateUp) this.increaseVerticalAngle();
    if (rotateDown) this.decreaseVerticalAngle();
  }
}