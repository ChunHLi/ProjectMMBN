import java.util.*;

class ChipMenu {
  ArrayList<Chip> displayedChips;
  PImage chipInterface;

  ChipMenu() {
    chipInterface = loadImage("../Sprites/chipSelection/000.png");
    chipInterface.resize((int)(chipInterface.width*1.5), (int)(chipInterface.height*1.5));
  }  

  void display(boolean doIt) {
    if (doIt) {
      image(chipInterface, 0, 0);
    }
  }
}

//ArrayList<Chip> extractChips(ArrayList<Chip> chipFolder){
//}

