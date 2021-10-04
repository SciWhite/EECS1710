/**
Jiaxiang Song 217334954 lab3

Description:
Left-click and drag Pac-Man to eat the ghost.
And the ghosts will automatically avoid Pac-Man.

Reference:
https://blog.csdn.net/john_bian/article/details/52818599
https://github.com/eecs17xx/eecs1710-2021f/tree/main/Week04/Background03
https://github.com/eecs17xx/eecs1710-2021f/tree/main/Week04/Creature01
https://github.com/eecs17xx/eecs1710-2021f/tree/main/Week04/Creature02
https://github.com/eecs17xx/eecs1710-2021f/tree/main/Week04/Creature03
processing.org/reference

Image reference
https://www.bing.com/images/search?view=detailV2&ccid=1i4TgzI0&id=EB1AFF64FC341F2CA88463930C0E724CCF5D6818&thid=OIP.1i4TgzI0q4Sf8BfjJkysewHaHa&mediaurl=https%3a%2f%2fpngimg.com%2fuploads%2fpacman%2fpacman_PNG87.png&cdnurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.d62e13833234ab849ff017e3264cac7b%3frik%3dGGhdz0xyDgyTYw%26pid%3dImgRaw%26r%3d0&exph=2000&expw=2000&q=Pac-Man&simid=608002464003479497&FORM=IRPRST&ck=5EF0EC9C7CFF4235BE8174B03F7ED725&selectedIndex=1

https://cn.bing.com/images/search?view=detailV2&ccid=nj5lHycI&id=751FDAFF10E2AD6C7908E9978328580070E40684&thid=OIP.nj5lHycIss04lCslsAxubgHaEo&mediaurl=https%3a%2f%2ftse1-mm.cn.bing.net%2fth%2fid%2fR-C.9e3e651f2708b2cd38942b25b00c6e6e%3frik%3dhAbkcABYKIOX6Q%26riu%3dhttp%253a%252f%252fwallpapercave.com%252fwp%252fEyaJ8qi.jpg%26ehk%3dCGABGBMHg0DTOHeqJZ691sDYBPacWS7eepGdK7VUrYM%253d%26risl%3d%26pid%3dImgRaw%26r%3d0&exph=1200&expw=1920&q=pac-man+background&simid=608048445914897275&FORM=IRPRST&ck=728D6F4EBE41A7534AF7D1E6E56CC8E0&selectedIndex=4&ajaxhist=0&ajaxserp=0

https://cn.bing.com/images/search?view=detailV2&ccid=Kf7cxbO1&id=BB4F801FEA5810A97D120F9F74F4928CB65BF989&thid=OIP.Kf7cxbO1gQTJCZqgLqannwEsEf&mediaurl=https%3a%2f%2fpngimg.com%2fuploads%2fpacman%2fpacman_PNG61.png&exph=1228&expw=1280&q=pac-man&simid=608046985630790737&FORM=IRPRST&ck=387823E238F3B3EA35F30E211B55B7A8&selectedIndex=45
*/

int numPacmans = 1;
int numGhosts = 20;
int alivedGhosts = numGhosts;
PImage background;

Pacman[] Pacmans = new Pacman[numPacmans];
Ghost[] Ghosts = new Ghost[numGhosts];

void setup() { 
  size(800, 600, P2D);
  
  background = loadImage("background.jpg");

  for (int i=0; i<Pacmans.length; i++) {
    Pacmans[i] = new Pacman(); 
  }

  for (int i=0; i<Ghosts.length; i++) {
    Ghosts[i] = new Ghost(); 
  }
}

