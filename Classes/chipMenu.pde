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
    tutorialFolder.add(new Chip(80, 'S', "Sword", 70, 0));
    tutorialFolder.add(new Chip(80, 'S', "Sword", 70, 0));
    tutorialFolder.add(new Chip(80, 'S', "Sword", 70, 0));
    tutorialFolder.add(new Chip(80, 'S', "WideSwrd", 71, 0));
    tutorialFolder.add(new Chip(80, 'S', "WideSwrd", 71, 0));
    tutorialFolder.add(new Chip(80, 'S', "WideSwrd", 71, 0));
    tutorialFolder.add(new Chip(80, 'S', "LongSwrd", 72, 0));
    tutorialFolder.add(new Chip(80, 'S', "LongSwrd", 72, 0));
    tutorialFolder.add(new Chip(80, 'S', "LongSwrd", 72, 0));
    tutorialFolder.add(new Chip(40, 'A', "Cannon", 1, 0));
    tutorialFolder.add(new Chip(40, 'B', "Cannon", 1, 0));
    tutorialFolder.add(new Chip(40, 'C', "Cannon", 1, 0));
    tutorialFolder.add(new Chip(20, '!', "AirShot", 4, 0));
    tutorialFolder.add(new Chip(20, '!', "AirShot", 4, 0));
    tutorialFolder.add(new Chip(20, '!', "AirShot", 4, 0));
    tutorialFolder.add(new Chip(0, '!', "Invisibl", 179, 0));
    tutorialFolder.add(new Chip(0, '!', "Invisibl", 179, 0));
    tutorialFolder.add(new Chip(0, '!', "Invisibl", 179, 0));
    tutorialFolder.add(new Chip(50, '!', "Rflectr1", 91, 0));
    tutorialFolder.add(new Chip(50, '!', "Rflectr1", 91, 0));
    tutorialFolder.add(new Chip(50, '!', "Rflectr1", 91, 0));
    tutorialFolder.add(new Chip(30, 'J', "Spreader", 9, 0));
    tutorialFolder.add(new Chip(30, 'K', "Spreader", 9, 0));
    tutorialFolder.add(new Chip(30, 'L', "Spreader", 9, 0));
    tutorialFolder.add(new Chip(10, '!', "Vulcan1", 5, 0));
    tutorialFolder.add(new Chip(10, '!', "Vulcan1", 5, 0));
    tutorialFolder.add(new Chip(10, '!', "Vulcan1", 5, 0));
    tutorialFolder.add(new Chip(50, 'B', "MiniBomb", 58, 0));
    tutorialFolder.add(new Chip(0, 'B', "Brrier10", 180, 0));
    tutorialFolder.add(new Chip(0, 'B', "Brrier10", 180, 0));
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
      while (counter < 5) {
        image(chipFolder.get(counter).icon, 15 + counter * 24, 159);
        image(chipFolder.get(counter).letterText, 20 + counter * 24, 181);
        counter += 1;
      }
      while (counter < 8) {
        image(chipFolder.get(counter).icon, 15 + (counter - 5) * 24, 195);
        image(chipFolder.get(counter).letterText, 20 + (counter - 5) * 24, 217);
        counter += 1;
      }
      image(chipFolder.get(cursorIndex).chipArt, 23, 35);
      chipFolder.get(cursorIndex).displayName();
      chipFolder.get(cursorIndex).displayDamage();
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

