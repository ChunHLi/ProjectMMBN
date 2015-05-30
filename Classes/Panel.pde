public class Panel {
  private boolean dangerForVirus;
  private boolean dangerForMM;
  private String attribute;
  private float locationX;
  private float locationY;
  private int damage;


  public Panel() {
    this(0, 0);
  }

  public Panel(float xpos, float ypos) {
    locationX = xpos;
    locationY = ypos;
    dangerForVirus = false;
    dangerForMM = false;
    setAtt("reg");
  }
  
  public Panel(float xpos, float ypos, boolean Danger){
    locationX = xpos;
    locationY = ypos;
    dangerForVirus = Danger;
    dangerForMM = !Danger;
    setAtt("reg");
  }
  
  public void panelColor(){
    if (dangerForMM){
      noStroke();
      fill(248,248,64);
      rect(locationX - 5,locationY - 24,60,36);
    }
  }

  public void setAtt(String att) {
    attribute=att;
  }
  
  public int getDamage(){
    return damage;
  }
  
  public void setDamage(int dmg){
    damage = dmg;
  }
  
  public void toggleDangerMM(){
    dangerForMM = !dangerForMM;
  }
  
  public void toggleDangerVirus(){
    dangerForVirus = !dangerForVirus;
  }

  public boolean isDangerMM() {
    return dangerForMM;
  }

  public boolean isDangerVirus() {
    return dangerForVirus;
  }

  public float getLocationX() {
    return locationX;
  }

  public float getLocationY() {
    return locationY;
  }
}

