import java.util.*;

public class ChipAttack{
 private PImage bomb = loadImage("../Sprites/battleChipAttack/bomb/010.png");
 Animation bEx = new Animation("../Sprites/battleChipAttack/bomb/00", 6);
 Animation cEx = new Animation("../Sprites/battleChipAttack/cannon/02", 8);
 Animation bust = new Animation("../Sprites/BusterShot/00", 6);
 Animation spread = new Animation("../Sprites/battleChipAttack/spreader/00", 8);
 Animation guard = new Animation("../Sprites/battleChipAttack/guard/01", 5);
 Animation firehit = new Animation("../Sprites/battleChipAttack/firehit/00", 4);
 Animation boomer = new Animation("../Sprites/battleChipAttack/Boomer/00", 4);
 
 private boolean[] chips = {
  false, false, false, false, false, false, false, false, false, false
  //0 bomb, 1 bexplosion, 2 cEx, 3 bust, 4 spread, 5 guard, 6 firehit, 7 boomer, 8 gigacannon, 9 hispread
 };
 private int[] frames = {
   6, 8, 6, 8, 5, 4, 4, 8, 60
   //0 bEx, 1 cEx, 2 cBust, 3 spreader, 4 guard, 5 firehit, 6 boomer, 7 gigacannon, 8 hispread
 };
 private int bombRow, bombCol, guardRow, guardCol, boomRow, boomCol;
 private float oX, oY;
 private float xbomb, ybomb, bombTime;
 private float xcan, ycan;
 private float xbust, ybust;
 private float xspread, yspread, xhispread, yhispread;
 private int spreadCount, hispreadCount, boomerCount, gigaCount;
 private float xrec, yrec;
 private int guardDMG;
 private float xfire, yfire;
 private float xgiga, ygiga;
 
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
      grid[bombRow][bombCol].setDamage(50);
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
     if (guardCol < 5){
       grid[guardRow][guardCol].setDamage(guardDMG);
       grid[guardRow][guardCol].setDangerVirus(true);
       if (guard.currentFrame == guard.spriteCount){
         guard.currentFrame = 1;
         guardCol++;
       }
       guard.displayMettaurAttack(grid[guardRow][guardCol].getLocationX(), grid[guardRow][guardCol].getLocationY(), 60);
     } else if(guardCol<=8){
      image(guard.spriteFrames[guard.currentFrame + 2],grid[guardRow][5].getLocationX(),grid[guardRow][5].getLocationY() - guard.spriteFrames[guard.currentFrame + 2].height + 5);
      grid[guardRow][5].toggleDangerVirus();
      guardCol++;
     } else if (guardCol == 6){
      chips[5] = false;
     }
   }
   if (chips[6]){
     if (firehit.currentFrame < frames[5]-1){
       firehit.displayChips(xfire-15,yfire);
     } else{
       chips[6] = false;
       firehit.currentFrame = 0;
     }
   }
   if (chips[7]){
     if (boomerCount < 20){
       boomer.displayF(grid[boomRow][boomCol].getLocationX()+10*(boomerCount%4), grid[boomRow][boomCol].getLocationY(), boomerCount%4);
       if (boomerCount%4 == 0 && boomerCount != 0){
        boomCol++; 
       }
     } else if (boomerCount == 20){
      boomCol++; 
     } else if (boomerCount < 28){
       boomer.displayF(grid[boomRow][boomCol].getLocationX(), grid[boomRow][boomCol].getLocationY()-5*(boomerCount%4), boomerCount%4);
       if (boomerCount%4 == 0 && boomerCount != 20){
        boomRow--;
       }
     } else if (boomerCount == 28){
       boomRow--;
     } else if (boomerCount < 52){
        boomer.displayF(grid[boomRow][boomCol].getLocationX()-10*(boomerCount%4), grid[boomRow][boomCol].getLocationY(), boomerCount%4);
        if (boomerCount%4 == 0 && boomerCount != 28){
        boomCol--;
       }
     }
     boomerCount++;
     grid[boomRow][boomCol].setDangerVirus(true);
     grid[boomRow][boomCol].setDamage(100);
     if (boomerCount == 52){
       chips[7] = false;
      boomerCount = 0; 
     }
   }
   if (chips[8]){
    if (gigaCount < frames[7]-1){
     try{cEx.displayF(xgiga-10, ygiga, gigaCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{cEx.displayF(xgiga-10, ygiga-40, gigaCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{cEx.displayF(xgiga-10, ygiga+40, gigaCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{cEx.displayF(xgiga+50, ygiga, gigaCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{cEx.displayF(xgiga+50, ygiga-40, gigaCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{cEx.displayF(xgiga+50, ygiga+40, gigaCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{cEx.displayF(xgiga-70, ygiga, gigaCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{cEx.displayF(xgiga-70, ygiga-40, gigaCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{cEx.displayF(xgiga-70, ygiga+40, gigaCount);}catch(ArrayIndexOutOfBoundsException e) {}
     gigaCount++;
    } else{
     chips[8] = false;
     gigaCount = 0; 
    }
   }
   if (chips[9]){
    if (hispreadCount < frames[8]-1){
     try{spread.displayF(xhispread-10, yhispread, hispreadCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{spread.displayF(xhispread-10, yhispread-40, hispreadCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{spread.displayF(xhispread-10, yhispread+40, hispreadCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{spread.displayF(xhispread+50, yhispread, hispreadCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{spread.displayF(xhispread+50, yhispread-40, hispreadCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{spread.displayF(xhispread+50, yhispread+40, hispreadCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{spread.displayF(xhispread-70, yhispread, hispreadCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{spread.displayF(xhispread-70, yhispread-40, hispreadCount);}catch(ArrayIndexOutOfBoundsException e) {}
     try{spread.displayF(xhispread-70, yhispread+40, hispreadCount);}catch(ArrayIndexOutOfBoundsException e) {}
     hispreadCount++;
    } else{
     chips[9] = false;
     hispreadCount = 0; 
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
     guardDMG = 50;
   }
   if (chip.equals("guard3")){
     guardRow = row;
     guardCol = col+1;
     chips[5] = true;
     guardDMG = 200;
   }
   if (chip.equals("firehit")){
     xfire = xpos;
     yfire = ypos;
     chips[6] = true;
   }
   if (chip.equals("boomer")){
     if (boomRow == 0 && boomCol == 0){
       boomRow = row;
       boomCol = col;
       chips[7] = true;
     }
   }
   if (chip.equals("gigacannon")){
     xgiga = xpos;
     ygiga = ypos;
     chips[8] = true;
   }
   if (chip.equals("hispread")){
     xhispread = xpos;
     yhispread = ypos;
     chips[9] = true;
   }
   
 }
}
