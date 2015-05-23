public class Panel{
 private boolean danger;
 private boolean forMM;
 private String attribute;
 private float locationX;
 private float locationY;
 
 
 public Panel(){
  this(0,0); 
 }
 
 public Panel(float xpos, float ypos){
   locationX = xpos;
   locationY = ypos;
   danger = false;
   forMM = true;
   setAtt("reg");
 }
 
 public Panel(boolean Danger, boolean FOR, String att, float xpos, float ypos){
   setAtt(att);
   danger = Danger;
   forMM = FOR;
   locationX = xpos;
   locationY = ypos;
   
 }
 
 public void setAtt(String att){
   attribute=att;
 }
 
 public boolean isDanger(){
   return danger;
 }
 
 public boolean isForMM(){
   return forMM;
 }
 
 public float getLocationX(){
   return locationX;
 }
 
 public float getLocationY(){
   return locationY;
 }
 
 public void changeState(){
   danger = !danger;
 }
 
 
}
