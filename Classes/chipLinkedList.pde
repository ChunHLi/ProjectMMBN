public class ChipLinkedList {
  LinkedList<Chip> selected;
  LinkedList<Integer> selectedPreviousIndex;
  int PAStartIndex, animationSequence;
  boolean PAExists, lifeSword, spreader, gigaCannon, twinLeaders, doubleHero;
  Animation appearPA = new Animation("../Sprites/textArt/text/PA/00", 5);
  Animation disappearPA = new Animation("../Sprites/textArt/text/PA/01", 5);
  Chip LifeSword = new Chip(400, '!', "LifeSwrd", 194, 0);

  ChipLinkedList() {
    selected = new LinkedList<Chip>();
    selectedPreviousIndex = new LinkedList<Integer>();
  }

  void display(int mode) {
    if (mode == 1) {
      int counter = 0;
      while (counter < selected.size ()) {
        image(selected.get(counter).icon, 147, 39 + (counter * 24));
        counter += 1;
      }
    }
  }

  void displayBattle(int mode, float xpos, float ypos) {
    if (mode == 0) {
      int counter = selected.size() - 1;
      while (counter >= 0) {
        PImage clone = selected.get(counter).icon.get();
        clone.resize((int)(clone.width * 1.25), (int)(clone.height * 1.25));
        image(clone, xpos - (counter * 2) + 25, ypos - (counter * 2) - 85);
        counter -= 1;
      }
    }
  }

  void checkPA() {
    if (selected.size() > 2) {
      int counter = 0;
      while (counter < selected.size () - 2) {
        checkPAHelper(counter);
        counter += 1;
      }
    }
  }

  void checkPAHelper(int counter) {
    if ((selected.get(counter).chipID == 70 && selected.get(counter + 1).chipID == 71 && selected.get(counter + 2).chipID == 72) ||
      (selected.get(counter).chipID == 70 && selected.get(counter + 1).chipID == 73 && selected.get(counter + 2).chipID == 74)) {
      PAExists = true;
      lifeSword = true;
      PAStartIndex = counter;
    }
    if (selected.get(counter).letter == 'J' && selected.get(counter + 1).letter == 'K' && selected.get(counter + 2).letter == 'L') {
      PAExists = true;
      spreader = true;
      PAStartIndex = counter;
    }
    if (selected.get(counter).letter == 'A' && selected.get(counter + 1).letter == 'B' && selected.get(counter + 2).letter == 'C') {
      PAExists = true;
      gigaCannon = true;
      PAStartIndex = counter;
    }
    if (selected.get(counter).chipID == 73 && selected.get(counter + 1).chipID == 74 && selected.get(counter + 2).name.equals("ProtomnSP")) {
      PAExists = true;
      doubleHero = true;
      PAStartIndex = counter;
    }
    if (selected.get(counter).name.equals("ColonelSP") && selected.get(counter + 1).chipID == 188 && selected.get(counter + 2).name.equals("Protomn")) {
      PAExists = true;
      twinLeaders = true;
      PAStartIndex = counter;
    }
  }

  void PA() {
    if (PAExists) {
      if (animationSequence < 5) {
        appearPA.display(24, 60, 0);
      } else if (animationSequence < selected.size() * 15 + 5) {
        image(appearPA.spriteFrames[4], 24, 41);
        if (animationSequence > 4) {
          selected.get(0).displayName(24, 101, true);
        }
        if (animationSequence > 19) {
          selected.get(1).displayName(24, 125, true);
        }
        if (animationSequence > 34) {
          selected.get(2).displayName(24, 149, true);
        }
        if (animationSequence > 49 && selected.size() > 3) {
          selected.get(3).displayName(24, 173, true);
        }
        if (animationSequence > 64 && selected.size() > 4) {
          selected.get(4).displayName(24, 197, true);
        }
      } else if (animationSequence < 140) {
        image(appearPA.spriteFrames[4], 24, 41);
        int counter = 0;
        while (counter < selected.size ()) {
          if (counter < PAStartIndex || counter > PAStartIndex + 2) {
            selected.get(counter).displayName(24, 101 + counter * 24, true);
          }
          if (lifeSword) {
            selected.set(PAStartIndex, LifeSword);
          }
          if (gigaCannon) {
          }
          if (spreader) {
          }
          if (twinLeaders) {
          }
          if (doubleHero) {
          }
          if (animationSequence % 4 != 0) {
            selected.get(PAStartIndex).displayName(24, 101 + PAStartIndex * 24, true);
          }
          counter += 1;
        }
      } else if (animationSequence < 145) {
        disappearPA.display(24, 60, 0);
      } else if (animationSequence < 151) {
      } else {
        selected.remove(PAStartIndex + 1);
        selected.remove(PAStartIndex + 1);
        animationSequence = 0;
        PAExists = false;
      }
      animationSequence += 1;
    }
  }



  int size() {
    return selected.size();
  }

  Chip get(int index) {
    return selected.get(index);
  }

  void add(Chip chip, int index) {
    selected.add(chip);
    selectedPreviousIndex.add(index);
  }

  int remove(int index) {
    selected.remove(index);
    return selectedPreviousIndex.remove(index);
  }

  void empty() {
    selected.clear();
    selectedPreviousIndex.clear();
  }
}

