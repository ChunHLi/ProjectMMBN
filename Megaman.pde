public class Megaman implements Killable{
 int HP;
 int buster;
 String cross;
 
 
 public Megaman(){
   this(100,10,"noCross");
 }
 public Megaman(int HP, int buster, String cross){
   this.HP=HP;
   this.buster=buster;
   this.cross=cross;
 }
 
 
 public void hurt(int dmg){
  HP-=dmg; 
 }
 public void heal(int regen){
  HP+=regen;
 }
 public int getHP(){
  return HP; 
 }
 
}
