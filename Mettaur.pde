public class Mettaur implements Killable{
 private int HP;
 private int dmg;
 
 public Mettaur(){
  this(50,10); 
 }
 
 public Mettaur(int HP, int dmg){
  this.HP=HP;
  this.dmg=dmg;
 }
 
 
 public void hurt(int damage){
  HP-=damage; 
 }
 public void heal(int regen){
  HP+=regen; 
 }
 public int getHP(){
  return HP; 
 }
  
}
