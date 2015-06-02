public class ChipLinkedList {
  LinkedList<Chip> selected = new LinkedList<Chip>();

  ChipLinkedList() {
  }

  void display(int mode) {
    if (mode == 0){
    }
    if (mode == 1){
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
       //do animation, remove these chips and insert PA chip
    }
    if (selected.get(counter).letter == 'J' && selected.get(counter + 1).letter == 'K' && selected.get(counter + 2).letter == 'L') {
      //do animation, remove these chips and insert PA chip
    }
    if (selected.get(counter).letter == 'A' && selected.get(counter + 1).letter == 'B' && selected.get(counter + 2).letter == 'C') {
      //do animation, remove these chips and insert PA chip
    }
    if (selected.get(counter).chipID == 73 && selected.get(counter + 1).chipID == 74 && selected.get(counter + 2).name.equals("ProtomnSP")) {
      //do animation, remove these chips and insert PA chip
    }
    if (selected.get(counter).name.equals("ColonelSP") && selected.get(counter + 1).chipID == 188 && selected.get(counter + 2).name.equals("Protomn")){
      //do animation, remove these chips and insert PA chip
    }
  }
}
