import java.util.*;
Megaman megaman;
Animation backGround;
PImage panels;
PImage enteringChipMenu;
float xpos;
float ypos;
boolean[] Keys = {
  false, false, false, false, false
}; 
Panel[][] Grid = {
  {
    new Panel(4, 142), new Panel(64, 142), new Panel(124, 142), new Panel(184, 142), new Panel(244, 142), new Panel(304, 142)
    }
    , 
  {
    new Panel(4, 179), new Panel(64, 179), new Panel(124, 179), new Panel(184, 179), new Panel(244, 179), new Panel(304, 179)
    }
    , 
  {
    new Panel(4, 216), new Panel(64, 216), new Panel(124, 216), new Panel(184, 216), new Panel(244, 216), new Panel(304, 216)
    }
  };
int[] FrameCount = {
  1, 8, 4, 4, 13
};
boolean moved;
boolean modeChanged;
boolean displayMenu;
int MODE;
int changeMenuCounter;
ChipMenu Chips;

void setup() {
  size(360, 240);
  background(0);
  frameRate(30);
  panels = loadImage("../Sprites/platform/backGround.png");
  panels.resize((int)(panels.width*1.5), (int)(panels.height*1.5));
  enteringChipMenu = loadImage("../Sprites/chipSelection/000.png");
  enteringChipMenu.resize((int)(enteringChipMenu.width*1.5), (int)(enteringChipMenu.height*1.5));
  //parameter1 gives the directory, parameter2 is the amount of frames
  //look in the directory and replace "07" with the first two numbers
  //of the sequence of frames you want to see. Replace the second parameter
  //with the amount of frames in the sequence.
  megaman = new Megaman();
  backGround = new Animation("../Sprites/backgrounds/00", 8);
  Chips = new ChipMenu();
}

void draw() {
  background(0);
  backGround.display(0, height/2);
  image(panels, width/2 - panels.width/2, height/2); 
  move();
  checkMode();
  Chips.display(displayMenu);
}

void mousePressed() {
  print(mouseX + " " + mouseY + "\n");
}

//!currentlyMoving is important in order for megaman to not be able to move in the middle of his animation!
void keyPressed() {
  //left
  if (keyCode == 37) {
    if (!currentlyMoving() && megaman.getCol() > 0) {
      Keys[0] = true;
    }
  }
  //right
  if (keyCode == 39) {
    if (!currentlyMoving() && megaman.getCol() < 2) {
      Keys[1] = true;
    }
  }
  //up
  if (keyCode == 38) {
    if (!currentlyMoving() && megaman.getRow() > 0) {
      Keys[2] = true;
    }
  }
  //down
  if (keyCode == 40) {
    if (!currentlyMoving() && megaman.getRow() < 2) {
      Keys[3] = true;
    }
  }
  // A and S (L and R on GBA)
  if (keyCode == 65 || keyCode == 83) {
    MODE = 1;
    modeChanged = true;
  }
  // Z (A on GBA)
  if (keyCode == 90) {
    MODE = 0;
    displayMenu = false;
  }
  // X (B on GBA)
  if (keyCode == 88){
    if (!currentlyMoving()){
      Keys[4] = true;
    }
  }  
  println(keyCode);
}

//this is important.
//it returns true if megaman is in the middle of an animation.
boolean currentlyMoving() {
  for (int i = 0; i < Keys.length; i++) {
    if (Keys[i]) {
      return true;
    }
  }
  return false;
}

//Moves Megaman, DO NOT CHANGE. Grid is a double array of panels which holds coordinates. Megaman is able to move by looking at the panel's coordinates.
//The code is long and complicated because of animations, if you have any questions ask me on facebook.
//The keys basically store whether a key is pressed. 

