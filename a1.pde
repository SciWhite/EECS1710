int numPacmans = 10;

Pacman[] Pacmans = new Pacman[numPacmans];

void setup() { 
  size(800, 600, P2D);
  
   for (int i=0; i<Pacmans.length; i++) {
    Pacmans[i] = new Pacman(random(width), random(height)); }}
  
  void draw() {
  background(127);
  
  for (int i=0; i<Pacmans.length; i++) {
    Pacmans[i].run();
  }
}

class Pacman {
  PVector position, target;
  PImage face;
 
  int PacmanChoice;
  boolean debug = true;
  boolean isHunting = false;
  boolean alive = true;
  float margin = 50;
  
  float triggerDistance1 = 100;
  float triggerDistance2 = 25;
  float movementSpeed = 0.05;
  
  Pacman(float x, float y) {
    position = new PVector(x, y);
    pickRandomTarget();
    face = loadImage("pacman.png");
    face.resize(face.width/27, face.height/27);
    
}

void update() {
    PVector mousePos = new PVector(mouseX, mouseY);
    isHunting = position.dist(mousePos) < triggerDistance1;
  

  if(isHunting){
  movementSpeed = 0.1;
}
  //if (isHunting && position.dist(target) < 10) {
      Pacmans[PacmanChoice].alive = false; 
  pickPacmanTarget();
  }
//}

void draw() {
  if (alive) {
    ellipseMode(CENTER);
    rectMode(CENTER);
    imageMode(CENTER);
  }
  
    image(face, position.x, position.y);
    if (debug) {
      noFill();
      stroke(0, 255, 0);
      ellipse(position.x, position.y, triggerDistance1*2, triggerDistance1*2);
      ellipse(position.x, position.y, triggerDistance2*2, triggerDistance2*2);
      //line(target.x, target.y, position.x, position.y);
      stroke(255, 0, 0);
      //rect(target.x, target.y, 10, 10);
    }
}

 void run() {
    update();
    draw();
  } 
  void pickRandomTarget() {
    target = new PVector(random(margin, width-margin), random(margin, height-margin));
  }
 void pickPacmanTarget() {
    PacmanChoice = int(random(Pacmans.length));
    if (Pacmans[PacmanChoice].alive) {
      target = Pacmans[PacmanChoice].position;
    }
  }
}
