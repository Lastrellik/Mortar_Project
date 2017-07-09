abstract class StationaryObject {

  float verticalAngle = 0;
  float horizontalAngle = 0;
  float rotationalSensitivity = .5;
  boolean rotateClockwise = false, rotateCounterClockwise = false, rotateUp = false, rotateDown = false;
  int posX, posY, posZ;

  public void setRotationSensitivity(float sensitivity) {
    if (sensitivity < 0) throw new IllegalArgumentException();
    this.rotationalSensitivity = sensitivity;
  }

  public float getRotationSensitivity() {
    return rotationalSensitivity;
  }

  private void increaseVerticalAngle() {
    if (verticalAngle < 90) verticalAngle += rotationalSensitivity;
  }

  private void decreaseVerticalAngle() {
    if (verticalAngle > 0) verticalAngle -= rotationalSensitivity;
  }

  private void increaseHorizontalAngle() {
    if (horizontalAngle < 180) horizontalAngle += rotationalSensitivity;
  }

  private void decreaseHorizontalAngle() {
    if (horizontalAngle > 0) horizontalAngle -= rotationalSensitivity;
  }

  public void setVerticalAngle(float angle) {
    this.verticalAngle = angle;
  }

  public float getVerticalAngle() {
    return verticalAngle;
  }

  public void setHorizontalAngle(float angle) {
    this.horizontalAngle = angle;
  }

  public float getHorizontalAngle() {
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

  public void update() {
    if (rotateClockwise) this.decreaseHorizontalAngle();
    if (rotateCounterClockwise) this.increaseHorizontalAngle();
    if (rotateUp) this.increaseVerticalAngle();
    if (rotateDown) this.decreaseVerticalAngle();
  }
}