import java.util.*;

public class ChipAttack{
 private PImage bomb = loadImage("../Sprites/battleChipAttack/0.png");
 private boolean[] chips = {
  false
  //0 bomb, 
 };
 private int panRow, panCol;
 private float oX, oY;
 private float xbomb, ybomb, bombTime;
 
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
      if (!grid[panRow][panCol].isDangerVirus()){
        grid[panRow][panCol].toggleDangerVirus();
      }
      grid[panRow][panCol].setDamage(10);
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
     panRow=row;
     panCol=col+3;
     chips[0] = true;
   }
 }
 
}
