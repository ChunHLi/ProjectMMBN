public class Panel{
 private boolean hasMegaman;
 private boolean hasVirus;
 private String attribute;
 
 
 public Panel(){
  this(false,false,"reg"); 
 }
 public Panel(boolean hasMM, boolean hasV, String att){
   hasMegaman=hasMM;
   hasVirus=hasV;
   setAtt(att);
 }
 
 public void moveMM(){
  hasMegaman=!hasMegaman; 
 }
 public void moveVirus(){
  hasVirus=!hasVirus; 
 }
 public void setAtt(String att){
   attribute=att;
 }
 
}
