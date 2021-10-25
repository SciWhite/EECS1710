class SmallGold extends Thing {
  
  SmallGold(float x, float y) {
    super(x, y);
    img = loadImage("smallgold.png");
    img.resize(50, 50);
    radius = 25;
    mark = 10;
    weight = 10;
  }
}
