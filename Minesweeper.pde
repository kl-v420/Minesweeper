import de.bezier.guido.*;
public static final int NUM_ROWS = 20;
public static final int NUM_COLS = 20;
public static boolean Lose = false;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined
public int tiles = 0;

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );
  buttons = new MSButton [NUM_ROWS] [NUM_COLS];
  mines = new ArrayList <MSButton>();
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new MSButton(r, c);
    }
  }

  setMines();
}
public void setMines()
{
  for (int i = 0; i < 40; i++) {
    final int r1 = (int)(Math.random()*20);
    final int r2 = (int)(Math.random()*20);
    if ((mines.contains (buttons[r1][r2])) == false) {
      mines.add(buttons[r1][r2]);
    } else {
      i +=-1;
    }
  }
}

public void draw ()
{
  background( 0 );

  for (int i = 0; i < NUM_ROWS; i++) {
    for (int j = 0; j < NUM_COLS; j++) {
      buttons[i][j].draw();
    }
  }
  if (isWon() == true)
    displayWinningMessage();
}

public boolean isWon()
{
  return false;
}
public void displayLosingMessage()
{
  for (int i=0; i<mines.size(); i++)
    if (mines.get(i).isClicked()==false)
      mines.get(i).mousePressed();
  Lose = true;
  color(242, 210, 189);
  buttons[9][9].setLabel("O");
  buttons[10][9].setLabel("u");
  buttons[11][9].setLabel("c");
  buttons[12][9].setLabel("h");

  buttons[7][11].setLabel("Y");
  buttons[8][11].setLabel("o");
  buttons[9][11].setLabel("u");
  buttons[10][11].setLabel("");
  buttons[11][11].setLabel("L");
  buttons[12][11].setLabel("o");
  buttons[13][11].setLabel("s");
  buttons[14][11].setLabel("t");
}
public void displayWinningMessage()
{

  Lose = true;
  color(242, 210, 189);
  buttons[9][9].setLabel("W");
  buttons[10][9].setLabel("o");
  buttons[11][9].setLabel("w");
  buttons[12][9].setLabel("!");

  buttons[7][11].setLabel("Y");
  buttons[8][11].setLabel("o");
  buttons[9][11].setLabel("u");
  buttons[10][11].setLabel("");
  buttons[11][11].setLabel("W");
  buttons[12][11].setLabel("o");
  buttons[13][11].setLabel("n");
  buttons[14][11].setLabel("!");
}
public boolean isValid(int r, int c)
{
  if (r <NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0) {
    return true;
  }
  return false;
}
public class MSButton
{
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String label;

  public MSButton ( int row, int col )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = row;
    c = col;
    x = r*width;
    y = c*height;
    label = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    if (Lose == false) {
      if (mouseButton == RIGHT && buttons[r][c].isClicked()) {
      } else if (mouseButton == RIGHT) {
        flagged = !flagged;
      } else if (flagged == true) {
      } else if (mines.contains(this)) {
        clicked = true;
        displayLosingMessage();
      } else if (countMines(r, c) > 0) {
        label = ""+countMines(r, c);
        if (!clicked) {
          tiles+=1;
        }
        if (tiles == 400-mines.size()) {
          displayWinningMessage();
        }
        clicked = true;
      } else {


        if (!clicked) {
          tiles+=1;
        }
        if (tiles == 400-mines.size()) {
          displayWinningMessage();
        }
        clicked = true;


        if (!clicked) {
          tiles+=1;
        }
        if (tiles == 400-mines.size()) {
          displayWinningMessage();
        }
        clicked = true;

        if (isValid(r-1, c-1) && !buttons[r-1][c-1].isClicked()) {
          buttons[r-1][c-1].mousePressed();
        }
        if (isValid(r-1, c) && !buttons[r-1][c].isClicked()) {
          buttons[r-1][c].mousePressed();
        }
        if (isValid(r-1, c+1) && !buttons[r-1][c+1].isClicked()) {
          buttons[r-1][c+1].mousePressed();
        }

        if (isValid(r, c-1) && !buttons[r][c-1].isClicked()) {
          buttons[r][c-1].mousePressed();
        }
        if (isValid(r, c+1) && !buttons[r][c+1].isClicked()) {
          buttons[r][c+1].mousePressed();
        }

        if (isValid(r+1, c-1) && !buttons[r+1][c-1].isClicked()) {
          buttons[r+1][c-1].mousePressed();
        }
        if (isValid(r+1, c) && !buttons[r+1][c].isClicked()) {
          buttons[r+1][c].mousePressed();
        }
        if (isValid(r+1, c+1) && !buttons[r+1][c+1].isClicked()) {
          buttons[r+1][c+1].mousePressed();
        }
      }
    }
  }
  public void draw ()
  {    
    if (flagged)
      fill(0);

    else if ( !flagged && clicked && mines.contains(this) )
      fill(255, 0, 0);
    else if ( flagged && mines.contains(this) )
      fill(100);
    else if ( !flagged && clicked && !mines.contains(this) )
      fill(200);

    else if (clicked)
      fill( 200 );
    else
      fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
  public void setLabel(int newLabel)
  {
    label = ""+ newLabel;
  }
  public boolean isFlagged()
  {
    return flagged;
  }
  public boolean isClicked()
  {
    return clicked;
  }
}
public int countMines(int row, int col)
{
  int accidentalkaboom = 0;
  if (isValid(row-1, col) == true && mines.contains(buttons[row-1][col]))
  {
    accidentalkaboom++;
  }
  if (isValid(row+1, col) == true && mines.contains(buttons[row+1][col]))
  {
    accidentalkaboom++;
  }
  if (isValid(row, col-1) == true && mines.contains(buttons[row][col-1]))
  {
    accidentalkaboom++;
  }
  if (isValid(row, col+1) == true && mines.contains(buttons[row][col+1]))
  {
    accidentalkaboom++;
  }
  if (isValid(row-1, col+1) == true && mines.contains(buttons[row-1][col+1]))
  {
    accidentalkaboom++;
  }
  if (isValid(row-1, col-1) == true && mines.contains(buttons[row-1][col-1]))
  {
    accidentalkaboom++;
  }
  if (isValid(row+1, col+1) == true && mines.contains(buttons[row+1][col+1]))
  {
    accidentalkaboom++;
  }
  if (isValid(row+1, col-1) == true && mines.contains(buttons[row+1][col-1]))
  {
    accidentalkaboom++;
  }
  return accidentalkaboom;
}  
