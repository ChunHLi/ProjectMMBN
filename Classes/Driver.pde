import java.util.*;

Megaman megaman;
Mettaur mettaur;
Animation backGround;
PImage panels;
PImage enteringChipMenu;
float xpos;
float ypos;
boolean[] Keys = {
  false, false, false, false, false, false
  //0 left, 1 right, 2 up, 3 down, 4 buster, 5 slash
}; 
int customCounter;
playList OST;

Panel[][] Grid = {
  {
    new Panel(4, 142), new Panel(64, 142), new Panel(124, 142), new Panel(184, 142), new Panel(244, 142), new Panel(304, 142)
    }
    , 
  {
    new Panel(4, 179), new Panel(64, 179), new Panel(124, 179), new Panel(184, 179), new Panel(244, 179, true), new Panel(304, 179)
    }
    , 
  {
    new Panel(4, 216), new Panel(64, 216), new Panel(124, 216), new Panel(184, 216), new Panel(244, 216), new Panel(304, 216)
    }
  };
int[] FrameCount = {
  1, 8, 4, 4, 8, 4, 7, 13, 4
    //0 , 1 , 2 ArrivePanel, 3 LeavePanel, 4 Buster, 5 BlueCharge, 6 PurpleCharge, 7 mettaur, 8 slash
};
PImage[] numberText = new PImage[10];
boolean moved;
boolean modeChanged;
boolean displayMenu;
int MODE;
int changeMenuCounter;
ChipMenu Chips;
boolean isX, isXReleased;
int chargeFrame;
int mettaurTimer;
boolean mettaurMove;
Animation customBar;
AudioPlayer virusBattleTheme;

void setup() {
  size(360, 240);
  background(0);
  frameRate(30);
  panels = loadImage("../Sprites/platform/backGround.png");
  panels.resize((int)(panels.width*1.5), (int)(panels.height*1.5));
  enteringChipMenu = loadImage("../Sprites/chipSelection/000.png");
  enteringChipMenu.resize((int)(enteringChipMenu.width*1.5), (int)(enteringChipMenu.height*1.5));
  for (int y = 0; y < 10; y++) {
    String txtDirectory = "../Sprites/textArt/text/" + y + ".png";
    numberText[y] = loadImage(txtDirectory);
    numberText[y].resize((int)(numberText[y].width*1.5), (int)(numberText[y].height*1.5));
  }
  //parameter1 gives the directory, parameter2 is the amount of frames
  //look in the directory and replace "07" with the first two numbers
  //of the sequence of frames you want to see. Replace the second parameter
  //with the amount of frames in the sequence.
  megaman = new Megaman();
  mettaur = new Mettaur();
  backGround = new Animation("../Sprites/backgrounds/00", 8);
  Chips = new ChipMenu();
  isXReleased = true;
  chargeFrame = 0;
  mettaurTimer = 0;
  customBar = new Animation("../Sprites/textArt/text/custom",5);
  OST = new playList();
  Minim minim1 = new Minim(this);
  Minim minim2 = new Minim(this);
  Minim minim3 = new Minim(this);
  Minim minim4 = new Minim(this);
  Minim minim5 = new Minim(this);
  Minim minim6 = new Minim(this);
  OST.add("../Music/01.mp3",minim1,5000);
  OST.add("../Music/02.mp3",minim2);
  OST.add("../Music/03.mp3",minim3);
  OST.add("../Music/04.mp3",minim4,5000);
  OST.add("../Music/05.mp3",minim5,21000);
  OST.add("../Music/06.mp3",minim6);
}

void draw() {
  background(0);
  backGround.display(0, height/2);
  image(panels, width/2 - panels.width/2, height/2);
  if (MODE == 0) {
    showHP(0);
  }
  processKeys();
  move();
  charge();
  mettaurMove();
  checkMode();
  Chips.display(displayMenu);
  if (displayMenu) {
    showHP(180);
  }
  mettaurTimer++;
  if (MODE == 0){
    customBar.displayCustom(width/5,16);
  }
  OST.playTheList();
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
  if (((keyCode == 65 || keyCode == 83) && MODE == 0) && customBar.customBarCount == 288){
    MODE = 1;
    modeChanged = true;
    customBar.customBarCount = 0;
    customBar.currentFrame = 0;
  }
  // Z (A on GBA)
  if (keyCode == 90 && MODE == 1) {
    MODE = 0;
    modeChanged = true;
    displayMenu = false;
    customBar.customBarCount = 0;
  }
  // X (B on GBA)
  if (keyCode == 88) {
    if (!currentlyMoving()) {
      isX = true;
    }
  }
  if (keyCode == 32){
    OST.nextSong();
  }
  if (keyCode == 86){
   if (!currentlyMoving()){
    Keys[5] = true;
   } 
  }
  println(keyCode);
}

void keyReleased() {
  if (keyCode == 88) {
    isX = false;
    isXReleased = true;
    Keys[4] = true;
    if (chargeFrame >18) {
      if (megaman.getBuster() < 6) {
        megaman.setBuster(megaman.getBuster()*10);
      }
    }
  }
}

