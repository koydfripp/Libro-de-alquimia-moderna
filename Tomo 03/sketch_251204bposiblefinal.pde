import processing.serial.*;
import oscP5.*;
import netP5.*;

Serial arduino;
OscP5 osc;
NetAddress sonicPi;

int lastSendTime = 0;
int sendInterval = 5000; // milisegundos entre envíos

float micValor = 0;
boolean modoExplosivo = false;

// Variables para persistencia del modo explosivo
int explosivoStart = 0;
int explosivoDuration = 0;

void setup() {
  size(1450, 900);
  colorMode(HSB, 360, 100, 100);
  noStroke();
  frameRate(60);

  String[] ports = Serial.list();
  println("Puertos disponibles:");
  for (int i = 0; i < ports.length; i++) {
    println(i + ": " + ports[i]);
  }

  println("Conectando a: " + ports[2]); 
  arduino = new Serial(this, ports[2], 9600);
  arduino.bufferUntil('\n');

  osc = new OscP5(this, 12000); 
  sonicPi = new NetAddress("127.0.0.1", 4560); 
}

void draw() {
  loadPixels();

  // Activar modo explosivo si micValor supera umbral y no está activo
  if (!modoExplosivo && micValor > 500) {
    modoExplosivo = true;
    explosivoStart = millis();
    explosivoDuration = int(random(100, 2500)); 
  }

  // Desactivar modo explosivo si ya pasó el tiempo
  if (modoExplosivo && millis() - explosivoStart > explosivoDuration) {
    modoExplosivo = false;
  }

  float factor = map(micValor, 0, 1023, 0.02, 0.08);
  float tiempo = frameCount * factor * 2;

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float n = noise(x * factor, y * factor, tiempo);

      float h = modoExplosivo ? map(n, 0, 1, 150, 360) : map(n, 0, 1, 0, 170);
      float s = modoExplosivo ? map(n, 0, 2, 60, 20) : map(micValor, 0, 1023, 100, 40);
      float b = modoExplosivo ? map(n, 0, 2, 60, 20) : map(micValor, 0, 1023, 100, 50);

      pixels[x + y * width] = color(h, s, b);
    }
  }
  updatePixels();
}

void serialEvent(Serial arduino) {
  try {
    String data = arduino.readStringUntil('\n');
    if (data != null) {
      data = trim(data);
      micValor = Float.parseFloat(data);
      println("Micrófono/LDR: " + micValor);

      int currentTime = millis();
      if (currentTime - lastSendTime > sendInterval) {
        OscMessage msg = new OscMessage("/ldr");
        msg.add(micValor);
        osc.send(msg, sonicPi);
        lastSendTime = currentTime;
      }
    }
  } catch (Exception e) {
    println("⚠️ Error en serialEvent: " + e.getMessage());
    arduino.clear();
    arduino.bufferUntil('\n');
  }
}
