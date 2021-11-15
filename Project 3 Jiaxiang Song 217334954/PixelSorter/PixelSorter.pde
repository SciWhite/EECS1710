/* Jiaxiang Song 217334954 Project3
Press 1 2 3 to switch processing mode
reference: https:
processing.org/reference/IntList.html
Image reference：
https://cn.bing.com/images/search?view=detailV2&ccid=mZNzonJX&id=86C34A6074E69E67EBFBC9EA8F77D6C126766B20&thid=OIP-C.mZNzonJXwAf_BDGLqob3igHaHa&mediaurl=https%3A%2F%2Fuploadfile.huiyi8.com%2F2013%2F0814%2F20130814104134302.jpg&exph=700&expw=700&q=%e9%ab%98%e6%b8%85%e5%9b%be%e7%89%87&simid=608043957690118467&form=IRPRST&ck=2F4C0783ACCCD0B677504B58A170E659&selectedindex=26&vt=0&sim=11
*/
int weight = 1; // Weight of pixels
int step = 1; // Step
int thresholdlower = 50;
int thresholdupper = 200;
PImage img;

void setup() {
  size(700, 800,P2D);
  img = loadImage("background.jpg");
  noStroke();
  textAlign(CENTER);
  textSize(12);
}

void draw() {
  background(0);
  fill(255);
  switch(step) {// Draw each step
  case 1:
    drawStep1();
    break;
  case 2:
    drawStep2();
    break;
  case 3:
    drawStep3();
    break;
  default:
    drawStep3();
  }
}

void keyPressed() {
  if (key == '1') {
    step = 1;
  }
  if (key == '2') {
    step = 2;
  }
  if (key == '3') {
    step = 3;
  }
  
}
