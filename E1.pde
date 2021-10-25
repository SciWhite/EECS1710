int clockX, clockY;
float secondsRadius = 0;
float minutesRadius = 0;
float hoursRadius = 0;
float clockDiameter = 0;

void setup() {
size(800, 600, P2D);
strokeWeight(2);

int radius = min(width, height) / 2;
secondsRadius = radius * 0.72;
minutesRadius = radius * 0.60;
hoursRadius = radius * 0.50;
clockDiameter = radius * 1.8;
clockX = width / 2;
clockY = height / 2;
}

void draw() {
background(255);
fill(0);
noStroke();
ellipse(clockX, clockY, clockDiameter, clockDiameter);

float s = map(second(), 0, 60, 0, TWO_PI)- HALF_PI;
float m = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI)- HALF_PI;
float h = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2)- HALF_PI;

stroke(255,80,80);
strokeWeight(1);
line(clockX, clockY, clockX + cos(s) * secondsRadius, clockY + sin(s) * secondsRadius);
strokeWeight(1);
line(clockX, clockY, clockX + cos(m) * minutesRadius, clockY + sin(m) * minutesRadius);
strokeWeight(1);
line(clockX, clockY, clockX + cos(h) * hoursRadius, clockY + sin(h) * hoursRadius);

beginShape(POINTS);
for (int a = 0; a < 360; a+=6) {
float angle = radians(a);
float x = clockX + cos(angle) * secondsRadius;
float y = clockY + sin(angle) * secondsRadius;

stroke(180,a%255,a%255);
fill(180,a%255,a%255);
ellipse(x, y, (((a%30)==0)?10:2), (((a%30)==0)?10:2));
}
endShape();
}
