public class virusAttack{
  int damage, panelRow, panelCol, type;
  int mettaurAttackDelay = 5;
  int mettaurCurrentFrame = 0;
  
  Animation mettaurAttack = new Animation("../Sprites/viruses/Mettaur/04",5);
  
  virusAttack(){
    
  }
  
  virusAttack(int PanelRow, int PanelCol, int Damage, int Type){
    panelRow = PanelRow;
    panelCol = PanelCol;
    damage = Damage;
    type = Type;
  }
  
  void move(Panel[][] grid){
    if (type == 0){
      if (panelCol > 0){ 
        if (mettaurAttack.currentFrame == mettaurAttack.spriteCount){
          image(mettaurAttack.spriteFrames[mettaurAttack.currentFrame - 1],xpos,ypos - mettaurAttack.spriteFrames[mettaurAttack.currentFrame - 1].height + 5);
          mettaurAttack.currentFrame = 1;
          panelCol -= 1;
        }
        mettaurAttack.displayMettaurAttack(grid[panelRow][panelCol].getLocationX(),grid[panelRow][panelCol].getLocationY());
      }
    }
  }
}
