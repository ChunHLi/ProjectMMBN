import java.util.*;

class ChipMenu {
  ArrayList<Chip> tutorialFolder = new ArrayList<Chip>(0);
  ChipLinkedList selected = new ChipLinkedList();
  ArrayList<Chip> swordFolder = new ArrayList<Chip>(0);
  ArrayList<Chip> elementalFolder = new ArrayList<Chip>(0);
  ArrayList<Chip> chipFolder;
  PImage chipInterface;
  Animation Cursor = new Animation("../Sprites/chipSelection/01", 2, 10);
  Animation CrossCursor = new Animation("../Sprites/chipSelection/crossSelection/01", 2, 10);
  PImage crossSelect = loadImage("../Sprites/chipSelection/crossSelection/000.png");
  PImage heat = loadImage("../Sprites/chipSelection/crossSelection/020.png");
  PImage notHeat = loadImage("../Sprites/chipSelection/crossSelection/021.png");
  PImage selectedHeat = loadImage("../Sprites/chipSelection/crossSelection/022.png");
  PImage slash = loadImage("../Sprites/chipSelection/crossSelection/030.png");
  PImage notSlash = loadImage("../Sprites/chipSelection/crossSelection/031.png");
  PImage selectedSlash = loadImage("../Sprites/chipSelection/crossSelection/032.png");
  int cursorIndex;
  int crossCursorIndex;
  float cursorXPos = 10;
  float cursorYPos = 154;
  float crossCursorXPos = 12;
  float crossCursorYPos = 10;

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
    crossSelect.resize((int)(crossSelect.width * 1.5), (int)(crossSelect.height * 1.5));
    heat.resize((int)(heat.width * 1.5), (int)(heat.height * 1.5));
    notHeat.resize((int)(notHeat.width * 1.5), (int)(notHeat.height * 1.5));
    selectedHeat.resize((int)(selectedHeat.width * 1.5), (int)(selectedHeat.height * 1.5));
    slash.resize((int)(slash.width * 1.5), (int)(slash.height * 1.5));
    notSlash.resize((int)(notSlash.width * 1.5), (int)(notSlash.height * 1.5));
    selectedSlash.resize((int)(selectedSlash.width * 1.5), (int)(selectedSlash.height * 1.5));
  }

  ChipMenu(ArrayList<Chip> folder) {
    chipFolder = folder;
    chipInterface = loadImage("../Sprites/chipSelection/000.png");
    chipInterface.resize((int)(chipInterface.width*1.5), (int)(chipInterface.height*1.5));
    crossSelect.resize((int)(crossSelect.width * 1.5), (int)(crossSelect.height * 1.5));
  }

  void display(boolean doIt) {
    if (doIt) {
      image(chipInterface, 0, 0);
      int counter = 0;
      while (counter < 5) {
        if (chipFolder.get(counter).isSelected){
        }
        else if (!chipFolder.get(counter).isSelectable(selected)) {
          PImage filtered = chipFolder.get(counter).icon.get();
          filtered.filter(GRAY);
          image(filtered, 15 + counter * 24, 159); 
        } else if (chipFolder.get(counter).isSelected == false) {
          image(chipFolder.get(counter).icon, 15 + counter * 24, 159);
        }
        image(chipFolder.get(counter).letterText, 20 + counter * 24, 181);
        counter += 1;
      }
      while (counter < 8) {
        if (chipFolder.get(counter).isSelected){
        }
        else if (!chipFolder.get(counter).isSelectable(selected)) {
          PImage filtered = chipFolder.get(counter).icon.get();
          filtered.filter(GRAY);
          image(filtered, 15 + (counter - 5)* 24, 195);
        } else if (chipFolder.get(counter).isSelected == false) {
          image(chipFolder.get(counter).icon, 15 + (counter - 5) * 24, 195);
        }
        image(chipFolder.get(counter).letterText, 20 + (counter - 5) * 24, 217);
        counter += 1;
      }
      image(chipFolder.get(cursorIndex).chipArt, 23, 35);
      chipFolder.get(cursorIndex).displayName(24,32,false);
      chipFolder.get(cursorIndex).displayDamage();
      selected.display(1);
    }
  }

  void displayCursor() {
    Cursor.displayCursor(cursorXPos, cursorYPos, 0);
  }

  void displayCrossCursor() {
    image(crossSelect, 0, 0);
    if (crossCursorIndex == 0) {
      image(heat, 12, 12);
      image(notSlash, 12, 36);
    } else {
      image(notHeat, 12, 12);
      image(slash, 12, 36);
    }
    CrossCursor.displayCursor(crossCursorXPos, crossCursorYPos, 1);
  }

  void moveCursorLeft() {
    if (cursorIndex != 0 && cursorIndex != 5) {
      cursorXPos -= 24;
      cursorIndex -= 1;
    }
  }

  void moveCursorRight() {
    if (cursorIndex != 4 && cursorIndex != 7) {
      cursorXPos += 24;
      cursorIndex += 1;
    }
  }

  void moveCursorUp() {
    cursorYPos -= 36;
    cursorIndex -= 5;
  }

  void moveCursorDown() {
    if (cursorIndex < 3) {
      cursorYPos += 36;
      cursorIndex += 5;
    }
  }

  void moveCrossCursorUp() {
    if (crossCursorIndex == 1) {
      crossCursorYPos -= 24;
      crossCursorIndex -= 1;
    }
  }

  void moveCrossCursorDown() {
    if (crossCursorIndex == 0) {
      crossCursorYPos += 24;
      crossCursorIndex += 1;
    }
  }

  void selectChips() {
    if (selectable()) {
      selected.add(chipFolder.get(cursorIndex),cursorIndex);
      chipFolder.get(cursorIndex).isSelected = true;
    }
  }
  
  void deselectChips(){
    if (selected.size() > 0){
      chipFolder.get(selected.remove(selected.size() - 1)).isSelected = false;
    }
  }

  boolean selectable() {
    if (chipFolder.get(cursorIndex).isSelected == true){
      return false;
    }
    if (selected.size() == 0) {
      return true;
    }
    if (selected.size() == 5) {
      return false;
    }
    if (chipFolder.get(cursorIndex).letter == '!') {
      return true;
    }
    if (chipFolder.get(cursorIndex).letter == selected.get(0).letter) {
      return true;
    }
    if (chipFolder.get(cursorIndex).letter != selected.get(0).letter && selected.get(0).letter != '!') {
      int counter = 0;
      while (counter < (selected.size ())) {
        if (chipFolder.get(cursorIndex).chipID != selected.get(counter).chipID) {
          return false;
        }
        counter += 1;
      }
      return true;
    }
    else{
      int counter = 0;
      while (counter < selected.size()){
        if (selected.get(counter).letter != '!' && selected.get(counter).letter != chipFolder.get(cursorIndex).letter){
          return false;
        }
        counter += 1;
      }
      return true;
    }
  }
  
  void throwOutChips(){
    int counter = 0;
    int removedAmount = 0;
    while (removedAmount < selected.size()){
      if (chipFolder.get(counter).isSelected){
        chipFolder.remove(counter);
        removedAmount += 1;
      }
      else{
        counter += 1;
      }
    }
  }
  
  void shuffleChips(){
    int counter = 0;
    Random r = new Random();
    while (counter < chipFolder.size()){
      int indexA = r.nextInt(chipFolder.size());
      int indexB = r.nextInt(chipFolder.size());
      while (chipFolder.get(indexA).isSelected || chipFolder.get(indexB).isSelected){
        indexA = r.nextInt(chipFolder.size());
        indexB = r.nextInt(chipFolder.size());
      }
      Chip temp = chipFolder.get(indexA);
      chipFolder.set(indexA,chipFolder.get(indexB));
      chipFolder.set(indexB,temp);
      counter += 1;
    }
  }
  
  void empty(){
    selected.empty();
  }
}

//ArrayList<Chip> extractChips(ArrayList<Chip> chipFolder){
//}

