/*
Implementacion del Juego de la Vida de Conway en Processing
Comandos:
 Presiona la Barra Espaciadora para pausar el juego
 Presiona el raton para cambiar el valor de las celular durante el juego pausado
 Presiona R para generar un nuevo tablero aleatorio
 Presiona C para generar un tablero limpio
*/


// Tamaño de la celda
int cellSize = 20;

// Probalidad de Celulas
float cellProbability = 0.5;

// Tablero de celulas
int [][] currentBoard;
int [][] nextBoard;

// Color de las celulas
color alive = color(0, 200, 0);
color dead = color(0);

// Pausa
boolean pause = false;

void setup() {
    size(600, 400);
    frameRate(10);

    // Arreglos instanciados
    currentBoard = new int[width/cellSize][height/cellSize];
    nextBoard = new int[width/cellSize][height/cellSize];

    background(0);
    stroke(48);
    strokeWeight(2);
    noSmooth();

    // Rellenando el talero
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

void draw() {
    // Dibujando el tablero
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

    if (pause) {
        if (mousePressed) {
            // Mapeo de Coordenadas
            int xCoord = int(map(mouseX, 0, width, 0, width/cellSize));
            int yCoord = int(map(mouseY, 0, height, 0, height/cellSize));
            println("(" + xCoord + "), " + "(" + yCoord + ")");

            if (nextBoard[xCoord][yCoord] == 1) {
                currentBoard[xCoord][yCoord] = 0;
                fill(dead);
            } else {
                currentBoard[xCoord][yCoord] = 1;
                fill(alive);
            }
        } else {
            for (int x = 0; x < width/cellSize; x++) {
                for (int y = 0; y < height/cellSize; y++) {
                    nextBoard[x][y] = currentBoard[x][y];
                }
            }
        }
    } else {
        interaccion();
    }
}

void interaccion() {
    // Creando una copia del tablero actual
    for (int x = 0; x < width/cellSize; x++) {
        for (int y = 0; y < height/cellSize; y++) {
            nextBoard[x][y] = currentBoard[x][y];
        }
    }

    // Analizando a las celulas
    for (int x = 0; x < width/cellSize; x++) {
        for (int y = 0; y < height/cellSize; y++) {
            int neighbours = 0;
            // Conteo de vecinos
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
    }
}
