class Chip {
  private int damage;
  private char letter;
  private String name;
  private PImage icon;
  private PImage chipArt;
  private int attackType;

  Chip() {
  }
  
  Chip(int chipID){
    icon = loadImage("../Sprites/battleChipIcons/" + chipID + ".png");
    icon.resize((int)(icon.width*1.15), (int)(icon.height*1.15));
    chipArt = loadImage("../Sprites/battleChipArt/schip" + chipID + ".png");
    chipArt.resize((int)(chipArt.width*1.5), (int)(chipArt.height*1.5));  
  }

  Chip(int Damage, char Letter, String Name, int chipID, int AttackType) {
    damage = Damage;
    letter = Letter;
    name = Name;
    icon = loadImage("../Sprites/battleChipIcons/" + chipID + ".png");
    icon.resize((int)(icon.width*1.15), (int)(icon.height*1.15));
    chipArt = loadImage("../Sprites/battleChipArt/schip" + chipID + ".png");
    chipArt.resize((int)(chipArt.width*1.5), (int)(chipArt.height*1.5));
    attackType = AttackType;
  }

  void display(int chipCollectionIndex) {
    
  }
}

