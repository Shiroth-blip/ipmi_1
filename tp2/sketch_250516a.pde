PImage[] imgs = new PImage[3];
PImage imgInicio;
PFont font;
int screen = -1; // -1: inicio, 0-2: pantallas, 3: final
int lastChangeTime = 0;
int interval = 4000; // 4 segundos por pantalla

float textX = 0;
float textSpeed = 2;
boolean movingRight = true;

float textAlpha = 0;
boolean fadingIn = true;

float scaleVal = 1;
float scaleSpeed = 0.02f;
boolean scaleUp = true;

void setup() {
  size(640, 480);
  
  // Cargar imágenes, asegurate que estén en carpeta 'data'
  imgInicio = loadImage("inicio.jpg");
  imgs[0] = loadImage("img1.jpg");
  imgs[1] = loadImage("img2.jpg");
  imgs[2] = loadImage("img3.jpg");
  
  font = createFont("Arial", 32);
  textFont(font);
  textAlign(CENTER, CENTER);
  lastChangeTime = millis();
  textX = width / 2;
}

void draw() {
  background(0);

  fill(255, 204, 0); // Amarillo para todos los textos

  if (screen == -1) {
    // Pantalla inicial con imagen, sin texto
    image(imgInicio, 0, 0, width, height);
    
    drawButton("Iniciar", width/2 - 50, height - 100, 100, 40, color(200,0,0));  // botón rojo más abajo
  } else if (screen >= 0 && screen < 3) {
    image(imgs[screen], 0, 0, width, height);

    switch(screen) {
      case 0:
        if (movingRight) {
          textX += textSpeed;
          if (textX > width - 150) movingRight = false;
        } else {
          textX -= textSpeed;
          if (textX < 150) movingRight = true;
        }
        textSize(32);
        text(getTextForScreen(screen), textX, height - 50);
        break;

      case 1:
        if (fadingIn) {
          textAlpha += 5;
          if (textAlpha >= 255) {
            textAlpha = 255;
            fadingIn = false;
          }
        } else {
          textAlpha -= 5;
          if (textAlpha <= 0) {
            textAlpha = 0;
            fadingIn = true;
          }
        }
        fill(255, 204, 0, textAlpha);
        textSize(32);
        text(getTextForScreen(screen), width/2, height - 50);
        break;

      case 2:
        if (scaleUp) {
          scaleVal += scaleSpeed;
          if (scaleVal >= 1.3) scaleUp = false;
        } else {
          scaleVal -= scaleSpeed;
          if (scaleVal <= 0.8) scaleUp = true;
        }
        pushMatrix();
        translate(width/2, height - 50);
        scale(scaleVal);
        textSize(32);
        fill(255, 204, 0);
        text(getTextForScreen(screen), 0, 0);
        popMatrix();
        break;
    }

    // Cambio automático de pantalla
    if (millis() - lastChangeTime > interval) {
      screen++;
      textX = width / 2;
      textAlpha = 0;
      fadingIn = true;
      scaleVal = 1;
      scaleUp = true;
      fill(255, 204, 0);
      lastChangeTime = millis();
    }
  } else if (screen == 3) {
    fill(255, 204, 0);
    textSize(28);
    text("Gracias por ver la presentación", width/2, height/2 - 40);
    drawButton("Reiniciar", width/2 - 50, height/2, 100, 40, color(200,0,0));
  }
}

void mousePressed() {
  if (screen == -1 && overButton(width/2 - 50, height - 100, 100, 40)) {
    screen = 0;
    lastChangeTime = millis();
  }
  if (screen == 3 && overButton(width/2 - 50, height/2, 100, 40)) {
    screen = -1;
  }
}

String getTextForScreen(int s) {
  if (s == 0) return "Naturaleza y Tecnología";
  if (s == 1) return "Interacción con la luz";
  if (s == 2) return "Espacios que fluyen";
  return "";
}

void drawButton(String label, float x, float y, float w, float h, color btnColor) {
  fill(overButton(x, y, w, h) ? lerpColor(btnColor, color(255, 100, 100), 0.5) : btnColor);
  rect(x, y, w, h, 10);
  fill(255); // texto blanco para contraste con botón rojo
  textSize(16);
  text(label, x + w/2, y + h/2);
}

boolean overButton(float x, float y, float w, float h) {
  return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
}
