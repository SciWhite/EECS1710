class Thing {
  PVector position;
  PImage img;
  int radius;
  int mark;
  int weight;
  int canHook;

  Thing(float x, float y) {
    position = new PVector(x, y);
    mark = 0;
    weight = 10;
    canHook = 1;
  }
  
  void update() {
  }
  
  void draw() {
    image(img, position.x, position.y);
  }
  
  void run() {
    update();
    draw();
  }
}
