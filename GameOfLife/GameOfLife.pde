/*
Implementacion del Juego de la Vida de Conway en Processing
Comandos:
  Presiona la Barra Espaciadora para pausar el juego
  Presiona el raton para cambiar el valor de las celular durante el juego pausado
  Presiona R para generar un nuevo tablero de celulas aletorias
  Presiona C para generar un tablero limpio de celulas y pausar el juego
  Presiona +/- para aumentar o reducir la velocidad del juego respectivamente
*/


// Tamaño de la celda
int cellSize = 20;

// Probalidad de Celulas
float cellProbability = 0.5;

// Tablero de celulas
int [][] currentBoard;
int [][] nextBoard;

// Color de las celulas
color alive = color(52, 255, 8);
color dead = color(0);

// Estado del juego
boolean pause = false;

// Variables del tiempo
int interval = 200;
int timeElapsed = 0;
int changeValue = 50;

void setup() {
  size(600, 400);

  // Arreglos instanciados
  currentBoard = new int[width/cellSize][height/cellSize];
  nextBoard = new int[width/cellSize][height/cellSize];

  // Estilos
  background(0);
  stroke(48);
  strokeWeight(2);
  noSmooth();

  // Pinta el Penta-decathlon si es posible
  if (width/cellSize>=16 && height/cellSize>=9) {
    int x = int((width/cellSize)/2)-5;
    int y = int((height/cellSize)/2); 
    for (int i=0; i<=9; i++) {
      if (i==2 || i == 7) {
        currentBoard[x+i][y-1] = 1;
        currentBoard[x+i][y+1] = 1;
      } else {
        currentBoard[x+i][y] = 1;
      }
    }
  }
  // Si no pinta el tablero aleatoriamente
  else {
    for (int x = 0; x < width/cellSize; x++) {
      for (int y = 0; y < height/cellSize; y++) {
        float value = random(1);
        if (value > cellProbability) {
          currentBoard[x][y] = 0;
        } else {
          currentBoard[x][y] = 1;
        }
      }
    }
  }
}

void draw() {
  // Dibujando el tablero inicial
  for (int x = 0; x < width/cellSize; x++) {
    for (int y = 0; y < height/cellSize; y++) {
      if (currentBoard[x][y] == 1) {
        fill(alive);
      } else {
        fill(dead);
      }
      rect (x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }

  // Manejo del tiempo
  if ((millis() - timeElapsed) > interval) {
    if (!pause) {
      interaction();
      timeElapsed = millis();
    }
  }

  // Dibujo manual de las celulas
  if (pause && mousePressed) {
    // Mapeo de Coordenadas
    int xCoord = int(map(mouseX, 0, width, 0, width/cellSize));
    int yCoord = int(map(mouseY, 0, height, 0, height/cellSize));

    // Ejecutando los cambios
    if (nextBoard[xCoord][yCoord] == 1) {
      currentBoard[xCoord][yCoord] = 0;
      fill(dead);
    } else {
      currentBoard[xCoord][yCoord] = 1;
      fill(alive);
    }
  }
  // Guardando de los cambios
  else if (pause && !mousePressed) {
    for (int x = 0; x < width/cellSize; x++) {
      for (int y = 0; y < height/cellSize; y++) {
        nextBoard[x][y] = currentBoard[x][y];
      }
    }
  }
}

void interaction() {
  // Analizando el proximo tablero
  for (int x = 0; x < width/cellSize; x++) {
    for (int y = 0; y < height/cellSize; y++) {
      nextBoard[x][y] = currentBoard[x][y];
    }
  }

  // Analizando a las celulas
  for (int x = 0; x < width/cellSize; x++) {
    for (int y = 0; y < height/cellSize; y++) {
      // Conteo de vecinos
      int neighbours = 0;
      for (int i = x-1; i <= x+1; i++) {
        for (int j = y-1; j <= y+1; j++) {
          if (((i>=0) && (i<width/cellSize)) && ((j>=0) && (j<height/cellSize))) {
            if (!((i == x) && (j == y))) {
              if (nextBoard[i][j] == 1) {
                neighbours++;
              }
            }
          }
        }
      }

      // Reglas de la vida
      if (nextBoard[x][y] == 1) {
        if (neighbours < 2 || neighbours > 3) {
          currentBoard[x][y] = 0;
        }
      } else {
        if (neighbours == 3) {
          currentBoard[x][y] = 1;
        }
      }
    }
  }
}

void keyPressed() {
  // Reiniciar el tablero
  if (key=='r' || key=='R') {
    for (int x = 0; x < width/cellSize; x++) {
      for (int y = 0; y < height/cellSize; y++) {
        float value = random(1);
        if (value > cellProbability) {
          currentBoard[x][y] = 0;
        } else {
          currentBoard[x][y] = 1;
        }
      }
    }
    if (pause) {
      pause = !pause;
    }
  }

  // Pausar el juego
  if (key==' ') {
    pause = !pause;
  }

  // Limpiar el tablero
  if (key=='c' || key=='C') {
    for (int x = 0; x < width/cellSize; x++) {
      for (int y = 0; y < height/cellSize; y++) {
        currentBoard[x][y] = 0;
      }
    }
    if (!pause) {
      pause = !pause;
    }
  }

  // Cambiar la velocidad
  if (key=='+' || key=='-' && interval>=0 && interval<=400) {
    // Aumentar la velocidad / Reducir el intervalo
    if (key=='+' && interval > 0) {
      interval -= changeValue;
    }
    // Reducir la velocidad / Aumentar el intervalo
    if (key=='-' && interval < 400) {
      interval += changeValue;
    }
  }
}
