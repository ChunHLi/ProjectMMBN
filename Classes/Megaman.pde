public class Megaman implements Killable {
  int HP, buster, panelRow, panelCol, currentAnimation;
  String cross;

  Animation Standing = new Animation("../Sprites/megaman/noCross/01", 1);
  Animation Hurt = new Animation("../Sprites/megaman/noCross/02", 8);
  Animation ArrivePanel = new Animation("../Sprites/megaman/noCross/03", 4);
  Animation LeavePanel = new Animation("../Sprites/megaman/noCross/04", 4);
  Animation Buster = new Animation("../Sprites/megaman/noCross/07", 8);
  Animation ChargeBlue = new Animation("../Sprites/chargingBuster/01", 7);
  Animation ChargePurp = new Animation("../Sprites/chargingBuster/02", 11);
  
  //Swords
  Animation Slash = new Animation("../Sprites/megaman/noCross/14", 7, 1);
  Animation Sword = new Animation("../Sprites/battleChipAttack/slash/00", 6, 1);
  Animation WideSword = new Animation("../Sprites/battleChipAttack/slash/02", 6, 1);
  Animation LongSword = new Animation("../Sprites/battleChipAttack/slash/01", 6, 1);
  Animation LifeSword = new Animation("../Sprites/battleChipAttack/slash/03", 6, 50);

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
      }
      if (animation == 5){
        Slash.display(xpos, ypos);
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
        image(Buster.spriteFrames[LeavePanel.currentFrame], xpos, ypos - LeavePanel.spriteFrames[LeavePanel.currentFrame].height + 5);
      }
      if (animation == 5) {
        image(Slash.spriteFrames[LeavePanel.currentFrame], xpos, ypos - LeavePanel.spriteFrames[LeavePanel.currentFrame].height + 5);
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
        image(ChargeBlue.spriteFrames[Standing.currentFrame], xpos-19, ypos+15 - Standing.spriteFrames[Standing.currentFrame].height + 5);
      }
      if (animation == 99){
        image(ChargePurp.spriteFrames[Standing.currentFrame], xpos-19, ypos+15 - Standing.spriteFrames[Standing.currentFrame].height + 5);
      }
    }
  }
  
  public void display(float xpos, float ypos, int animation, int mode, String chip){
    if (mode == 0){
      if (chip.equals("sword")){
        Slash.display(xpos, ypos);
        if (Slash.currentFrame > 0){
          if (Sword.currentFrame == 3){
            Sword.display(xpos+74, ypos-28);
          }else if (Sword.currentFrame == 4){
            Sword.display(xpos+74, ypos-40);
          } else {
            Sword.display(xpos+60, ypos-20); 
          }
        }
      }
      if (chip.equals("widesword")){
        Slash.display(xpos, ypos);
        if (Slash.currentFrame > 0){
          if (WideSword.currentFrame == 3){
            WideSword.display(xpos+79, ypos+5);
          }else if (WideSword.currentFrame == 4){
            WideSword.display(xpos+77, ypos-30);//+60 -18
          } else {
            WideSword.display(xpos+60, ypos+32); 
          }
        }
      }
      if (chip.equals("longsword")){
        Slash.display(xpos, ypos);
        if (Slash.currentFrame > 0){
          if (LongSword.currentFrame == 3){
            LongSword.display(xpos+92, ypos-37);
          }else if (LongSword.currentFrame == 4){
            LongSword.display(xpos+95, ypos-55);
          } else {
            LongSword.display(xpos+62, ypos-3); 
          }
        }
      }
      if (chip.equals("lifesword")){
        Slash.display(xpos, ypos);
        if (Slash.currentFrame > 0){
          LifeSword.display(xpos+62, ypos-25);
        }
      }
    }
    if (mode == 1){
      if (chip.equals("sword")) {
        image(Slash.spriteFrames[Slash.currentFrame], xpos, ypos - LeavePanel.spriteFrames[Slash.currentFrame].height + 5);
        image(Sword.spriteFrames[Sword.currentFrame], xpos+62, ypos-25 - LeavePanel.spriteFrames[Sword.currentFrame].height + 5);
      }
      if (chip.equals("widesword")) {
        image(Slash.spriteFrames[Slash.currentFrame], xpos, ypos - LeavePanel.spriteFrames[Slash.currentFrame].height + 5);
        image(WideSword.spriteFrames[WideSword.currentFrame], xpos+62, ypos-25 - LeavePanel.spriteFrames[WideSword.currentFrame].height + 5);
      }
      if (chip.equals("longsword")) {
        image(Slash.spriteFrames[Slash.currentFrame], xpos, ypos - LeavePanel.spriteFrames[Slash.currentFrame].height + 5);
        image(LongSword.spriteFrames[LongSword.currentFrame], xpos+62, ypos-25 - LeavePanel.spriteFrames[LongSword.currentFrame].height + 5);
      }
      if (chip.equals("lifesword")) {
        image(Slash.spriteFrames[Slash.currentFrame], xpos, ypos - LeavePanel.spriteFrames[Slash.currentFrame].height + 5);
        image(LifeSword.spriteFrames[LifeSword.currentFrame], xpos+62, ypos-25 - LeavePanel.spriteFrames[LifeSword.currentFrame].height + 5);
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

