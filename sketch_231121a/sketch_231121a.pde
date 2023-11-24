int rows = 10;
int cols = 10;
int totalMines = 20;
int cellSize = 40;

boolean[][] grid;
boolean[][] revealed;

void setup() {
  size(cols * cellSize, rows * cellSize);
  initializeGrid();
  placeMines();
  revealed = new boolean[rows][cols];
}

void draw() {
  background(255);
  drawGrid();
  drawMines();
}

void mousePressed() {
  int col = mouseX / cellSize;
  int row = mouseY / cellSize;
  
  if (mouseButton == LEFT && !revealed[row][col]) {
    revealCell(row, col);
  }
}

void initializeGrid() {
  grid = new boolean[rows][cols];
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      grid[i][j] = false;
    }
  }
}

void placeMines() {
  int count = 0;
  while (count < totalMines) {
    int i = (int) random(rows);
    int j = (int) random(cols);
    if (!grid[i][j]) {
      grid[i][j] = true;
      count++;
    }
  }
}

void drawGrid() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      fill(200);
      stroke(0);
      rect(j * cellSize, i * cellSize, cellSize, cellSize);
      if (revealed[i][j]) {
        if (grid[i][j]) {
          fill(127);
          ellipse(j * cellSize + cellSize / 2, i * cellSize + cellSize / 2, cellSize, cellSize);
        } else {
          int neighbors = countNeighbors(i, j);
          if (neighbors > 0) {
            fill(0);
            textSize(20);
            textAlign(CENTER, CENTER);
            text(neighbors, j * cellSize + cellSize / 2, i * cellSize + cellSize / 2);
          }
        }
      }
    }
  }
}

void drawMines() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (revealed[i][j] && grid[i][j]) {
        fill(255, 0, 0);
        ellipse(j * cellSize + cellSize / 2, i * cellSize + cellSize / 2, cellSize, cellSize);
      }
    }
  }
}

void revealCell(int row, int col) {
  revealed[row][col] = true;
  if (grid[row][col]) {
    gameOver();
  } else {
    if (countNeighbors(row, col) == 0) {
      // If the selected cell has no mines nearby, reveal its neighbors
      for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
          int newRow = row + i;
          int newCol = col + j;
          if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && !revealed[newRow][newCol]) {
            revealCell(newRow, newCol);
          }
        }
      }
    }
  }
}

int countNeighbors(int row, int col) {
  int count = 0;
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      int newRow = row + i;
      int newCol = col + j;
      if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && grid[newRow][newCol]) {
        count++;
      }
    }
  }
  return count;
}

void gameOver() {
  // Handle game over logic here
  print("Game Over!");
}