void move() {
  //this mode tells the method to only work when not in chip selecting menu.
  if (MODE == 0) {
    //this basically causes megaman to do his leaving panel animation, then moves him, and finally does his arriving panel animation.
    if (Keys[0]) {
      if (megaman.LeavePanel.currentFrame < FrameCount[3] - 1) {  
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 3, 0);
      } else if (megaman.LeavePanel.currentFrame == FrameCount[3] - 1) {
        if (!moved) {
          megaman.setCol(megaman.getCol() - 1);
          moved = true;
        }
        if (megaman.ArrivePanel.currentFrame < FrameCount[2] - 1) {  
          megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 2, 0);
        } else if (megaman.ArrivePanel.currentFrame == FrameCount[2] - 1) {
          megaman.LeavePanel.currentFrame = 0;
          megaman.ArrivePanel.currentFrame = 0;
          Keys[0] = false;
          moved = false;
        }
      }
    }
    if (Keys[1]) {
      if (megaman.LeavePanel.currentFrame < FrameCount[3] - 1) {  
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 3, 0);
      } else if (megaman.LeavePanel.currentFrame == FrameCount[3] - 1) {
        if (!moved) {
          megaman.setCol(megaman.getCol() + 1);
          moved = true;
        }
        if (megaman.ArrivePanel.currentFrame < FrameCount[2] - 1) {  
          megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 2, 0);
        } else if (megaman.ArrivePanel.currentFrame == FrameCount[2] - 1) {
          megaman.LeavePanel.currentFrame = 0;
          megaman.ArrivePanel.currentFrame = 0;
          Keys[1] = false;
          moved = false;
        }
      }
    }
    if (Keys[2]) {
      if (megaman.LeavePanel.currentFrame < FrameCount[3] - 1) {  
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 3, 0);
      } else if (megaman.LeavePanel.currentFrame == FrameCount[3] - 1) {
        if (!moved) {
          megaman.setRow(megaman.getRow() - 1);
          moved = true;
        }
        if (megaman.ArrivePanel.currentFrame < FrameCount[2] - 1) {  
          megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 2, 0);
        } else if (megaman.ArrivePanel.currentFrame == FrameCount[2] - 1) {
          megaman.LeavePanel.currentFrame = 0;
          megaman.ArrivePanel.currentFrame = 0;
          Keys[2] = false;
          moved = false;
        }
      }
    }  
    if (Keys[3]) {
      if (megaman.LeavePanel.currentFrame < FrameCount[3] - 1) {  
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 3, 0);
      } else if (megaman.LeavePanel.currentFrame == FrameCount[3] - 1) {
        if (!moved) {
          megaman.setRow(megaman.getRow() + 1);
          moved = true;
        }
        if (megaman.ArrivePanel.currentFrame < FrameCount[2] - 1) {  
          megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 2, 0);
        } else if (megaman.ArrivePanel.currentFrame == FrameCount[2] - 1) {
          megaman.LeavePanel.currentFrame = 0;
          megaman.ArrivePanel.currentFrame = 0;
          Keys[3] = false;
          moved = false;
        }
      }
      if (Keys[4]){
        if (megaman.Buster.currentFrame < FrameCount[4] - 1) {
          megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 4, 0);
        }else if (megaman.Buster.currentFrame == FrameCount[4] - 1){
          megaman.Buster.currentFrame = 0;
        }
        Keys[4] = false;
        
      }
      //this basically asks if megaman isn't doing anything. If he isn't, display his standing position.
    } else if (!currentlyMoving()) {
      megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, 0);
    }
  }
  //this tells megaman to freeze when mode is 1 which is when you are selecting your chips.
  if (MODE == 1) {
    megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), megaman.currentAnimation, 1);
  }
}

void checkMode() {
  if (modeChanged && MODE == 1) {
    changeMenu();
  }
}

//this causes the scrolling menu animation and toggles menu to display
void changeMenu() {
  if (changeMenuCounter < 7) {
    System.out.println("is working");
    image(enteringChipMenu, -90 + 15*changeMenuCounter, 0);
    changeMenuCounter += 1;
  } else {
    modeChanged = false;
    changeMenuCounter = 0;
    displayMenu = true;
  }
}

