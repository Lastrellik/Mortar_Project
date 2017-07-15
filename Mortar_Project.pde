import peasy.*;

int floorWidth = 1500;
int floorLength = 1080;
Cannon cannon;
Terrain terrain;

PeasyCam cam;
MiniMap miniMap;
int camLookAtX = 0;
int camLookAtY = -50;
int camLookAtZ = -1 * floorLength / 2;

void setup() {
  size(1000, 750, P3D);
  smooth();
  cam = new PeasyCam(this, camLookAtX, camLookAtY, camLookAtZ, 650);
  cam.setYawRotationMode();
  cannon = new Cannon();
  terrain = new Terrain(floorLength, floorWidth);
  cannon.setBaseColor(182, 155, 76);
  cannon.setBarrelColor(255, 255, 255);
  cannon.setProjectileColor(70, 102, 255);
  cannon.setVelocity_metersPerSecond(10);
  miniMap = new MiniMap(terrain, cannon);
  sphereDetail(10);
}

void draw() {
  background(0);
  setPerspective();
  cam.lookAt(camLookAtX, camLookAtY, camLookAtZ);
  cannon.drawCannon();
  terrain.drawTerrain();
  //cannon.setProjectileColor((int)random(0, 255), (int)random(0, 255), (int)random(0,255));
  drawHUD();
}

void setPerspective() {
  scale(1, -1);
  rotateX(-PI/2);
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
    //cannon.fire();
    cannon.autoFireOne();
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

void mouseClicked() {
  if (miniMap.containsPoint(mouseX, mouseY)) {
    miniMap.markTarget(mouseX, mouseY);
  }
}

void drawHUD() {
  cam.beginHUD();
  fill(57, 255, 20);
  textSize(15);
  text("Vertical Angle: "+ " " + cannon.getBarrel().getVerticalAngle() + " Horizontal Angle: " + cannon.getHorizontalAngle() + 
    "\nFramerate: " + frameRate, 10, 20);
  miniMap.drawMiniMap();
  cam.endHUD();
}