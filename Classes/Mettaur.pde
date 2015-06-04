public class Mettaur implements Killable {

  int HP, dmg, panelRow, panelCol;

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
    if (mode == 0){
      if (animation == 0) {
        xpos+=6;
        Standing.display(xpos, ypos,0);
      }
      if (animation == 1) {
        Attack.display(xpos, ypos,0);
      }
    }
    else{
      if (animation == 0){        
        image(Standing.spriteFrames[Standing.currentFrame], xpos, ypos - Standing.spriteFrames[Standing.currentFrame].height + 5);
      }
      else{
        image(Attack.spriteFrames[Attack.currentFrame], xpos - Attack.spriteFrames[Attack.currentFrame].width/3, ypos - Attack.spriteFrames[Attack.currentFrame].height + 5);
      }
    }
  }

  public void attack(ArrayList<VirusAttack> VirusForce) {
    VirusForce.add(new VirusAttack(panelRow, panelCol - 1, 10, 0));
  }

public void getHurt(Panel[][] Grid){
    if (Grid[panelRow][panelCol].isDangerVirus()){
      hurt(Grid[panelRow][panelCol].getDamage());
      Grid[panelRow][panelCol].setDangerVirus(false);
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

