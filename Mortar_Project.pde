import peasy.*;

int floorWidth = 400;
int floorLength = 800;
Cannon cannon;




PeasyCam cam;
int camLookAtX = 0;
int camLookAtY = -50;
int camLookAtZ = 0;

void setup() {
  size(1920, 1080, P3D);
  smooth();
  cam = new PeasyCam(this, camLookAtX, camLookAtY, camLookAtZ, 50);
  cam.setYawRotationMode();
  cannon = new Cannon();
  sphereDetail(10);
}

void draw() {
  background(100);
  setPerspective();
  cam.lookAt(camLookAtX, camLookAtY, camLookAtZ);
  drawFloor();
  fill(0);
  cannon.drawCannon();
  drawHUD();
}

void setPerspective() {
  scale(1, -1);
  rotateX(-PI/2);
}

void drawFloor() {
  fill(51);
  noStroke();
  rect(-floorWidth / 2, 0, floorWidth, floorLength);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      cannon.rotateCounterClockwise(true);
    } else if (keyCode == RIGHT) {
      cannon.rotateClockwise(true);
    } else if (keyCode == UP) {
      cannon.increaseBarrelAngle(true);
    } else if (keyCode == DOWN) {
      cannon.decreaseBarrelAngle(true);
    }
  } else if (key == ' ') {
    cannon.fire();
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      cannon.rotateCounterClockwise(false);
    } else if (keyCode == RIGHT) {
      cannon.rotateClockwise(false);
    } else if (keyCode == UP) {
      cannon.increaseBarrelAngle(false);
    } else if (keyCode == DOWN) {
      cannon.decreaseBarrelAngle(false);
    }
  }
}

void drawHUD() {
  cam.beginHUD();
  textSize(15);
  text(cannon.getBarrel().getVerticalAngle() + " " + cannon.getHorizontalAngle(), 10, 20);
  cam.endHUD();
}