import java.util.*;

public class ChipAttack{
 private PImage bomb = loadImage("../Sprites/battleChipAttack/bomb/010.png");
 Animation bEx = new Animation("../Sprites/battleChipAttack/bomb/00", 6);
 Animation cEx = new Animation("../Sprites/battleChipAttack/cannon/02", 8);
 Animation bust = new Animation("../Sprites/BusterShot/00", 6);
 Animation spread = new Animation("../Sprites/battleChipAttack/spreader/00", 8);
 Animation guard = new Animation("../Sprites/battleChipAttack/guard/01", 5);
 
 private boolean[] chips = {
  false, false, false, false, false, false
  //0 bomb, 1 bexplosion, 2 cEx, 3 bust, 4 spread, 5 guard
 };
 private int[] frames = {
   6, 8, 6, 8, 5
   //0 bEx, 1 cEx, 2 cBust, 3 spreader, 4 guard
 };
 private int bombRow, bombCol, guardRow, guardCol;
 private float oX, oY;
 private float xbomb, ybomb, bombTime;
 private float xcan, ycan;
 private float xbust, ybust;
 private float xspread, yspread;
 private int spreadCount;
 private float xrec, yrec;
 
 public ChipAttack(){
   
   bomb.resize((int)(bomb.width*1.5), (int)(bomb.height*1.5));
 }
 
 public void move(Panel[][] grid){
   if (chips[0]){
     if (bombTime < 60){
      image(bomb, xbomb, ybomb);
      xbomb = oX + 2.3 * bombTime;
      ybomb = (float)(oY - 4.6 * Math.sqrt(3)/2.0 * bombTime + bombTime*bombTime*.072);
      bombTime++;
     }else{
      bombTime = 0; 
      chips[0] = false;
      if (!grid[bombRow][bombCol].isDangerVirus()){
        grid[bombRow][bombCol].toggleDangerVirus();
      }
      grid[bombRow][bombCol].setDamage(10);
      chips[1] = true;
     }
   }
   if (chips[1]){
     if (bEx.currentFrame < frames[0]-1){
       bEx.displayChips(xbomb-16,ybomb+10);
     } else{
       chips[1] = false;
       bEx.currentFrame = 0;
     }
   }
   if (chips[2]){
    if (cEx.currentFrame < frames[1]-1){
     cEx.displayChips(xcan,ycan);
    } else{
     chips[2] = false;
     cEx.currentFrame = 0; 
    }
   }
   if (chips[3]){
    if (bust.currentFrame < frames[2]-1){
     bust.displayChips(xbust,ybust);
    } else{
     chips[3] = false;
     bust.currentFrame = 0; 
    }
   }
  if (chips[4]){
    if (spreadCount < frames[3]-1){
     try{spread.displayF(xspread-10, yspread, spreadCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{spread.displayF(xspread-10, yspread-40, spreadCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{spread.displayF(xspread-10, yspread+40, spreadCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{spread.displayF(xspread+50, yspread, spreadCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{spread.displayF(xspread+50, yspread-40, spreadCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{spread.displayF(xspread+50, yspread+40, spreadCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{spread.displayF(xspread-70, yspread, spreadCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{spread.displayF(xspread-70, yspread-40, spreadCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{spread.displayF(xspread-70, yspread+40, spreadCount);}catch(ArrayIndexOutOfBoundsException e) {}
     spreadCount++;
    } else{
     chips[4] = false;
     spreadCount = 0; 
    }
   }
   if (chips[5]){
     if (guardCol < 6){
       guard.displayChips(grid[guardRow][guardCol].getLocationX(), grid[guardRow][guardCol].getLocationY());
       grid[guardRow][guardCol].setDamage(10);
       grid[guardRow][guardCol].setDangerVirus(true);
       if (guardCol < 5){
         guardCol++;
       }
     }
   }
 }

 public void change(int index){
  chips[index] = !chips[index]; 
 }
 public void setXY(String chip, float xpos, float ypos, int row, int col){
   if (chip.equals("bomb")){
     oX=xpos + 55;
     oY=ypos - 35;
     bombRow=row;
     bombCol=col+3;
     chips[0] = true;
   }
   if (chip.equals("cannon")){
     xcan = xpos;
     ycan = ypos;
     chips[2] = true;
   }
   if (chip.equals("buster")){
     xbust = xpos;
     ybust = ypos;
     chips[3] = true;
   }
   if (chip.equals("spreader")){
     xspread = xpos;
     yspread = ypos;
     chips[4] = true;
   }
   if (chip.equals("guard")){
     guardRow = row;
     guardCol = col+1;
     chips[5] = true;
   }
 }
}