void draw() {
  background(255);
  image(background, 400, 300);
  for (int i=0; i<Pacmans.length; i++) {
    Pacmans[i].update();
  }
  for (int i=0; i<Ghosts.length; i++) {
    if(Ghosts[i].isAlive())
    {
      Ghosts[i].update();
      for (int j=0; j<Pacmans.length; j++) {
        Ghosts[i].setAlive(Pacmans[j].getPos());
      }
    }
  }

  for (int i=0; i<Pacmans.length; i++) {
    Pacmans[i].draw();
  }
  alivedGhosts = 0;
  for (int i=0; i<Ghosts.length; i++) {
    if(Ghosts[i].isAlive())
    {
      Ghosts[i].draw();
      alivedGhosts += 1;
    }
  }
  
  if(alivedGhosts == 0)
  {
    fill(160, 0, 0);
    textSize(50);
    text("Congratulations!", 200, 300);
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
  PVector preMousePos;
  boolean isPressed = false;

  float triggerDistance1 = 100;
  float triggerDistance2 = 25;
  float movementSpeed = 0.05;

  Pacman() {
    position = new PVector(random(margin, width-margin), random(margin, height-margin));
    pickRandomTarget();
    face = loadImage("pacman.png");
    face.resize(face.width/27, face.height/27);
  }
  
  PVector getPos()
  {
    return position;
  }
  
  float distance(PVector pos)
  {
    return sqrt((pos.x - position.x) * (pos.x - position.x) + (pos.y - position.y) * (pos.y - position.y));
  }

  void update() {
    PVector mousePos = new PVector(mouseX, mouseY);
    if(!isPressed && mousePressed && distance(mousePos) < margin)
    {
      preMousePos = mousePos;
      isPressed = true;
    }
    if(!mousePressed)
    {
      isPressed = false;
    }
    if(isPressed)
    {
      position.x += mouseX - preMousePos.x;
      position.y += mouseY - preMousePos.y;
    }
    isHunting = position.dist(mousePos) < triggerDistance1;

    if(isHunting) {
      movementSpeed = 0.1;
    }
    //if (isHunting && position.dist(target) < 10) {
    Pacmans[PacmanChoice].alive = false; 
    pickPacmanTarget();
    preMousePos = mousePos;
  }

  void draw() {
    if (alive) {
      ellipseMode(CENTER);
      rectMode(CENTER);
      imageMode(CENTER);
    }

    image(face, position.x, position.y);
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

class Ghost {
  PVector position, target;
  PImage face;

  int PacmanChoice;
  boolean debug = true;
  boolean isHunting = false;
  boolean alive = true;
  float margin = 40;

  float triggerDistance1 = 100;
  float triggerDistance2 = 25;
  float movementSpeed = 0.05;

  Ghost() {
    position = new PVector(random(margin, width-margin), random(margin, height-margin));
    pickRandomTarget();
    face = loadImage("pacman_PNG61.png");
    face.resize(face.width/27, face.height/27);
  }
  
  float distance(PVector pos)
  {
    return sqrt((pos.x - position.x) * (pos.x - position.x) + (pos.y - position.y) * (pos.y - position.y));
  }

  void update() {
    PVector mousePos = new PVector(mouseX, mouseY);
    
    //position = mousePos;
    isHunting = position.dist(mousePos) < triggerDistance1;

    if(isHunting) {
      movementSpeed = 0.1;
    }
    if(distance(Pacmans[0].position) < 90)
    {
      target = new PVector(Pacmans[0].position.x - (Pacmans[0].position.x - position.x) * 4, Pacmans[0].position.y - (Pacmans[0].position.y - position.y) * 4);
      if(target.x < margin)
        target.x = margin;
      if(target.y < margin)
        target.y = margin;
      if(target.x > width - margin)
        target.x = width - margin;
      if(target.y > height - margin)
        target.y = height - margin;
    }
    if(position.x == target.x && position.y == target.y)
    {
      pickRandomTarget();
    }
    else if(distance(target) < 5)
    {
      position = target;
    }
    else
    {
      float dis = distance(target);
      position.x += (target.x - position.x) * 5 / dis;
      position.y += (target.y - position.y) * 5 / dis;
    }
  }
  
  void setAlive(PVector pos)
  {
    if(distance(pos) < 45)
    {
      alive = false;
    }
  }

  void draw() {
    if (alive) {
      ellipseMode(CENTER);
      rectMode(CENTER);
      imageMode(CENTER);
    }

    image(face, position.x, position.y);
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
  
  boolean isAlive()
  {
    return alive;
  }
}
