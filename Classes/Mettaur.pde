public class Mettaur implements Killable {
  private int HP, dmg, panelRow, panelCol;

  public Mettaur() {
    this(50, 10, 1, 4);
  }

  Animation Standing = new Animation("../Sprites/viruses/Mettaur/01", 1);
  Animation Attack = new Animation("../Sprites/viruses/Mettaur/02", 13, 1);


  public Mettaur(int HP, int dmg, int panelRow, int panelCol) {
    this.HP=HP;
    this.dmg=dmg;
    this.panelRow = panelRow;
    this.panelCol = panelCol;
  }

  public void display(float xpos, float ypos, int animation, int mode) {
    if (animation == 0){
      xpos+=6;
      Standing.display(xpos, ypos);
    }
    if (animation == 1){
      Attack.display(xpos, ypos); 
    }
    
  }

  public void hurt(int damage) {
    HP-=damage;
  }
  public void heal(int regen) {
    HP+=regen;
  }
  public int getHP() {
    return HP;
  }
  public int getRow() {
    return panelRow;
  } 
  public int getCol() {
    return panelCol;
  }
  public void setRow(int Row) {
    panelRow = Row;
  }
  public void setCol(int Col) {
    panelCol = Col;
  }
}

