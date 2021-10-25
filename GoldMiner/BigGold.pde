class BigGold extends Thing {
  
  BigGold(float x, float y) {
    super(x, y);
    img = loadImage("biggold.png");
    img.resize(80, 80);
    radius = 40;
    mark = 40;
    weight = 30;
  }
}
