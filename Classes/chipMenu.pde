import java.util.*;

class ChipMenu {
  ArrayList<Chip> tutorialFolder = new ArrayList<Chip>(0);


  ArrayList<Chip> swordFolder = new ArrayList<Chip>(0);
  ArrayList<Chip> elementalFolder = new ArrayList<Chip>(0);
  ArrayList<Chip> chipFolder;
  PImage chipInterface;
  Animation Cursor = new Animation("../Sprites/chipSelection/01", 2, 10);
  Animation CrossCursor = new Animation("../Sprites/chipSelection/crossSelection/01", 2, 10);
  PImage crossSelect = loadImage("../
  int cursorIndex;
  int crossCursorIndex;
  float cursorXPos = 10;
  float cursorYPos = 154;
  float crossCursorXPos = 10;
  float crossCursorYPos = 12;

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
      Cursor.displayCursor(cursorXPos, cursorYPos,0);
  }
  
  void displayCrossCursor(){
    CrossCursor.displayCursor(crossCursorXPos, crossCursorYPos,1);
  }

  void moveCursorLeft() {
    cursorXPos -= 24;
    cursorIndex -= 1;
  }

  void moveCursorRight() {
    cursorXPos += 24;
    cursorIndex += 1;
  }

  void moveCursorUp() {
    cursorYPos -= 36;
    cursorIndex -= 5;
  }

  void moveCursorDown() {
    cursorYPos += 36;
    cursorIndex += 5;
  }
  
  void moveCrossCursorUp(){
    crossCursorYPos -= 24;
    crossCursorIndex -= 1;
  }
  
  void moveCrossCursorDown(){
    crossCursorYPos += 24;
    crossCursorIndex += 1;
  }
}

//ArrayList<Chip> extractChips(ArrayList<Chip> chipFolder){
//}

