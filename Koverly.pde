import ddf.minim.*;

Minim minim;
AudioPlayer song;
AudioInput mic;

int cols, rows;
int w = 1200;
int h = 2400;
int scale = 60;
int bufferSize = 1024;

void setup() {
  size(800, 800, P3D);
  
  cols = w/scale;
  rows = h/scale;
  
  minim = new Minim(this);
  song = minim.loadFile("demo.mp3", 1024);
  mic = minim.getLineIn();
  //song.loop();
}

void draw() {
  background(255);
  ortho(-width/2, width/2, -height/2, height/2);
  translate(width/2, 0);
  stroke(255);
  rotateY(PI/4);
  rotateX(-PI/6);
  for (int i = 0; i < mic.bufferSize() - 1; i++) {
    int y = height/2;
    int amp1 = int(map(mic.left.get(i), -1, 1, -y,  y));
    int amp2 = int(map(mic.left.get(i+1), -1, 1, -y, y));
    thickLine(i, y + amp1, i+1, y + amp2, 20);
  }
  
  fill(0);
  for (int y = 0; y < rows; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x*scale, y*scale, -50);
      vertex(x*scale, (y+1)*scale, -50);
    }
    endShape();
  }
}

void thickLine(int x1, int y1, int x2, int y2, int thickness) {
  for (int i = 0; i < thickness; i++) {
    line(x1, y1 + i, x2, y2 + i);
  }
}
