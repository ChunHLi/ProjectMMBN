import java.util.*;

class ChipMenu {
  ArrayList<Chip> chipFolder;
  PImage chipInterface;
  Animation Cursor = new Animation("../Sprites/chipSelection/01",2,10);
  int cursorIndex;
  float cursorXPos = 10;
  float cursorYPos = 154;

  ChipMenu() {
    chipInterface = loadImage("../Sprites/chipSelection/000.png");
    chipInterface.resize((int)(chipInterface.width*1.5), (int)(chipInterface.height*1.5));
  }

  ChipMenu(ArrayList<Chip> folder){
    chipFolder = folder;
    chipInterface = loadImage("../Sprites/chipSelection/000.png");
    chipInterface.resize((int)(chipInterface.width*1.5), (int)(chipInterface.height*1.5));
  }

  void display(boolean doIt) {
    if (doIt) {
      image(chipInterface, 0, 0);
    }
  }
  
  void displayCursor(){
    Cursor.displayCursor(cursorXPos, cursorYPos);
  }
  
  void moveCursorLeft(boolean trigger){
    if (cursorIndex != 0 && cursorIndex != 5){
      cursorXPos -= 24;
      cursorIndex -= 1;
      trigger = !trigger;
    }
  }
  
  void moveCursorRight(boolean trigger){
    if (cursorIndex != 4 && cursorIndex != 7){
      cursorXPos += 24;
      cursorIndex += 1;
      trigger = !trigger;
    }
  }
  
  void moveCursorUp(boolean trigger){
    if (cursorIndex > 4){
      cursorYPos -= 36;
      cursorIndex -= 5;
     trigger = !trigger; 
    }
  }
  
  void moveCursorDown(boolean trigger){
    if (cursorIndex < 3){
      cursorYPos += 36;
      cursorIndex += 5;
      trigger = !trigger;
    }
  }
  
}

//ArrayList<Chip> extractChips(ArrayList<Chip> chipFolder){
//}

