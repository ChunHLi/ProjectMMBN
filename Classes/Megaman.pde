public class Megaman implements Killable {
  int HP, buster, panelRow, panelCol, currentAnimation;
  String cross;

  Animation Standing = new Animation("../Sprites/megaman/noCross/01", 1);
  Animation Hurt = new Animation("../Sprites/megaman/noCross/02", 8);
  Animation ArrivePanel = new Animation("../Sprites/megaman/noCross/03", 4);
  Animation LeavePanel = new Animation("../Sprites/megaman/noCross/04", 4);
  Animation Buster = new Animation("../Sprites/megaman/noCross/15", 5);
  Animation Bullet = new Animation("../Sprites/megaman/noCross/16", 3);
  Animation ChargeBlue = new Animation("../Sprites/chargingBuster/01", 7);
  Animation ChargePurp = new Animation("../Sprites/chargingBuster/02", 11);

  
  //Swords
  Animation Slash = new Animation("../Sprites/megaman/noCross/14", 7, 10);
  Animation Sword = new Animation("../Sprites/battleChipAttack/slash/00", 5, 1);
  Animation WideSword = new Animation("../Sprites/battleChipAttack/slash/01", 5, 1);
  Animation LongSword = new Animation("../Sprites/battleChipAttack/slash/04", 5, 1);
  Animation LifeSword = new Animation("../Sprites/battleChipAttack/slash/03", 5, 50);
  //Cannon
  Animation Cannon = new Animation("../Sprites/battleChipAttack/cannon/00", 10, 1);
  Animation Blast = new Animation("../Sprites/battleChipAttack/cannon/01", 4, 1);

  public Megaman() {
    this(100, 1, 1, 1, "noCross");
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
        if (Buster.currentFrame > 1){
          if (Buster.currentFrame == 4){
            Bullet.displayChips(xpos+70, ypos-48);
          } else {
            Bullet.displayChips(xpos+70, ypos-39);
          }
        }
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
      if (animation == 4) {
        image(Buster.spriteFrames[LeavePanel.currentFrame], xpos, ypos - Buster.spriteFrames[Buster.currentFrame].height + 5);
        if (Buster.currentFrame > 1){
          image(Bullet.spriteFrames[LeavePanel.currentFrame], xpos+70, ypos-39 - Bullet.spriteFrames[Bullet.currentFrame].height + 5);
        }
      }
    }
    currentAnimation = animation;
  }
  
  public void display(float xpos, float ypos, int animation, int mode, int frame){
    if (mode == 0 ){
      if (animation == 98){
       ChargeBlue.display(xpos-19, ypos+15, frame); 
      }
      if (animation == 99){
       ChargePurp.display(xpos-19, ypos+15, frame); 
      }
    }
    if (mode == 1){
      if (animation == 98){
        image(ChargeBlue.spriteFrames[ChargeBlue.currentFrame], xpos-19, ypos+15 - ChargeBlue.spriteFrames[ChargeBlue.currentFrame].height + 5);
      }
      if (animation == 99){
        image(ChargePurp.spriteFrames[ChargePurp.currentFrame], xpos-19, ypos+15 - ChargePurp.spriteFrames[ChargePurp.currentFrame].height + 5);
      }
    }
  }
  
  public void display(float xpos, float ypos, int mode, String chip){
    if (mode == 0){
      if (chip.equals("sword")){
        Slash.display(xpos, ypos);
        if (Slash.currentFrame == 1 || Slash.currentFrame == 2 || Slash.currentFrame == 3){
          Sword.displayChips(xpos+55, ypos-9);
        } else if (Slash.currentFrame == 4){
          Sword.displayChips(xpos+70, ypos-18);
        } else if (Slash.currentFrame == 5){
          Sword.displayChips(xpos+70, ypos-30);
        }
      }
      if (chip.equals("widesword")){
        Slash.display(xpos, ypos);
        if (Slash.currentFrame == 1 || Slash.currentFrame == 2 || Slash.currentFrame == 3){
          WideSword.displayChips(xpos+62, ypos+30);
        } else if (Slash.currentFrame == 4){
          WideSword.displayChips(xpos+81, ypos+2);
        } else if (Slash.currentFrame == 5){
          WideSword.displayChips(xpos+81, ypos-40);
        }
      }
      if (chip.equals("longsword")){
        Slash.display(xpos, ypos);
        if (Slash.currentFrame == 1 || Slash.currentFrame == 2 || Slash.currentFrame == 3){
          LongSword.displayChips(xpos+62, ypos-3);
        } else if (Slash.currentFrame == 4){
          LongSword.displayChips(xpos+91, ypos-18);
        } else if (Slash.currentFrame == 5){
          LongSword.displayChips(xpos+90, ypos-35);
        }
      }
      if (chip.equals("lifesword")){
        Slash.display(xpos, ypos);
        if (Slash.currentFrame > 0){
          LifeSword.display(xpos+62, ypos-25);
        }
      }
      if (chip.equals("cannon")){
       Cannon.display(xpos, ypos);
       if (Cannon.currentFrame == 4 || Cannon.currentFrame == 5){
        Blast.displayChips(xpos+85, ypos-27);
       } else if (Cannon.currentFrame == 6){
        Blast.displayChips(xpos+85, ypos-10);
       } else if (Cannon.currentFrame == 7){
        Blast.displayChips(xpos+85, ypos-15);
       }
      }
    }
    
    if (mode == 1){
      if (chip.equals("sword")) {
        image(Slash.spriteFrames[Slash.currentFrame], xpos, ypos - Slash.spriteFrames[Slash.currentFrame].height + 5);
      }
      if (chip.equals("widesword")) {
        image(Slash.spriteFrames[Slash.currentFrame], xpos, ypos - Slash.spriteFrames[Slash.currentFrame].height + 5);
      }
      if (chip.equals("longsword")) {
        image(Slash.spriteFrames[Slash.currentFrame], xpos, ypos - Slash.spriteFrames[Slash.currentFrame].height + 5);
      }
      if (chip.equals("lifesword")) {
        image(Slash.spriteFrames[Slash.currentFrame], xpos, ypos - Slash.spriteFrames[Slash.currentFrame].height + 5);
      }
      if (chip.equals("cannon")) {
        image(Cannon.spriteFrames[Cannon.currentFrame], xpos, ypos - Cannon.spriteFrames[Cannon.currentFrame].height + 5);
      }
    }
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
  public int getBuster(){
   return buster; 
  }
  public void setBuster(int val){
   buster = val;
  }
}

