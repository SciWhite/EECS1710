class Diamond extends Thing {
  
  Diamond(float x, float y) {
    super(x, y);
    img = loadImage("diamond.png");
    img.resize(30, 30);
    radius = 15;
    mark = 100;
    weight = 10;
  }
}
