public class VirusAttack{
  int damage, panelRow, panelCol, type;
  int mettaurAttackDelay = 5;
  int mettaurCurrentFrame = 0;
  
  Animation mettaurAttack = new Animation("../Sprites/viruses/Mettaur/04",5);
  
  VirusAttack(){
    
  }
  
  VirusAttack(int PanelRow, int PanelCol, int Damage, int Type){
    panelRow = PanelRow;
    panelCol = PanelCol;
    damage = Damage;
    type = Type;
  }
  
  void move(Panel[][] grid){
    if (type == 0){
      if (panelCol > 0){ 
        grid[panelRow][panelCol].setDamage(10);
        grid[panelRow][panelCol].toggleDangerMM();
        if (mettaurAttack.currentFrame == mettaurAttack.spriteCount){
          mettaurAttack.currentFrame = 1;
          panelCol -= 1;
        }
        mettaurAttack.displayMettaurAttack(grid[panelRow][panelCol].getLocationX(),grid[panelRow][panelCol].getLocationY());
      }
      else if (panelCol >= -2){
        image(mettaurAttack.spriteFrames[mettaurAttack.currentFrame + 2],grid[panelRow][0].getLocationX(),grid[panelRow][0].getLocationY() - mettaurAttack.spriteFrames[mettaurAttack.currentFrame + 2].height + 5);
        grid[panelRow][0].toggleDangerMM();
        panelCol -= 1;
      }
    }
  }
}
