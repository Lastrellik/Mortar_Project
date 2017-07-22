import peasy.*;

private int floorWidth = 1500;
private int floorLength = 1500;
private Cannon cannon;
private Terrain terrain;
private double projectileVelocity = 20;
private boolean randomProjectileColor = false;

PeasyCam cam;
MiniMap miniMap;
int camLookAtX = 0;
int camLookAtY = -50;
int camLookAtZ = -1 * floorLength / 2;

void setup() {
  //size(1500, 845, P3D);
  fullScreen(P3D);
  smooth();
  cam = new PeasyCam(this, camLookAtX, camLookAtY, camLookAtZ, 850);
  cam.setYawRotationMode();
  cannon = new Cannon();
  terrain = new Terrain(floorLength, floorWidth);
  terrain.setWindDirectionInDegrees(180);
  cannon.setBaseColor(182, 155, 76);
  cannon.setBarrelColor(255, 255, 255);
  cannon.setProjectileColor(70, 102, 255);
  cannon.setVelocity_metersPerSecond(projectileVelocity);
  cannon.getBarrel().setRadius(2);
  cannon.getBarrel().setRotationSensitivity(.5);
  cannon.setRotationSensitivity(.5);
  miniMap = new MiniMap(terrain);
  sphereDetail(10);
}

void draw() {
  background(0);
  setPerspective();
  cam.lookAt(camLookAtX, camLookAtY, camLookAtZ);
  cannon.drawCannon();
  terrain.drawTerrain();
  if(randomProjectileColor) cannon.setProjectileColor((int)random(0, 255), (int)random(0, 255), (int)random(0,255));
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
    cannon.fire();
  } else if (key == 'a'){
    cannon.autoFireOne(); 
  } else if (key == 'r'){
    randomProjectileColor = !randomProjectileColor; 
  } else if (key == 'w'){
    cannon.setVelocity_metersPerSecond(cannon.getVelocity_metersPerSecond() + 1); 
  } else if (key == 's'){
    cannon.setVelocity_metersPerSecond(cannon.getVelocity_metersPerSecond() - 1); 
  } else if (key == 'e'){
    cannon.getBarrel().setRadius(cannon.getBarrel().getRadius() + 1); 
  } else if (key == 'd'){
    cannon.getBarrel().setRadius(cannon.getBarrel().getRadius() - 1); 
  } else if (key == 't') {
    cannon.setRotationSensitivity(cannon.getRotationSensitivity() + .1); 
    cannon.getBarrel().setRotationSensitivity(cannon.getRotationSensitivity() + .1);
  } else if (key == 'g') {
    cannon.setRotationSensitivity(cannon.getRotationSensitivity() - .1); 
    cannon.getBarrel().setRotationSensitivity(cannon.getRotationSensitivity() - .1);
  } else if (key == 'c') {
    cannon.clearProjectiles();
    cannon.clearTargets();
    terrain.clearTargets();
  } else if (key == 'm') {
    cannon.setRapidFire(true); 
  } else if (key == 'b') {
    cannon.setBounce(!cannon.getBounce()); 
  } else if (key == 'y') {
    terrain.setRotateCounterClockwise(true); 
  } else if (key == 'h') {
    terrain.setRotateClockwise(true);
  } else if (key == 'u') {
    terrain.setWindMagnitude(terrain.getWindMagnitude() + .001); 
  } else if (key == 'j') {
    terrain.setWindMagnitude(terrain.getWindMagnitude() - .001); 
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
  } else if (key == 'm'){
    cannon.setRapidFire(false); 
  } else if (key == 'y'){
    terrain.setRotateCounterClockwise(false); 
  } else if (key == 'h') { 
    terrain.setRotateClockwise(false); 
  }
}

void mouseClicked() {
  if (miniMap.containsPoint(mouseX, mouseY)) {
    miniMap.markTarget(mouseX, mouseY);
    cannon.updateTargets();
  }
}

void drawHUD() {
  cam.beginHUD();
  fill(57, 255, 20);
  textSize(20);
  text("Vertical Angle: "+ " " + Math.round(cannon.getBarrel().getVerticalAngle() * 100) / 100.0 + " (adjust with up/down)" +
  "\nHorizontal Angle: " + Math.round(cannon.getHorizontalAngle() * 100) / 100.0 + " (adjust with left/right)" + 
  "\nProjectile Velocity: " +Math.round(cannon.getVelocity_metersPerSecond()) + " m/s (adjust with w/s)" + 
  "\nWind Direction: " + Math.round(terrain.getWindDirectionInDegrees()) + " degrees (adjust with y/h)" + 
  "\nWind Magnitude: " + Math.round(terrain.getWindMagnitude() * 1000) / 1000.0 + " (adjust with u/j)" + 
  "\nRotation Sensitivity: " + Math.round(cannon.getRotationSensitivity() * 100) / 100.0 + " (adjust with t/g)" + 
  "\nBarrel Radius: " + Math.round(cannon.getBarrel().getRadius() * 100) / 100.0 + " cm (adjust with e/d)" +
  "\nFrameRate: " + Math.round(frameRate) +
  "\nPress C to clear \nPress R to randomize projectile color \nPress M to rapid fire\nPress A to auto fire\nPress Space to Fire\nPress B to toggle bounce", 10, 20);
  miniMap.drawMiniMap();
  cam.endHUD();
}