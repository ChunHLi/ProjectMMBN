public class Megaman implements Killable {
  int HP, buster, panelRow, panelCol, currentAnimation;
  String cross;

  Animation Standing = new Animation("../Sprites/megaman/noCross/01", 1);
  Animation Hurt = new Animation("../Sprites/megaman/noCross/02", 8);
  Animation ArrivePanel = new Animation("../Sprites/megaman/noCross/03", 4);
  Animation LeavePanel = new Animation("../Sprites/megaman/noCross/04", 4);
  Animation Buster = new Animation("../Sprites/megaman/noCross/07", 7);


  public Megaman() {
    this(100, 10, 1, 1, "noCross");
  }
  public Megaman(int HP, int buster, int panelRow, int panelCol, String cross) {
    this.HP=HP;
    this.buster=buster;
    this.cross=cross;
    this.panelRow = panelRow;
    this.panelCol = panelCol;
  }

  public void draw() {
  }

  public void display(float xpos, float ypos, int animation, int mode) {
    if (mode == 0) {
      if (animation == 0) {
        //for (int i = 0; i < Standing.spriteCount; i++){
        Standing.display(xpos, ypos);
        //}
      }
      if (animation == 1) {
        //for (int i = 0; i < Hurt.spriteCount; i++){
        Hurt.display(xpos, ypos);
        //}
      }
      if (animation == 2) {
        //for (int i = 0; i < ArrivePanel.spriteCount; i++){
        ArrivePanel.display(xpos, ypos);
        //}
      }
      if (animation == 3) {
        //for (int i = 0; i < LeavePanel.spriteCount; i++){
        LeavePanel.display(xpos, ypos);
        //}
      }
      if (animation == 4){
        Buster.display(xpos, ypos);
      }
    }
    if (mode == 1) {
      if (animation == 0) {
        image(Standing.spriteFrames[Standing.currentFrame], xpos, ypos - Standing.spriteFrames[Standing.currentFrame].height + 5);
      }
      if (animation == 1) {
        image(Hurt.spriteFrames[Hurt.currentFrame], xpos, ypos - Hurt.spriteFrames[Hurt.currentFrame].height + 5);
      }
      if (animation == 2) {
        image(ArrivePanel.spriteFrames[ArrivePanel.currentFrame], xpos, ypos - ArrivePanel.spriteFrames[ArrivePanel.currentFrame].height + 5);
      }
      if (animation == 3) {
        image(LeavePanel.spriteFrames[LeavePanel.currentFrame], xpos, ypos - LeavePanel.spriteFrames[LeavePanel.currentFrame].height + 5);
      }
    }
    currentAnimation = animation;
  }

  public void hurt(int dmg) {
    HP-=dmg;
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

