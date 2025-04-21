PImage foto; 

void setup() {
  size(800, 400);
  foto = loadImage("perroglobo.jpg");
  imageMode(CORNER);
}

void draw() {
  background(255);

  // Foto
  image(foto, 0, 0, 400, 400);

  // Parte derecha: dibujo del perrito estilo globo, más grande
  drawBalloonDog(600, 200); // centro del perro
}

void drawBalloonDog(float cx, float cy) {
  noStroke();
  fill(0, 100, 255); // Azul 

  pushMatrix();
  translate(cx, cy);
  scale(1.5); // Aumento el tamaño del perro


  // Cuerpo
  ellipse(0, 0, 100, 40);
  
  // Pata izquierda y derecha en ese orden
  pushMatrix();
  rotate(radians(30));
  ellipse(-33, 50, 30, 70);
  popMatrix();
  
  pushMatrix();
  rotate(radians(-30));
  ellipse(33, 50, 30, 70);
  popMatrix();

  // Cuello
  pushMatrix();
  rotate(radians(-18));
  ellipse(-40, -45, 30, 60);
  popMatrix();
  
  // Cabeza y Nariz
  ellipse(-80, -65, 60, 30);

  ellipse(-110, -65, 15, 15);
  
    // Oreja
  pushMatrix();
  rotate(radians(15));
  ellipse(-75, -70, 23, 60);
  popMatrix();

  // Punta de la cola
  pushMatrix();
  rotate(radians(15));
  ellipse(45, -87, 7, 30);
  popMatrix();

  // Cola
  pushMatrix();
  rotate(radians(15));
  ellipse(45, -48, 25, 70);
  popMatrix();

  popMatrix();
}
