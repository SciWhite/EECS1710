class SmallStone extends Thing {
  
  SmallStone(float x, float y) {
    super(x, y);
    img = loadImage("stone.png");
    img.resize(50, 50);
    radius = 25;
    mark = 1;
    weight = 10;
  }
}
