// Tamaño de la celda
int cellSize = 20;

// Probalidad de Celulas
float cellProbability = 0.5;

// Tablero de celulas
int [][] board;
int [][] nextBoard;

// Color de las celulas
color alive = color(0, 200, 0);
color dead = color(0);

void setup() {
    size(600, 400);

    // Arreglos instanciados
    board = new int[width/cellSize][height/cellSize];
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
                board[x][y] = 0;
            } else {
                board[x][y] = 1;
            }
        }
    }
}

void draw() {
    // Dibujando el tablero
    for (int x = 0; x < width/cellSize; x++) {
        for (int y = 0; y < height/cellSize; y++) {
            if (board[x][y] == 1) {
                fill(alive);
            } else {
                fill(dead);
            }
            rect (x*cellSize, y*cellSize, cellSize, cellSize);
        }
    }
}
