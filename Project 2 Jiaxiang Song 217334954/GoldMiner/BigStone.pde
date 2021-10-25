class BigStone extends Thing {
  
  BigStone(float x, float y) {
    super(x, y);
    img = loadImage("stone.png");
    img.resize(80, 80);
    radius = 40;
    mark = 4;
    weight = 30;
  }
}
