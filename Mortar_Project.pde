import peasy.*;

int floorWidth = 1000;
int floorLength = 800;
Cannon cannon;

PeasyCam cam;
int camLookAtX = 0;
int camLookAtY = -50;
int camLookAtZ = -1 * floorLength / 2;

void setup() {
  size(1920, 1080, P3D);
  smooth();
  cam = new PeasyCam(this, camLookAtX, camLookAtY, camLookAtZ, 500);
  cam.setYawRotationMode();
  cannon = new Cannon();
  cannon.setBaseColor(182, 155, 76);
  sphereDetail(10);
}

void draw() {
  background(0);
  setPerspective();
  cam.lookAt(camLookAtX, camLookAtY, camLookAtZ);
  drawFloor();
  fill(0);
  cannon.drawCannon();;
  cannon.setProjectileColor(70, 102, 255);
  //cannon.setProjectileColor((int)random(0, 255), (int)random(0, 255), (int)random(0,255));
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

void mouseClicked(){
  println("MouseX: " + mouseX + " MouseY: " + mouseY);
  cannon.addTarget(new Target(mouseX, mouseY));
}

void drawHUD() {
  cam.beginHUD();
  fill(57, 255, 20);
  textSize(15);
  text("Vertical Angle: "+ " " + cannon.getBarrel().getVerticalAngle() + " Horizontal Angle: " + cannon.getHorizontalAngle() + 
    "\nFramerate: " + frameRate, 10, 20);
  cam.endHUD();
}