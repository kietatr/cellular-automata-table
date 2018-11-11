class CA {
  int[] cells, ruleSet;
  int cellWidth;
  int generation;
  
  int caWidth, caHeight;
  int caX, caY;

  float topMargin;

  byte ruleNumber;
  
  color caColor;
  
  CA(int caX, int caY, int caWidth, int caHeight, byte ruleNumber, color caColor) {
    this.caWidth = caWidth;
    this.caHeight = caHeight;
    this.caX = caX;
    this.caY = caY;
    
    this.ruleNumber = ruleNumber;
    
    this.caColor = caColor;
    
    topMargin = map(caGridRows, 1, 10, 17, 10);
    
    cellWidth = 8;
    generation = 0;
    
    cells = new int[caWidth / cellWidth];
    
    // Set cells for generation 0 (all 0's with 1 at center)
    for (int i = 0; i < cells.length; i++) {
      cells[i] = 0;
    }
    cells[cells.length/2] = 1;
    
    // Set rule for generation 0
    ruleSet = new int[]{0,0,0,0,0,0,0,0};
    
    this.ruleNumber = ruleNumber;
    char[] ruleNumberStr = binary(ruleNumber).toCharArray();
    for (int i = 0; i < ruleNumberStr.length; i++) {
      ruleSet[i] = Integer.parseInt(str(ruleNumberStr[i]));
    }
  }
  
  void drawCells() {
    for (int i = 0; i < cells.length; i++) {
      
      noStroke();
      if (cells[i] == 1) {fill(caColor);}
      else {noFill();}
  
      float x = caX + cellWidth/2 + cellWidth * i;
      float y = caY + topMargin + cellWidth/2 + cellWidth * generation;
      ellipse(x, y, cellWidth, cellWidth);
    }
  }
  
  void updateCells() {
    int[] newCells = new int[cells.length];
    
    for (int i = 1; i < cells.length-1; i++) {
      int left = cells[i-1];
      int middle = cells[i];
      int right = cells[i+1];
      
      newCells[i] = rules(left, middle, right);
    }
    cells = newCells;
    
    generation++;
  }
  
  int rules(int left, int middle, int right) {
    String s = "" + left + middle + right;
    int ruleIndex = Integer.parseInt(s, 2);
    return ruleSet[ruleIndex];
  }
  
  void resetCA() {
    background(0);
    
    generation = 0;
    
    for (int i = 0; i < cells.length; i++) {
      cells[i] = 0;
    }
    cells[cells.length/2] = 1;
    
    ruleNumber += caGridRows * caGridCols;
    char[] ruleNumberStr = binary(ruleNumber).toCharArray();
    for (int i = 0; i < ruleNumberStr.length; i++) {
      ruleSet[i] = Integer.parseInt(str(ruleNumberStr[i]));
    }
  }
  
  void checkReset() {
    if (generation == caHeight / cellWidth - 1) {
      resetCA();
      delay(1500 / (caGridRows * caGridCols));
    }
  }
  
  void drawText() {
    fill(caColor);
    textSize(topMargin);
    textAlign(LEFT);
    text(ruleNumber, caX + 2, caY + topMargin);
  }
  
}
