abstract class StationaryObject {

  float verticalAngle = 0;
  float horizontalAngle = 90;
  float rotationalSensitivity = .5;
  int posX, posY, posZ;

  public void setRotationSensitivity(float sensitivity) {
    if (sensitivity < 0) throw new IllegalArgumentException();
    this.rotationalSensitivity = sensitivity;
  }

  public float getRotationSensitivity() {
    return rotationalSensitivity;
  }

  public void increaseVerticalAngle() {
    if (verticalAngle < 90) verticalAngle += rotationalSensitivity;
  }

  public void descreaseVerticalAngle() {
    if (verticalAngle > 0) verticalAngle -= rotationalSensitivity;
  }

  public void increaseHorizontalAngle() {
    if (horizontalAngle < 180) horizontalAngle += rotationalSensitivity;
  }

  public void decreaseHorizontalAngle() {
    if (horizontalAngle > 0) verticalAngle -= rotationalSensitivity;
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
}