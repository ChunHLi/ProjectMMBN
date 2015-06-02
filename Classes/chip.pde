class Chip {
  private int damage,chipID,attackType;
  private char letter;
  private String name;
  private PImage icon;
  private PImage chipArt;
  private PImage letterText;
  private boolean isSelected;

  Chip() {
  }

  Chip(int ChipID) {
    chipID = ChipID;
    icon = loadImage("../Sprites/battleChipIcons/" + ChipID + ".png");
    icon.resize((int)(icon.width*1.15), (int)(icon.height*1.15));
    chipArt = loadImage("../Sprites/battleChipArt/schip" + ChipID + ".png");
    chipArt.resize((int)(chipArt.width*1.5), (int)(chipArt.height*1.5));
  }

  Chip(int Damage, char Letter, String Name, int ChipID, int AttackType) {
    chipID = ChipID;
    damage = Damage;
    letter = Letter;
    name = Name;
    letterText = loadImage("../Sprites/textArt/chipCodeText/" + letter + ".png");
    letterText.resize((int)(letterText.width), (int)(letterText.height*.75));
    icon = loadImage("../Sprites/battleChipIcons/" + ChipID + ".png");
    icon.resize((int)(icon.width*1.15), (int)(icon.height*1.15));
    chipArt = loadImage("../Sprites/battleChipArt/schip" + ChipID + ".png");
    chipArt.resize((int)(chipArt.width*1.5), (int)(chipArt.height*1.5));
    attackType = AttackType;
  }

  void displayName() {
    int counter = 0;
    while (counter < name.length ()) {
      if (Character.isLowerCase(name.charAt(counter))) {
        PImage thisChar = loadImage("../Sprites/textArt/chipNameText/" + Character.toUpperCase(name.charAt(counter)) + 1 + ".png");
        thisChar.resize((int)(thisChar.width * 1.5),(int)(thisChar.height * 1.5));
        image(thisChar, 24 + 11 * counter, 32 - thisChar.height);
      } else {
        PImage thisChar = loadImage("../Sprites/textArt/chipNameText/" + name.charAt(counter) + ".png");
        thisChar.resize((int)(thisChar.width * 1.5),(int)(thisChar.height * 1.5));
        image(thisChar, 24 + 11 * counter, 32 - thisChar.height);
      }
      counter += 1;
    }
    
    PImage Code = loadImage("../Sprites/textArt/chipCodeText/" + letter + ".png");
    Code.resize((int)(Code.width * 1.5),(int)(Code.height * 1.5));
    image(Code, 24, 112);
  }
  
  void displayDamage(){
    String dmg = Integer.toString(damage);
    int counter = dmg.length() - 1;
    while (counter >= 0){
      PImage thisChar = loadImage("../Sprites/textArt/text/" + dmg.charAt(counter) + ".png");
      thisChar.resize((int)(thisChar.width * 1.5),(int)(thisChar.height * 1.5));
      image(thisChar, 98 - (dmg.length() - 1 - counter) * 10, 112);
      counter -= 1;
    }
  }
  
  boolean isSelectable(ChipLinkedList sample){
    if (isSelected == true){
      return false;
    }
    if (sample.size() == 0){
      return true;
    }
    if (sample.size() == 5){
      return false;
    }
    if (letter == '!'){
      return true;
    }
    if (letter == sample.get(0).letter){
      return true;
    }
    if (letter != sample.get(0).letter && sample.get(0).letter != '!'){
      int counter = 0;
      while (counter < (sample.size())){
        if (chipID != sample.get(counter).chipID){
          return false;
        }
        counter += 1;
      }
      return true;
    }
    else{
      int counter = 0;
      while (counter < sample.size()){
        if (sample.get(counter).letter != '!' && sample.get(counter).letter != letter){
          return false;
        }
        counter += 1;
      }
      return true;
    }
  }
}

