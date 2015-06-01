public class chipAttack{
 private PImage bomb = loadImage("../Sprites/battleChipAttack/0.png");
 private boolean[] chips = {
  false
  //0 bomb, 
 };
 private float xbomb, ybomb, bombTime;
 
 public chipAttack(){
   
   bomb.resize((int)(bomb.width*1.5), (int)(bomb.height*1.5));
 }
 
 public void move(Panel[][] grid){
   if (chips[0]){
     if (xbomb < 300){
      image(bomb, xbomb, ybomb);
      if (bombTime > 30){
       ybomb+=2; 
      }else{
       ybomb-=2; 
      }
      xbomb+=5;
      bombTime++;
     }else{
      chips[0] = false;
      bombTime=0;
     }
   }
 }
 
 public void change(int index){
  chips[index] = !chips[index]; 
 }
 public void setXY(String chip, float xpos, float ypos){
   if (chip.equals("bomb")){
     xbomb=xpos;
     ybomb=ypos;
   }
 }
 
}