void processKeys() {
  if (isX && isXReleased) {
    isXReleased = false;
  }
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
    }
    if (Keys[4]) {
      if (megaman.Buster.currentFrame < FrameCount[4] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 4, 0);
      } else if (megaman.Buster.currentFrame == FrameCount[4] - 1) {
        megaman.Buster.currentFrame = 0;
        Keys[4] = false;
        if (mettaur.getRow() == megaman.getRow()) {
          mettaur.hurt(megaman.getBuster());
        }
        if (chargeFrame > 18) {
          megaman.setBuster(megaman.getBuster()/10);
        }
        chargeFrame = 0;
      }
    }
    if (Keys[5]){
      if (megaman.Slash.currentFrame < FrameCount[8] - 1){
       megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 5, 0, "widesword");
      } else if (megaman.Slash.currentFrame == FrameCount[8] - 1){
       megaman.Slash.currentFrame = 0;
       Keys[5] = false;
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
  if (modeChanged && MODE == 0) {
    changeBattle();
  }
}

//this causes the scrolling menu animation and toggles menu to display
void changeMenu() {
  if (changeMenuCounter < 6) {
    image(enteringChipMenu, -180 + 30*changeMenuCounter, 0);
    showHP(30*changeMenuCounter);
    changeMenuCounter += 1;
  } else {
    modeChanged = false;
    changeMenuCounter = 0;
    displayMenu = true;
  }
}

void changeBattle() {
  if (changeMenuCounter < 6) {
    image(enteringChipMenu, 0 - 30 * changeMenuCounter, 0);
    showHP(180 - 30*changeMenuCounter);
    changeMenuCounter += 1;
  } 
  //else if (changeMenuCounter 
  else {
    modeChanged = false;
    changeMenuCounter = 0;
    displayMenu = false;
  }
}

void charge() {
  if (MODE == 0) {
    if (!isXReleased) {
      if (chargeFrame < 19) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 98, 0, chargeFrame%7);
      } else if (chargeFrame > 18) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 99, 0, (chargeFrame-18)%11);
      }
      chargeFrame++;
    }
  }
}

void mettaurMove() {
  if (MODE == 0) {
    if (mettaurMove){
      if (mettaur.Attack.currentFrame < FrameCount[7] - 1){
        mettaur.display(Grid[mettaur.getRow()][mettaur.getCol()].getLocationX(), Grid[mettaur.getRow()][mettaur.getCol()].getLocationY(), 1, 0);
      } else if (mettaur.Attack.currentFrame == FrameCount[7] - 1){
        mettaurMove = false;
        mettaur.Attack.currentFrame = 0;
        mettaurTimer = 0;
      }
    } else {
      if (mettaurTimer > 30) {
        if (mettaur.getRow() != megaman.getRow()) {
          if (mettaur.getRow() < megaman.getRow()) {
            mettaur.setRow(mettaur.getRow()+1);
          } else {
            mettaur.setRow(mettaur.getRow()-1);
          }
          mettaur.display(Grid[mettaur.getRow()][mettaur.getCol()].getLocationX(), Grid[mettaur.getRow()][mettaur.getCol()].getLocationY(), 0, 0);
          mettaurTimer = 0;
        } else {
          mettaurMove = true;
        }
  
      } else {
        mettaur.display(Grid[mettaur.getRow()][mettaur.getCol()].getLocationX(), Grid[mettaur.getRow()][mettaur.getCol()].getLocationY(), 0, 0);
      }
    }
  }
  if (MODE == 1) {
    mettaur.display(Grid[mettaur.getRow()][mettaur.getCol()].getLocationX(), Grid[mettaur.getRow()][mettaur.getCol()].getLocationY(), 0, 1);
  }
}


void showHP(int translation) {
  //Megaman's HP
  fill(56, 80, 104);
  stroke(255);
  rect(0 + translation, 0, 45, 20);
  if (megaman.getHP()%10!=1) {
    image(numberText[megaman.getHP()%10], 32 + translation, 2);
  } else {
    image(numberText[megaman.getHP()%10], 37 + translation, 2);
  }
  if (megaman.getHP()%100/10 != 1) {
    image(numberText[megaman.getHP()%100/10], 22 + translation, 2);
  } else {
    image(numberText[megaman.getHP()%100/10], 27 + translation, 2);
  }
  if (megaman.getHP()%1000/100 != 1) {
    image(numberText[megaman.getHP()%1000/100], 12 + translation, 2);
  } else {
    image(numberText[megaman.getHP()%1000/100], 17 + translation, 2);
  }

  //Enemy
  if (mettaur.getHP()%10!=1) {
    image(numberText[mettaur.getHP()%10], Grid[mettaur.getRow()][mettaur.getCol()].getLocationX()+32, Grid[mettaur.getRow()][mettaur.getCol()].getLocationY()+5);
  } else {
    image(numberText[mettaur.getHP()%10], Grid[mettaur.getRow()][mettaur.getCol()].getLocationX()+37, Grid[mettaur.getRow()][mettaur.getCol()].getLocationY()+5);
  }
  if (mettaur.getHP()%100/10 != 1) {
    image(numberText[mettaur.getHP()%100/10], Grid[mettaur.getRow()][mettaur.getCol()].getLocationX()+22, Grid[mettaur.getRow()][mettaur.getCol()].getLocationY()+5);
  } else {
    image(numberText[mettaur.getHP()%100/10], Grid[mettaur.getRow()][mettaur.getCol()].getLocationX()+27, Grid[mettaur.getRow()][mettaur.getCol()].getLocationY()+5);
  }
}




