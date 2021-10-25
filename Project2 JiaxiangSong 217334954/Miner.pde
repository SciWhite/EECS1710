class Miner {
  PVector position;
  PImage minerImg;
  Hook hook;

  Miner(float x, float y) {
    position = new PVector(x, y);
    minerImg = loadImage("miner.png");
    minerImg.resize(100, 100);
    hook = new Hook(x - 24, y + 10, 0);
  }
  
  void update() {
  }
  
  void draw() {
    image(minerImg, position.x, position.y);
    fill(255);
    textSize(15);
    text("Mark: " + hook.mark, position.x + 50, position.y);
  }
  
  void run() {
    update();
    draw();
    hook.run();
  }
}
