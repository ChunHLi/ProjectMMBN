public class chipAttack{
 PImage bomb = loadImage("../Sprites/battleChipAttack/42"); 
 boolean[] chips = {
  false
  //0 bomb, 
 };
 int xbomb, ybomb, bombTime;
 
 public chipAttack(){
   
 }
 
 public void move(Panel[][] grid){
   if (chips[0]){
     if (xbomb < 81){
      image(bomb, xbomb, ybomb);
      xbomb+=30;
     }else{
      chips[0] = false; 
     }
   }
 }
 
 public boolean[] getChips(){
  return chips; 
 }
 public void setXY(String chip, int xpos, int ypos){
   if (chip.equals("bomb")){
     xbomb=xpos;
     ybomb=ypos;
   }
 }
 
}
