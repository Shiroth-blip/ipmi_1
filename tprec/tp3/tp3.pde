// Autor: Elias Esquibel
// Link: 

int cols = 40;  // número de columnas
int rows = 20;  // número de filas
float circleSize;
color startColor = color(0, 255, 0); // Color verde
color endColor = color(255, 0, 0);   // Color rojo
color borderColor = color(0, 100, 0); // Verde oscuro para el borde
color originalStartColor;
color originalEndColor;

void setup() {
  size(800, 400);
  circleSize = width / cols;
  originalStartColor = startColor;
  originalEndColor = endColor;
  noLoop(); // Solo dibuja una vez
}

void draw() {
  background(#365E32); // Verde oscuro de fondo
  image(loadImage("fondo.jpg"), 0, 0, width / 2, height); // Imagen en la mitad izquierda
  drawGrid(); // Dibujar la grilla de óvalos
}

void drawGrid() {
  ellipseMode(CENTER);
  
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      float lerpFactor = dist(x * circleSize, y * circleSize, width / 2, height / 2)
                       / dist(0, 0, width / 2, height / 2);

      fill(lerpColor(startColor, endColor, lerpFactor)); // Degradado de color
      stroke(borderColor); // Borde verde oscuro

      pushMatrix(); // Guarda estado de coordenadas

      translate(x * circleSize + circleSize / 2 + width / 2, y * circleSize + circleSize / 2);
      rotate(radians(45)); // Rota 45 grados

      ellipse(0, 0, circleSize * 1.2, circleSize * 0.8); // Óvalo horizontal

      popMatrix(); // Restaura estado
    }
  }
}

// Función para mostrar coordenadas del mouse
String coordenadasMouse() {
  return "Posición mouse - X: " + mouseX + ", Y: " + mouseY;
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    resetColors();
    
    // Mostrar las coordenadas actuales del mouse en consola
    String mensaje = coordenadasMouse();
    println(mensaje);
  }
}

void mousePressed() {
  // Cambia a colores aleatorios al hacer clic
  startColor = color(random(255), random(255), random(255));
  endColor = color(random(255), random(255), random(255));
  redraw();
}

void resetColors() {
  startColor = originalStartColor;
  endColor = originalEndColor;
  redraw();
}
