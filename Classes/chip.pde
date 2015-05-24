class Chip {
  private int damage;
  private char letter;
  private String name;
  private PImage icon;
  private PImage chipArt;
  private int attackType;

  Chip() {
  }

  Chip(int Damage, char Letter, String Name, int chipID, int AttackType) {
    damage = Damage;
    letter = Letter;
    name = Name;
    icon = loadImage("../Sprites/battleChipIcons/" + chipID + ".png");
    chipArt = loadImage("../Sprites/battleChipArt/schip" + chipID + ".png");
    attackType = AttackType;
  }

  void display(int chipCollectionIndex) {
  }
}

