import processing.video.*;

Movie[] videos;
int current = 0;
int startMillis;
int switchInterval = 3000;

void setup() {
  size(1430, 870);

  videos = new Movie[5];
  videos[0] = new Movie(this, "IMG_2887.mov");
  videos[1] = new Movie(this, "Sin título.mov");
  videos[2] = new Movie(this, "IMG_2106.mov");
  videos[3] = new Movie(this, "IMG_2107.mov");
  videos[4] = new Movie(this, "IMG_2811.mov");

  videos[current].play();
  startMillis = millis();
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  background(0);

  Movie m = videos[current];
  image(m, 0, 0, width, height);

  // --- EFECTOS DE GLITCH ---
  loadPixels();
  for (int y = 0; y < height; y++) {
    // líneas intermitentes
    if (y % 10 == 0) {
      int offset = int(random(-20, 20));
      for (int x = 0; x < width; x++) {
        int i = y * width + x;
        int newX = (x + offset + width) % width;
        int newIndex = y * width + newX;
        if (newIndex < pixels.length) {
          pixels[i] = pixels[newIndex];
        }
      }
    }
    // aberración cromática ligera
    for (int x = 0; x < width; x++) {
      int i = y * width + x;
      float r = red(pixels[i]);
      float g = green(pixels[(i + 3) % pixels.length]);
      float b = blue(pixels[(i + 6) % pixels.length]);
      pixels[i] = color(r, g, b);
    }
  }
  updatePixels();

  // --- RUIDO ANALÓGICO (snow TV) ---
  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    if (random(1) < 0.05) { // 5% de los píxeles se corrompen
      float noiseVal = random(255);
      pixels[i] = color(noiseVal);
    }
  }
  updatePixels();

  // --- ROTACIÓN DE VIDEOS CADA 3 SEGUNDOS ---
  if (millis() - startMillis > switchInterval) {
    m.pause();
    current = (current + 1) % videos.length;
    videos[current].play();
    startMillis = millis();
  }

  // --- DETENER CUANDO TODOS TERMINEN ---
  boolean allFinished = true;
  for (int i = 0; i < videos.length; i++) {
    if (videos[i].time() < videos[i].duration()) {
      allFinished = false;
      break;
    }
  }
  if (allFinished) {
    println("Todos los videos han terminado.");
    noLoop();
  }
}
