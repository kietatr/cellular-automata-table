class CAGrid {
  CA[][] cas;
  int rows;
  int cols;
  byte ruleStart;
  color colorStart;
  
  CAGrid(int rows, int cols) {
    this.rows = rows;
    this.cols = cols;
    ruleStart = -74;
    int opacity = 255;
    colorStart = color(255, 0, 0, opacity);
    
    cas = new CA[rows][cols];
    
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        cas[i][j] = new CA(j * width/cols, i * height/rows, width/cols, height/rows, ruleStart, colorStart);
        ruleStart++;
        opacity -= 120 / (caGridRows * caGridCols);
        colorStart = color(255, 0, 0, opacity);
      }
    }
  }
  
  void drawCAGrid() {
    for (CA[] caRow : cas) {
      for (CA ca : caRow) {
        ca.drawText();
        ca.drawCells();
        ca.updateCells();
        ca.checkReset();
      }
    }
  }
}
