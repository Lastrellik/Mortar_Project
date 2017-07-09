import peasy.*;

int floorWidth = 400;
int floorLength = 800;
Cannon cannon;

boolean projectileFired = false;
PVector projectilePositionVector;
PVector projectileVelocityVector;
float projectileRadius = 1;
float projectileVelocity = 10;

PVector gravity = new PVector(0, 0, -.25);

PeasyCam cam;
int camLookAtX = 0;
int camLookAtY = -50;
int camLookAtZ = -1 * floorLength / 2;

void setup() {
  size(1920, 1080, P3D);
  smooth();
  cam = new PeasyCam(this, camLookAtX, camLookAtY, camLookAtZ, 350);
  cam.setYawRotationMode();
  cannon = new Cannon();
}

void draw() {
  background(100);
  setPerspective();
  cam.lookAt(camLookAtX, camLookAtY, 0);
  drawFloor();
  fill(0);
  pushMatrix();
  translate(0, 0, 100);
  sphere(10);
  translate(0, 100, -100);
  fill(255);
  sphere(5);
  translate(100, -100, 0);
  fill(155);
  sphere(3);
  popMatrix();
  cannon.drawCannon();
  //updateProjectile();
  drawHUD();
}

void setPerspective() {
  scale(1, -1);
  rotateX(-PI/2);
  /*rotateX(PI/2);
  rotateZ(PI);
  rotateY(PI);*/
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
  } //else if (key == ' ') {
   // fire();
 // }
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
/*
void fire() {
  projectilePositionVector = new PVector(cos(radians(cannonHorizontalAngle)) * Math.abs(cos(radians(cannonVerticalAngle))), sin(radians(cannonHorizontalAngle)) * cos(radians(cannonVerticalAngle)), sin(radians(cannonVerticalAngle)));
  projectileVelocityVector = new PVector(projectilePositionVector.x, projectilePositionVector.y, projectilePositionVector.z);
  projectileVelocityVector.mult(projectileVelocity);
  projectileFired = true;
}

void updateProjectile() {
    float endOfCannonX = (cannonLength - projectileRadius / 2) * (cos(radians(cannonHorizontalAngle)) * cos(radians(cannonVerticalAngle)));
    float endOfCannonY = (cannonLength - projectileRadius / 2) * (cos(radians(cannonVerticalAngle)) * sin(radians(cannonHorizontalAngle)));
    float endOfCannonZ = (cannonLength - projectileRadius / 2) * sin(radians(cannonVerticalAngle)) + baseHeight * 2;
  if (projectileFired) {
    if (projectilePositionVector.z >= - endOfCannonZ + 1) {
      projectilePositionVector.add(projectileVelocityVector);
      projectileVelocityVector.add(gravity);
    } else {
      projectileFired = false; 
    }
    pushMatrix();
    translate(endOfCannonX + projectilePositionVector.x, endOfCannonY + projectilePositionVector.y, endOfCannonZ + projectilePositionVector.z);
    sphere(projectileRadius);
    popMatrix();
  }
}*/

void drawHUD() {
  cam.beginHUD();
  textSize(15);
  text(cannon.getBarrel().getVerticalAngle() + " " + cannon.getBase().getHorizontalAngle(), 10, 20);
  cam.endHUD();
}