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
    interaccion();
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
