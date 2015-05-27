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

  public void setAtt(String att) {
    attribute=att;
  }
  
  public void setDamage(int dmg){
    damage = dmg;
  }

  public boolean isDangerMM() {
    return dangerForMM;
  }

  public boolean isDangerForVirus() {
    return dangerForVirus;
  }

  public float getLocationX() {
    return locationX;
  }

  public float getLocationY() {
    return locationY;
  }
}

