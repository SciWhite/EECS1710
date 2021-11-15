void drawStep1() {
  image(img, 0, 0);
  text("Step 1\n Intact image", width/2, height - 70);
}

void drawStep2() {
  thresholdlower = int(map(mouseX, 0, width, 0, 255));
  thresholdupper = int(map(mouseY, 0, height, 0, 255));
  color[][] lines = new color[int(width/weight)][int(height/weight)];

  for (int i=0; i<img.width; i+=weight) {
    for (int j=0; j<img.height; j+=weight) {
      if (i + j*img.width > img.pixels.length) continue;
      color c = img.pixels[i + j*img.width];
      if (int(i/weight) >= lines.length || int(j/weight) >= lines[0].length) continue;
      if (brightness(c) < thresholdlower || brightness(c) > thresholdupper) {
        lines[int(i/weight)][int(j/weight)] = color(0);
      } else {
        lines[int(i/weight)][int(j/weight)] = color(255);
      }
    }
  }
  for (int i=0; i<width/weight; i++) {
    for (int j=0; j<height/weight; j++) {
      fill(lines[i][j]);
      rect(i*weight, j*weight, weight, weight);
    }
  }
  fill(255);
  text("Step 2\n Decide intact pixels and to-be-sorted pixels\nIf pixel brightess <= "+thresholdlower+" and >= "+thresholdupper+"\n mark them as intact pixels and fill with black, and the remaining to white.", width/2, height - 70);
}

void drawStep3() {
  thresholdlower = int(map(mouseX, 0, width, 0, 255));
  thresholdupper = int(map(mouseY, 0, height, 0, 255));
  color[][] lines = new color[int(width/weight)][int(height/weight)];
  color[][] thresholdlines = new color[int(width/weight)][int(height/weight)];

  for (int i=0; i<img.width; i+=weight) {
    for (int j=0; j<img.height; j+=weight) {
      if (i + j*img.width > img.pixels.length) continue;
      color c = img.pixels[i + j*img.width];
      if (int(i/weight) >= lines.length || int(j/weight) >= lines[0].length) continue;
      lines[int(i/weight)][int(j/weight)] = c;
      if (brightness(c) < thresholdlower || brightness(c) > thresholdupper) {
        thresholdlines[int(i/weight)][int(j/weight)] = color(0);
      } else {
        thresholdlines[int(i/weight)][int(j/weight)] = color(255);
      }
    }
  }
  // Sort pixels
  for (int i=0; i<width/weight; i++) {
    IntList colors = new IntList(); // reference: https://processing.org/reference/IntList.html
    boolean metBlack = false;
    for (int j=0; j<height/weight; j++) {
      if (brightness(thresholdlines[i][j]) == 0) {
        if (!metBlack) {
          metBlack = true;
        } else {
          metBlack = false;
          colors.sort();
          if (colors.size() <= 0) continue;
          for (int k=0; k<colors.size(); k++) {
            lines[i][j-1-colors.size()+k] = colors.get(k);
          }
          colors.clear();
        }
      } else {
        colors.append(lines[i][j]);
      }
    }
  }

  for (int i=0; i<width/weight; i++) {
    for (int j=0; j<height/weight; j++) {
      fill(lines[i][j]);
      rect(i*weight, j*weight, weight, weight);
    }
  }
  fill(0);
  rect(0, height-100, width, 100);
  fill(255);
  text("Step 3\nFor each vertical line, sort pixels between two black pixels in ascending order", width/2, height - 70);
}
