import java.util.*;

class ChipMenu {
  ArrayList<Chip> tutorialFolder = new ArrayList<Chip>(0);


  ArrayList<Chip> swordFolder = new ArrayList<Chip>(0);
  ArrayList<Chip> elementalFolder = new ArrayList<Chip>(0);
  ArrayList<Chip> chipFolder;
  PImage chipInterface;
  Animation Cursor = new Animation("../Sprites/chipSelection/01", 2, 10);
  int cursorIndex;
  float cursorXPos = 10;
  float cursorYPos = 154;

  ChipMenu() {
    tutorialFolder.add(new Chip(70));
    tutorialFolder.add(new Chip(70));
    tutorialFolder.add(new Chip(70));
    tutorialFolder.add(new Chip(71));
    tutorialFolder.add(new Chip(71));
    tutorialFolder.add(new Chip(71));
    tutorialFolder.add(new Chip(72));
    tutorialFolder.add(new Chip(72));
    tutorialFolder.add(new Chip(72));
    tutorialFolder.add(new Chip(1));
    tutorialFolder.add(new Chip(1));
    tutorialFolder.add(new Chip(1));
    tutorialFolder.add(new Chip(4));
    tutorialFolder.add(new Chip(4));
    tutorialFolder.add(new Chip(4));
    tutorialFolder.add(new Chip(179));
    tutorialFolder.add(new Chip(179));
    tutorialFolder.add(new Chip(179));
    tutorialFolder.add(new Chip(91));
    tutorialFolder.add(new Chip(91));
    tutorialFolder.add(new Chip(91));
    tutorialFolder.add(new Chip(9));
    tutorialFolder.add(new Chip(9));
    tutorialFolder.add(new Chip(9));
    tutorialFolder.add(new Chip(5));
    tutorialFolder.add(new Chip(5));
    tutorialFolder.add(new Chip(5));
    tutorialFolder.add(new Chip(58));
    tutorialFolder.add(new Chip(180));
    tutorialFolder.add(new Chip(180));
    chipFolder = tutorialFolder;
    chipInterface = loadImage("../Sprites/chipSelection/000.png");
    chipInterface.resize((int)(chipInterface.width*1.5), (int)(chipInterface.height*1.5));
  }

  ChipMenu(ArrayList<Chip> folder) {
    chipFolder = folder;
    chipInterface = loadImage("../Sprites/chipSelection/000.png");
    chipInterface.resize((int)(chipInterface.width*1.5), (int)(chipInterface.height*1.5));
  }

  void display(boolean doIt) {
    if (doIt) {
      image(chipInterface, 0, 0);
      int counter = 0;
       while (counter < 5){
       image(chipFolder.get(counter).icon,15 + counter * 24, 159);
       counter += 1;
       }
       while (counter < 8){
       image(chipFolder.get(counter).icon,15 + (counter - 5) * 24, 195);
       counter += 1;
       }
       image(chipFolder.get(cursorIndex).chipArt,23,35);
    }
  }

  void displayCursor() {
    Cursor.displayCursor(cursorXPos, cursorYPos);
  }

  void moveCursorLeft(boolean trigger) {
    if (cursorIndex != 0 && cursorIndex != 5) {
      cursorXPos -= 24;
      cursorIndex -= 1;
      trigger = !trigger;
    }
  }

  void moveCursorRight(boolean trigger) {
    if (cursorIndex != 4 && cursorIndex != 7) {
      cursorXPos += 24;
      cursorIndex += 1;
      trigger = !trigger;
    }
  }

  void moveCursorUp(boolean trigger) {
    if (cursorIndex > 4) {
      cursorYPos -= 36;
      cursorIndex -= 5;
      trigger = !trigger;
    }
  }

  void moveCursorDown(boolean trigger) {
    if (cursorIndex < 3) {
      cursorYPos += 36;
      cursorIndex += 5;
      trigger = !trigger;
    }
  }
}

//ArrayList<Chip> extractChips(ArrayList<Chip> chipFolder){
//}

