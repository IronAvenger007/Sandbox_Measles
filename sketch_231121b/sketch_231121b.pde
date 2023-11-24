int rows = 3;
int cols = 3;
int[][] board = new int[rows][cols];
int currentPlayer = 1;
boolean gameOver = false;
int winner = 0;

void setup() {
  size(300, 300);
  initializeBoard();
}

void draw() {
  background(255);
  drawBoard();
  
  if (gameOver) {
    fill(0);
    textSize(32);
    if (winner == 0) {
      text("It's a draw!", 50, height / 2);
    } else {
      text("Player " + winner + " wins!", 50, height / 2);
    }
  }
}

void mousePressed() {
  if (!gameOver) {
    int row = mouseY / (height / rows);
    int col = mouseX / (width / cols);
    
    if (isValidMove(row, col)) {
      makeMove(row, col);
      checkForWinner();
      switchPlayer();
    }
  }
}

void initializeBoard() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      board[i][j] = 0;
    }
  }
}

void drawBoard() {
  float w = width / cols;
  float h = height / rows;
  
  stroke(0);
  strokeWeight(2);
  for (int i = 1; i < rows; i++) {
    line(0, i * h, width, i * h);
  }
  for (int j = 1; j < cols; j++) {
    line(j * w, 0, j * w, height);
  }
  
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      float x = j * w + w / 2;
      float y = i * h + h / 2;
      int spot = board[i][j];
      if (spot == 1) {
        drawX(x, y, w / 2);
      } else if (spot == 2) {
        drawO(x, y, w / 2);
      }
    }
  }
}

void drawX(float x, float y, float r) {
  line(x - r, y - r, x + r, y + r);
  line(x + r, y - r, x - r, y + r);
}

void drawO(float x, float y, float r) {
  ellipse(x, y, r * 2, r * 2);
}

boolean isValidMove(int row, int col) {
  return board[row][col] == 0;
}

void makeMove(int row, int col) {
  board[row][col] = currentPlayer;
}

void switchPlayer() {
  currentPlayer = 3 - currentPlayer; // Switches between player 1 and player 2
}

void checkForWinner() {
  // Check rows, columns, and diagonals for a winner
  for (int i = 0; i < rows; i++) {
    if (board[i][0] != 0 && board[i][0] == board[i][1] && board[i][0] == board[i][2]) {
      winner = board[i][0];
      gameOver = true;
      return;
    }
  }
  for (int j = 0; j < cols; j++) {
    if (board[0][j] != 0 && board[0][j] == board[1][j] && board[0][j] == board[2][j]) {
      winner = board[0][j];
      gameOver = true;
      return;
    }
  }
  if (board[0][0] != 0 && board[0][0] == board[1][1] && board[0][0] == board[2][2]) {
    winner = board[0][0];
    gameOver = true;
    return;
  }
  if (board[0][2] != 0 && board[0][2] == board[1][1] && board[0][2] == board[2][0]) {
    winner = board[0][2];
    gameOver = true;
    return;
  }
  
  // Check for a draw
  boolean isDraw = true;
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (board[i][j] == 0) {
        isDraw = false;
        break;
      }
    }
    if (!isDraw) {
      break;
    }
  }
  if (isDraw) {
    gameOver = true;
  }
}
