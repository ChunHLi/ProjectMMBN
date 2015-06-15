import java.util.*;
import ddf.minim.*;

Megaman megaman;
Mettaur mettaur;
Protoman protoman;
Animation backGround;
PImage panels;
PImage enteringChipMenu;
PImage menu;
PImage name;
PImage mouseEmblem;
PImage menuTutorial;
PImage Protoman;
PImage Mettaur;
PImage Proto;
PImage logo;
float xpos;
float ypos;
float tint;

float transitionXPos = 360;
int rotateSpeed = 45;
boolean speedUP;
boolean delay;
boolean darken;
boolean chipInvis;
AudioPlayer Intro;
boolean[] Keys = {
  false, false, false, false, false
    //0 left, 1 right, 2 up, 3 down, 4 buster
};
boolean isTutorial;
int[] FrameCount = {
  1, 8, 4, 4, 5, 4, 7, 13
    //0 , 1 , 2 ArrivePanel, 3 LeavePanel, 4 Buster, 5 BlueCharge, 6 PurpleCharge, 7 mettaur, 8 recover
};
int customCounter;
int rotateCounter;
float nameCounter;
PlayList OST;

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
boolean[] ChipKey = {
  false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false
    //0 sword, 1 widesword, 2 longsword, 3 lifesword, 4 cannon, 5 spreader, 6 bomb, 7 airshot, 8 vulcan, 9 guard, 10 recovery, 11 guard3, 12 wideblade, 13 longblade, 14 stepsword
  //15 recover80
};
boolean[] holder = {
  false, false, false, false
    //0invis, 1barrier, 2firehit, 3boomer
};
int[] chipCount = {
  7, 7, 10, 10, 10, 8, 6, 5, 8, 7, 6, 7, 7, 10, 8, 6
    //0 sword, 1 widesword, 2 longsword, 3 lifesword, 4 cannon, 5 spreader, 6 bomb, 7 airshot, 8 vulcan, 9 guard, 10 recovery, 11 guard3, 12 wideblade, 13 longblade, 14stepsword
  //15 recovery80
};

boolean[] navi = {
  false, false, false, false, false
    //0 proto, 1 colonel, 2 protoSP, 3 dblHero, 4 TwinLeader
};
boolean[] PA = {
  false, false, false
    //0 gigacannon, 1 hispread
};
int[] PAC = {
  10, 8
    //0 gigacannon, 1 hispread
};

PImage[] numberText = new PImage[10];
boolean moved;
boolean modeChanged = true;
boolean displayMenu;
boolean displayCrosses;
boolean displayMettaurTransition;
boolean displayProtoTransition;
int MODE = -1;
int Delay;
int changeMenuCounter;
int opacityCounter = 127;
boolean shift;
ChipMenu Chips;
boolean isX, isXReleased;
int chargeFrame;
int mettaurTimer;
boolean mettaurMove;
Animation customBar;
AudioPlayer virusBattleTheme;
ArrayList<VirusAttack> virusForce;
ArrayList<Chip> tutorialFolder;
PImage pause;
ChipAttack attacks;
boolean targetFound;
Animation start;

void setup() {
  size(360, 240);
  background(0);
  frameRate(30);
  panels = loadImage("../Sprites/platform/backGround.png");
  panels.resize((int)(panels.width*1.5), (int)(panels.height*1.5));
  enteringChipMenu = loadImage("../Sprites/chipSelection/000.png");
  enteringChipMenu.resize((int)(enteringChipMenu.width*1.5), (int)(enteringChipMenu.height*1.5));
  menu = loadImage("../Sprites/backgrounds/backGround1.png");
  name = loadImage("../Sprites/backgrounds/name.png");
  name.resize(150, 40);
  mouseEmblem = loadImage("../Sprites/backgrounds/emblem.gif");
  mouseEmblem.resize(18, 18);
  logo = loadImage("../Sprites/backgrounds/logo.png");
  Protoman = loadImage("../Sprites/backgrounds/protoman.png");
  Protoman.resize(160, 18);
  Mettaur = loadImage("../Sprites/backgrounds/mettaur.png");
  Proto = loadImage("../Sprites/backgrounds/proto.png");
  menuTutorial = loadImage("../Sprites/backgrounds/menuTutorial.png");
  menuTutorial.resize(150, 18);
  for (int y = 0; y < 10; y++) {
    String txtDirectory = "../Sprites/textArt/text/" + y + ".png";
    numberText[y] = loadImage(txtDirectory);
    numberText[y].resize((int)(numberText[y].width*1.5), (int)(numberText[y].height*1.5));
  }
  start = new Animation("../Sprites/textArt/start/00", 6, 1);
  pause = loadImage("../Sprites/textArt/text/Pause.png");
  pause.resize((int)(pause.width*1.5), (int)(pause.height*1.5));
  //parameter1 gives the directory, parameter2 is the amount of frames
  //look in the directory and replace "07" with the first two numbers
  //of the sequence of frames you want to see. Replace the second parameter
  //with the amount of frames in the sequence.
  megaman = new Megaman();
  //mettaur = new Mettaur();
  backGround = new Animation("../Sprites/backgrounds/00", 8);
  isXReleased = true;
  chargeFrame = 0;
  //mettaurTimer = 0;
  customBar = new Animation("../Sprites/textArt/text/custom", 5);
  OST = new PlayList();
  virusForce = new ArrayList<VirusAttack>(0);
  attacks = new ChipAttack();
  //tutorialFolder
  Minim minim1 = new Minim(this);
  Minim minim2 = new Minim(this);
  Minim minim3 = new Minim(this);
  Minim minim4 = new Minim(this);
  Minim minim5 = new Minim(this);
  Minim minim6 = new Minim(this);
  Minim intro = new Minim(this);
  Intro = intro.loadFile("../Music/intro.mp3");
  Intro.skip(14400);
  Intro.setGain(-15);
  OST.add("../Music/01.mp3", minim1, 5000);
  OST.add("../Music/02.mp3", minim2);
  OST.add("../Music/03.mp3", minim3);
  OST.add("../Music/04.mp3", minim4, 5000);
  OST.add("../Music/05.mp3", minim5, 21000);
  OST.add("../Music/06.mp3", minim6);
  noCursor();
}

void draw() {
  background(0);
  if (MODE == -1) {
    Intro.play();
    tint(tint);
    tint += 5;
    image(menu, 0, 12);
    if (opacityCounter >= 255) {
      shift = true;
    }
    if (opacityCounter <= 64) {
      shift = false;
    }
    if (shift) {
      opacityCounter -= 5;
    } else {
      opacityCounter += 5;
    }
    tint(tint, opacityCounter);
    image(logo, 20, 0);
    tint(tint);
    if (nameCounter > -30) {
      if (nameCounter < 0) {
        image(name, width - 150, height - 40 + nameCounter/5.0);
      } else {
        image(name, width - 150, height - 40 - nameCounter/5.0);
      }
      nameCounter -= 1;
    } else {
      nameCounter = 30;
      image(name, width - 150, height - 40 - nameCounter/5.0);
    }
    if ((mouseX > 107 && mouseX < 257) && (mouseY > 140 && mouseY < 158)) {
      menuTutorial.filter(INVERT);
    }
    if ((mouseX > 100 && mouseX < 250) && (mouseY > 170 && mouseY < 188)) {
      Protoman.filter(INVERT);
    }
    image(menuTutorial, 107, 140);
    image(Protoman, 100, 170);
    displayTransition();
  } else {
    tint(255);
    background(0);
    backGround.display(0, height/2, 0);
    image(panels, width/2 - panels.width/2, height/2);
    //showPanelDanger();
    megaman.getHurt(Grid);
    if (MODE == 0) {
      showHP(0);
    }
    moveCursor();
    processKeys();
    move();
    charge();
    attacks.move(Grid);
    if (isTutorial) {
      mettaur.getHurt(Grid);
      if (mettaur.HP < 1){
        if (mettaur.death.currentFrame < 14){
         mettaur.death.displayChips(Grid[mettaur.getRow()][mettaur.getCol()].getLocationX()-40, Grid[mettaur.getRow()][mettaur.getCol()].getLocationY());
        } else {
         exit(); 
        }
      } else{
        mettaurMove();
      }
      mettaurTimer++;
    } else {
      protoman.hurt(Grid, MODE, megaman);
      if (protoman.HP < 1){
        if (protoman.death.currentFrame < 27){
          protoman.death.displayChips(Grid[protoman.getRow()][protoman.getCol()].getLocationX(), Grid[protoman.getRow()][protoman.getCol()].getLocationY());
        } else {
          exit(); 
        }
      } else{
        protoman.sequence(Grid, MODE, megaman);
      }
    }
    checkMode();
    Chips.display(displayMenu);
    if (displayMenu) {
      showHP(180);
    }
    if (MODE == 1) {
      Chips.displayCursor();
      if (displayCrosses) {
        Chips.displayCrossCursor();
      }
    }
    if (MODE == 0) {
      customBar.displayCustom(width/5, 20);
      if (!currentlyMoving()) {
        Chips.selected.displayBattle(MODE, Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY());
      }
    }
    if (virusForce.size() > 0) {
      int counter = 0;
      while (counter < virusForce.size ()) {
        virusForce.get(counter).move(Grid);
        counter += 1;
      }
    }
    Chips.selected.PA();
    if (Chips.selected.animationSequence < 151 && Chips.selected.animationSequence > 144) {
      if (start.currentFrame < 6) {
        start.displayChips(100, 100);
      } else {
        start.currentFrame = 0;
      }
    }
    if (Chips.selected.animationSequence == 151) {
      MODE = 0;
    }
    reset();
    OST.playTheList();
  }
  pushMatrix();
  imageMode(CENTER);
  translate(mouseX, mouseY);
  rotate(rotateCounter*TWO_PI/rotateSpeed);
  image(mouseEmblem, 0, 0);
  imageMode(CORNER);
  popMatrix();
  if (speedUP) {
    rotateCounter += 3;
  } else {
    rotateCounter += 1;
  }
}

void mousePressed() {
  print(mouseX + " " + mouseY + "\n");
  speedUP = true;
  if (MODE == -1) {
    if (((mouseX > 107 && mouseX < 257) && (mouseY > 140 && mouseY < 158)) && (displayProtoTransition == false)) {
      displayMettaurTransition = true;
    }
    if (((mouseX > 100 && mouseX < 250) && (mouseY > 170 && mouseY < 188)) && (displayMettaurTransition == false)) {
      displayProtoTransition = true;
    }
  }
}

void mouseReleased() {
  speedUP = false;
}

void displayTransition() {
  if (displayMettaurTransition) {
    image(Mettaur, transitionXPos, 12);
    if (transitionXPos < -390) {
      displayMettaurTransition = false;
      mettaur = new Mettaur();
      Chips = new ChipMenu("tut");
      isTutorial = true;
      Intro.pause();
      MODE = 1;
    } else if (transitionXPos < -360) {
      background(10 * (-1 * transitionXPos - 360)); 
      transitionXPos -= 1;
      Intro.setGain(Intro.getGain() - 1);
    } else if (transitionXPos > 40 || transitionXPos <= 0) {
      transitionXPos -= 30;
    } else if (transitionXPos > 0) {
      transitionXPos -= 4.0/9.0;
    }
  }
  if (displayProtoTransition) {
    image(Proto, transitionXPos, 12);
    if (transitionXPos < -390) {
      protoman = new Protoman();
      Chips = new ChipMenu("sword");
      Intro.pause();
      MODE = 1;
    }
    if (transitionXPos < -360) {
      background(10 * (-1 * transitionXPos - 360));
      transitionXPos -= 1;
      Intro.setGain(Intro.getGain() - 1);
    } else if (transitionXPos > 40 || transitionXPos <= 0) {
      transitionXPos -= 30;
    } else if (transitionXPos > 0) {
      transitionXPos -= 4.0/9.0;
    }
  }
}

//!currentlyMoving is important in order for megaman to not be able to move in the middle of his animation!
void keyPressed() {
  if (MODE == -1) {
  } else {
    if (MODE == 0) {
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
    }
    if (MODE == 1) {
      if (keyCode == 37) {
        Keys[0] = true;
      }
      if (keyCode == 39) {
        Keys[1] = true;
      }
      if (keyCode == 38) {
        Keys[2] = true;
      }
      if (keyCode == 40) {
        Keys[3] = true;
      }
    }

    // A and S (L and R on GBA)
    if (((keyCode == 65 || keyCode == 83) && MODE == 0) && customBar.customBarCount == 288) {
      MODE = 1;
      modeChanged = true;
      customBar.customBarCount = 0;
      customBar.currentFrame = 0;
      Chips.empty();
    }
    if (keyCode == 81 && MODE == 1) {
      Chips.shuffleChips();
    }
    // Z (A on GBA)
    if (keyCode == 90) {
      if (MODE == 1) {
        Chips.selectChips();
      }
      if (MODE == 0) {
        if (!currentlyMoving()) {
          if (Chips.selected.size() > 0) {
            if (Chips.selected.get(0).chipID == 70) {
              ChipKey[0] = true;
            }
            if (Chips.selected.get(0).chipID == 71) {
              ChipKey[1] = true;
            }
            if (Chips.selected.get(0).chipID == 72) {
              ChipKey[2] = true;
            }
            if (Chips.selected.get(0).chipID == 1) {
              ChipKey[4] = true;
            }
            if (Chips.selected.get(0).chipID == 9) {
              ChipKey[5] = true;
            }
            if (Chips.selected.get(0).chipID == 58) {
              ChipKey[6] = true;
            }
            if (Chips.selected.get(0).chipID == 4) {
              ChipKey[7] = true;
            }
            if (Chips.selected.get(0).chipID == 5) {
              ChipKey[8] = true;
            }
            if (Chips.selected.get(0).chipID == 91) {
              ChipKey[9] = true;
            }
            if (Chips.selected.get(0).chipID == 157) {
              ChipKey[10] = true;
            }
            if (Chips.selected.get(0).chipID == 93) {
              ChipKey[11] = true;
            }
            if (Chips.selected.get(0).chipID == 73) {
              ChipKey[12] = true;
            }
            if (Chips.selected.get(0).chipID == 74) {
              ChipKey[13] = true;
            }
            if (Chips.selected.get(0).chipID == 80) {
              ChipKey[14] = true;
            }
            if (Chips.selected.get(0).chipID == 159) {
              ChipKey[15] = true;
            }
            if (Chips.selected.get(0).chipID == 179) {
              holder[1] = true;
            }
            if (Chips.selected.get(0).chipID == 180) {
              holder[0] = true;
            }
            if (Chips.selected.get(0).chipID == 107) {
              holder[2] = true;
            }
            if (Chips.selected.get(0).chipID == 121) {
              holder[3] = true;
            }
            if (Chips.selected.get(0).name.equals("Protomn")) {
              navi[0] = true;
              MODE = 3;
            }
            if (Chips.selected.get(0).name.equals("ColonelSP")) {
              navi[1] = true;
              MODE = 3;
            }
            if (Chips.selected.get(0).name.equals("ProtomnSP")) {
              navi[2] = true;
              MODE = 3;
            }
            if (Chips.selected.get(0).name.equals("LifeSwrd")) {
              ChipKey[3] = true;
            }
            if (Chips.selected.get(0).name.equals("GigaCannon")) {
              PA[0] = true;
            }
            if (Chips.selected.get(0).name.equals("HiSpread")) {
              PA[1] = true;
            }
            if (Chips.selected.get(0).name.equals("dblHero")) {
              navi[3] = true;
              MODE = 3;
            }
            if (Chips.selected.get(0).name.equals("TwinLeader")) {
              navi[4] = true;
              MODE = 3;
            }
            Chips.selected.remove(0);
          }
        }
      }
    }
    // X (B on GBA)
    if (keyCode == 88) {
      if (!currentlyMoving()) {
        isX = true;
      }
      if (displayCrosses) {
        displayCrosses = !displayCrosses;
      } else if (MODE == 1) {
        Chips.deselectChips();
      }
    }
    // enter (start on GBA)
    if (keyCode == 10) {
      if (MODE == 0) {
        MODE = 2;
        modeChanged = !modeChanged;
      } else if (MODE == 2) {
        MODE = 0;
        modeChanged = !modeChanged;
      } else {
        MODE = 4;
        modeChanged = !modeChanged;
      }
    }
    if (keyCode == 32) {
      OST.nextSong();
    }

    if (keyCode == 16) {
      if (!currentlyMoving()) {
        mettaur.HP = 0;
      }
    }

    println(keyCode);
  }
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
  if (megaman.chipInvis){
    return false;
  }
  if (megaman.invinsibleTimer > 74) {
    return true;
  }
  for (int i = 0; i < Keys.length; i++) {
    if (Keys[i]) {
      return true;
    }
  }
  for (int i = 0; i < ChipKey.length; i++) {
    if (ChipKey[i]) {
      return true;
    }
  }
  return false;
}

//Moves Megaman, DO NOT CHANGE. Grid is a double array of panels which holds coordinates. Megaman is able to move by looking at the panel's coordinates.
//The code is long and complicated because of animations, if you have any questions ask me on facebook.
//The keys basically store whether a key is pressed. 

void moveCursor() {
  if (displayMenu && displayCrosses) {
    if (Keys[2]) {
      Chips.moveCrossCursorUp();
      Keys[2] = false;
    }
    if (Keys[3]) {
      Chips.moveCrossCursorDown();
      Keys[3] = false;
    }
  } else if (displayMenu) {
    if (Keys[0]) {
      Chips.moveCursorLeft();
      Keys[0] = false;
    }
    if (Keys[1]) {
      Chips.moveCursorRight();
      Keys[1] = false;
    }
    if (Keys[2]) {
      if (Chips.cursorIndex > 4) {
        Chips.moveCursorUp();
        Keys[2] = false;
      } else {
        displayCrosses = true;
      }
    }
    if (Keys[3]) {
      Chips.moveCursorDown();
      Keys[3] = false;
    }
  }
}

void move() {
  //this mode tells the method to only work when not in chip selecting menu.
  if (MODE == 0 ) {
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
        megaman.Bullet.currentFrame = 0;
        Keys[4] = false;
        try {
          if (mettaur.getRow() == megaman.getRow()) {
            mettaur.hurt(megaman.getBuster());
            attacks.setXY("buster", Grid[mettaur.getRow()][mettaur.getCol()].getLocationX(), Grid[mettaur.getRow()][mettaur.getCol()].getLocationY(), 0, 0);
          }
          if (chargeFrame > 18) {
            megaman.setBuster(megaman.getBuster()/10);
          }
        }
        catch(NullPointerException e) {
        }
        try {
          if (protoman.getRow() == megaman.getRow()) {
            protoman.HP-=megaman.getBuster();
            attacks.setXY("buster", Grid[protoman.getRow()][mettaur.getCol()].getLocationX(), Grid[protoman.getRow()][protoman.getCol()].getLocationY(), 0, 0);
          }
          if (chargeFrame > 18) {
            megaman.setBuster(megaman.getBuster()/10);
          }
        }
        catch(NullPointerException e) {
        }
        chargeFrame = 0;
      }
    }
    if (ChipKey[10]) {
      if (megaman.Recover.currentFrame < chipCount[10] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "recover");
      } else if (megaman.Recover.currentFrame == chipCount[10] - 1) {
        megaman.heal(30);
        megaman.Recover.currentFrame = 0;
        ChipKey[10] = false;
      }
    }
    if (ChipKey[15]) {
      if (megaman.Recover.currentFrame < chipCount[15] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "recover");
      } else if (megaman.Recover.currentFrame == chipCount[15] - 1) {
        megaman.heal(80);
        megaman.Recover.currentFrame = 0;
        ChipKey[15] = false;
      }
    }
    if (holder[1]) {
      megaman.useInvis();
      holder[1] = false;
    }
    if (holder[0]) {
      megaman.barrier = true;
      megaman.bar = 50;
      megaman.bCount = 0;
      holder[0] = false;
    }
    if (ChipKey[0]) {
      if (megaman.Sword.currentFrame < chipCount[0] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "sword");
        if (megaman.Sword.currentFrame == 2) {
          Grid[megaman.getRow()][megaman.getCol()+1].setDangerVirus(true);
          Grid[megaman.getRow()][megaman.getCol()+1].setDamage(80);
        }
      } else if (megaman.Sword.currentFrame == chipCount[0] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "sword");
        megaman.Sword.currentFrame = 0;
        ChipKey[0] = false;
        reset();
      }
    }
    if (ChipKey[1]) {
      if (megaman.WideSword.currentFrame < chipCount[1] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "widesword");
        if (megaman.WideSword.currentFrame == 3) {
          Grid[megaman.getRow()][megaman.getCol()+1].setDangerVirus(true);
          Grid[megaman.getRow()][megaman.getCol()+1].setDamage(80);
          try {
            Grid[megaman.getRow()+1][megaman.getCol()+1].setDangerVirus(true);
            Grid[megaman.getRow()+1][megaman.getCol()+1].setDamage(80);
          } 
          catch (ArrayIndexOutOfBoundsException e) {
          }
          try {
            Grid[megaman.getRow()-1][megaman.getCol()+1].setDangerVirus(true);
            Grid[megaman.getRow()-1][megaman.getCol()+1].setDamage(80);
          } 
          catch (ArrayIndexOutOfBoundsException e) {
          }
        }
      } else if (megaman.WideSword.currentFrame == chipCount[1] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "widesword");
        megaman.WideSword.currentFrame = 0;
        ChipKey[1] = false;
        reset();
      }
    }
    if (ChipKey[2]) {
      if (megaman.LongSword.currentFrame < chipCount[2] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "longsword");
        if (megaman.LongSword.currentFrame == 4) {
          Grid[megaman.getRow()][megaman.getCol()+1].setDangerVirus(true);
          Grid[megaman.getRow()][megaman.getCol()+1].setDamage(80);
          Grid[megaman.getRow()][megaman.getCol()+2].setDangerVirus(true);
          Grid[megaman.getRow()][megaman.getCol()+2].setDamage(80);
        }
      } else if (megaman.LongSword.currentFrame == chipCount[2] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "longsword");
        megaman.LongSword.currentFrame = 0;
        ChipKey[2] = false;
        reset();
      }
    }
    if (ChipKey[3]) {
      if (megaman.LifeSword.currentFrame < chipCount[3] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "lifesword");
      } 
      if (megaman.LifeSword.currentFrame == 4) {
        Grid[megaman.getRow()][megaman.getCol()+1].setDangerVirus(true);
        Grid[megaman.getRow()][megaman.getCol()+1].setDamage(600);
        Grid[megaman.getRow()][megaman.getCol()+2].setDangerVirus(true);
        Grid[megaman.getRow()][megaman.getCol()+2].setDamage(600);
        try {
          Grid[megaman.getRow()+1][megaman.getCol()+1].setDangerVirus(true);
          Grid[megaman.getRow()+1][megaman.getCol()+1].setDamage(600);
          Grid[megaman.getRow()+1][megaman.getCol()+2].setDangerVirus(true);
          Grid[megaman.getRow()+1][megaman.getCol()+2].setDamage(600);
        } 
        catch (ArrayIndexOutOfBoundsException e) {
        }
        try {
          Grid[megaman.getRow()-1][megaman.getCol()+1].setDangerVirus(true);
          Grid[megaman.getRow()-1][megaman.getCol()+1].setDamage(600);
          Grid[megaman.getRow()-1][megaman.getCol()+2].setDangerVirus(true);
          Grid[megaman.getRow()-1][megaman.getCol()+2].setDamage(600);
        } 
        catch (ArrayIndexOutOfBoundsException e) {
        }
      } else if (megaman.LifeSword.currentFrame == chipCount[3] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "lifesword");
        megaman.LifeSword.currentFrame = 0;
        ChipKey[3] = false;
        reset();
      }
    }
    if (ChipKey[4]) {
      if (megaman.Cannon.currentFrame < chipCount[4] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "cannon");
      } else if (megaman.Cannon.currentFrame == chipCount[4] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "cannon");
        megaman.Cannon.currentFrame = 0;
        megaman.Blast.currentFrame = 0;
        try {
          if (mettaur.getRow() == megaman.getRow()) {
            mettaur.hurt(40);
            attacks.setXY("cannon", Grid[mettaur.getRow()][mettaur.getCol()].getLocationX(), Grid[mettaur.getRow()][mettaur.getCol()].getLocationY(), 0, 0);
          }
        }
        catch(NullPointerException e) {
        }
        try {
          if (protoman.getRow() == megaman.getRow()) {
            protoman.HP-=40;
            attacks.setXY("cannon", Grid[protoman.getRow()][protoman.getCol()].getLocationX(), Grid[protoman.getRow()][protoman.getCol()].getLocationY(), 0, 0);
          }
        }
        catch(NullPointerException e) {
        }
        ChipKey[4] = false;
      }
    }
    if (ChipKey[5]) {
      if (megaman.Spreader.currentFrame < chipCount[5] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "spreader");
        if (megaman.Spreader.currentFrame == chipCount[5] - 2) {
          try {
            if (mettaur.getRow() == megaman.getRow()) {
              attacks.setXY("spreader", Grid[mettaur.getRow()][mettaur.getCol()].getLocationX(), Grid[mettaur.getRow()][mettaur.getCol()].getLocationY(), 0, 0);
              for (int x = mettaur.getRow ()-1; x < 3; x++) {
                for (int y = mettaur.getCol ()-1; y < 6; y++) {
                  try {
                    Grid[x][y].setDamage(30);
                    Grid[x][y].setDangerVirus(true);
                  }
                  catch(ArrayIndexOutOfBoundsException e) {
                  }
                }
              }
            }
          }
          catch(NullPointerException e) {
          }
          try {
            if (protoman.getRow() == megaman.getRow()) {
              attacks.setXY("spreader", Grid[protoman.getRow()][protoman.getCol()].getLocationX(), Grid[protoman.getRow()][protoman.getCol()].getLocationY(), 0, 0);
              for (int x = protoman.getRow ()-1; x < 3; x++) {
                for (int y = protoman.getCol ()-1; y < 6; y++) {
                  try {
                    Grid[x][y].setDamage(30);
                    Grid[x][y].setDangerVirus(true);
                  }
                  catch(ArrayIndexOutOfBoundsException e) {
                  }
                }
              }
            }
          }
          catch(NullPointerException e) {
          }
        }
      } else if (megaman.Spreader.currentFrame == chipCount[5] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "spreader");
        megaman.Spreader.currentFrame = 0;
        ChipKey[5] = false;
        reset();
      }
    }
    if (ChipKey[6]) {
      if (megaman.Throw.currentFrame < chipCount[6] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "bomb");
      } else if (megaman.Throw.currentFrame == chipCount[6] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "bomb");
        megaman.Throw.currentFrame = 0;
        attacks.setXY("bomb", Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), megaman.getCol(), megaman.getRow());
        ChipKey[6] = false;
      }
    }
    if (ChipKey[7]) {
      if (megaman.AirShot.currentFrame < chipCount[7] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "airshot");
      } else if (megaman.AirShot.currentFrame == chipCount[7] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "airshot");
        megaman.AirShot.currentFrame = 0;
        try {
          if (mettaur.getRow() == megaman.getRow()) {
            mettaur.hurt(10);
            if (mettaur.getCol() < 5) {
              mettaur.setCol(mettaur.getCol()+1);
            }
          }
        }
        catch(NullPointerException e) {
        }
        try {
          if (protoman.getRow() == megaman.getRow()) {
            protoman.HP-=10;
            if (protoman.getCol() < 5) {
              protoman.panelCol++;
            }
          }
        }
        catch(NullPointerException e) {
        }
        ChipKey[7] = false;
      }
    }
    if (ChipKey[8]) {
      if (megaman.Vulcan.currentFrame < chipCount[8] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "vulcan");
        if (megaman.Vulcan.currentFrame > 1 && megaman.Vulcan.currentFrame % 2 == 0) {
          try {
            if (mettaur.getRow() == megaman.getRow()) {
              mettaur.hurt(10);
            }
          }
          catch(NullPointerException e) {
          }
          try {
            if (protoman.getRow() == megaman.getRow()) {
              protoman.HP-=10;
            }
          }
          catch(NullPointerException e) {
          }
        }
      } else if (megaman.Vulcan.currentFrame == chipCount[8] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "vulcan");
        megaman.Vulcan.currentFrame = 0;
        ChipKey[8] = false;
      }
    }
    if (ChipKey[9]) {
      if (megaman.Guard.currentFrame < chipCount[9] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "guard");
        megaman.invinsibleTimer = 1;
      }
      if (megaman.Guard.currentFrame > 3){
        if (Grid[megaman.getRow()][megaman.getCol()].isDangerMM()) {
            Grid[megaman.getRow()][megaman.getCol()].setDangerMM(false);
            attacks.setXY("guard", 0, 0, megaman.getRow(), megaman.getCol());
        }
        if (megaman.Guard.currentFrame == chipCount[9] - 1) {
          megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "guard");
          megaman.Guard.currentFrame = 0;
          ChipKey[9] = false;
          megaman.invinsibleTimer = 0;
        }
      }
    }
    if (ChipKey[11]) {
      if (megaman.Guard3.currentFrame < chipCount[11] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "guard3");
      } else if (megaman.Guard3.currentFrame == chipCount[11] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "guard3");
        megaman.Guard3.currentFrame = 0;
        if (Grid[megaman.getRow()][megaman.getCol()].isDangerMM()) {
          Grid[megaman.getRow()][megaman.getCol()].toggleDangerMM();
          attacks.setXY("guard3", 0, 0, megaman.getRow(), megaman.getCol());
        }
        ChipKey[11] = false;
      }
    }
    if (ChipKey[12]) {
      if (megaman.WideSword.currentFrame < chipCount[12] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "widesword");
        if (megaman.WideSword.currentFrame == 3) {
          Grid[megaman.getRow()][megaman.getCol()+1].setDangerVirus(true);
          Grid[megaman.getRow()][megaman.getCol()+1].setDamage(150);
          try {
            Grid[megaman.getRow()+1][megaman.getCol()+1].setDangerVirus(true);
            Grid[megaman.getRow()+1][megaman.getCol()+1].setDamage(150);
          } 
          catch (ArrayIndexOutOfBoundsException e) {
          }
          try {
            Grid[megaman.getRow()-1][megaman.getCol()+1].setDangerVirus(true);
            Grid[megaman.getRow()-1][megaman.getCol()+1].setDamage(150);
          } 
          catch (ArrayIndexOutOfBoundsException e) {
          }
        }
      } else if (megaman.WideSword.currentFrame == chipCount[12] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "widesword");
        megaman.WideSword.currentFrame = 0;
        ChipKey[12] = false;
        reset();
      }
    }
    if (ChipKey[13]) {
      if (megaman.LongSword.currentFrame < chipCount[13] - 1) {
        if (megaman.LongSword.currentFrame == 4) {
          Grid[megaman.getRow()][megaman.getCol()+1].setDangerVirus(true);
          Grid[megaman.getRow()][megaman.getCol()+1].setDamage(80);
          Grid[megaman.getRow()][megaman.getCol()+2].setDangerVirus(true);
          Grid[megaman.getRow()][megaman.getCol()+2].setDamage(80);
        }
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "longsword");
      } else if (megaman.LongSword.currentFrame == chipCount[13] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "longsword");
        megaman.LongSword.currentFrame = 0;
        ChipKey[13] = false;
        reset();
      }
    }
    if (ChipKey[14]) {
      if (megaman.getCol() < 3) {
        megaman.setCol(megaman.getCol()+3);
      }
      if (megaman.StepSword.currentFrame < chipCount[14] - 1) {
        if (megaman.StepSword.currentFrame == 3) {
          Grid[megaman.getRow()][megaman.getCol()+1].setDangerVirus(true);
          Grid[megaman.getRow()][megaman.getCol()+1].setDamage(160);
          try {
            Grid[megaman.getRow()+1][megaman.getCol()+1].setDangerVirus(true);
            Grid[megaman.getRow()+1][megaman.getCol()+1].setDamage(160);
          } 
          catch (ArrayIndexOutOfBoundsException e) {
          }
          try {
            Grid[megaman.getRow()-1][megaman.getCol()+1].setDangerVirus(true);
            Grid[megaman.getRow()-1][megaman.getCol()+1].setDamage(160);
          } 
          catch (ArrayIndexOutOfBoundsException e) {
          }
        }
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "stepsword");
      } else if (megaman.StepSword.currentFrame == chipCount[14] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "stepsword");
        megaman.StepSword.currentFrame = 0;
        if (megaman.getCol() > 2) {
          megaman.setCol(megaman.getCol()-3);
        }
        ChipKey[14] = false;
        reset();
      }
    }
    if (holder[2]) {
      for (int i = 0; i < 3; i ++) {
        for (int j = 3; j < 6; j++) {
          try {
            if (mettaur.getCol() == j && mettaur.getRow() == i) {
              attacks.setXY("firehit", Grid[mettaur.getRow()][mettaur.getCol()].getLocationX(), Grid[mettaur.getRow()][mettaur.getCol()].getLocationY(), 0, 0);
              Grid[mettaur.getRow()][mettaur.getCol()].setDamage(180);
              Grid[mettaur.getRow()][mettaur.getCol()].setDangerVirus(true);
            }
          }
          catch(NullPointerException e) {
          }
          try {
            if (protoman.getCol() == j && protoman.getRow() == i) {
              attacks.setXY("firehit", Grid[protoman.getRow()][protoman.getCol()].getLocationX(), Grid[protoman.getRow()][protoman.getCol()].getLocationY(), 0, 0);
              Grid[protoman.getRow()][protoman.getCol()].setDamage(180);
              Grid[protoman.getRow()][protoman.getCol()].setDangerVirus(true);
            }
          }
          catch(NullPointerException e) {
          }
        }
      }
      holder[2] = false;
    }
    if (holder[3]) {
      attacks.setXY("boomer", Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 2, 0);
      holder[3] = false;
    }
    if (PA[0]) {
      if (megaman.Cannon.currentFrame < PAC[0] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "cannon");
      } else if (megaman.Cannon.currentFrame == PAC[0] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "cannon");
        megaman.Cannon.currentFrame = 0;
        megaman.Blast.currentFrame = 0;
        try {
          if (mettaur.getRow() == megaman.getRow()) {
            attacks.setXY("gigacannon", Grid[mettaur.getRow()][mettaur.getCol()].getLocationX(), Grid[mettaur.getRow()][mettaur.getCol()].getLocationY(), 0, 0);
            for (int x = mettaur.getRow ()-1; x < 3; x++) {
              for (int y = mettaur.getCol ()-1; y < 6; y++) {
                try {
                  Grid[x][y].setDamage(300);
                  Grid[x][y].setDangerVirus(true);
                }
                catch(ArrayIndexOutOfBoundsException e) {
                }
              }
            }
          }
        }
        catch(NullPointerException e) {
        }
        try {
          if (protoman.getRow() == megaman.getRow()) {
            attacks.setXY("gigacannon", Grid[protoman.getRow()][protoman.getCol()].getLocationX(), Grid[protoman.getRow()][protoman.getCol()].getLocationY(), 0, 0);
            for (int x = protoman.getRow ()-1; x < 3; x++) {
              for (int y = protoman.getCol ()-1; y < 6; y++) {
                try {
                  Grid[x][y].setDamage(300);
                  Grid[x][y].setDangerVirus(true);
                }
                catch(ArrayIndexOutOfBoundsException e) {
                }
              }
            }
          }
        }
        catch(NullPointerException e) {
        }
        PA[0] = false;
      }
    }
    if (PA[1]) {
      if (megaman.Spreader.currentFrame < PAC[1] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "spreader");
      } else if (megaman.Spreader.currentFrame == chipCount[5] - 1) {
        megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, "spreader");
        megaman.Spreader.currentFrame = 0;
        try {
          if (mettaur.getRow() == megaman.getRow()) {
            attacks.setXY("hispread", Grid[mettaur.getRow()][mettaur.getCol()].getLocationX(), Grid[mettaur.getRow()][mettaur.getCol()].getLocationY(), 0, 0);
            for (int x = mettaur.getRow ()-1; x < 3; x++) {
              for (int y = mettaur.getCol ()-1; y < 6; y++) {
                try {
                  Grid[x][y].setDamage(600);
                  Grid[x][y].setDangerVirus(true);
                }
                catch(ArrayIndexOutOfBoundsException e) {
                }
              }
            }
          }
        }
        catch(NullPointerException e) {
        }
        try {
          if (protoman.getRow() == megaman.getRow()) {
            attacks.setXY("hispread", Grid[protoman.getRow()][protoman.getCol()].getLocationX(), Grid[protoman.getRow()][protoman.getCol()].getLocationY(), 0, 0);
            for (int x = protoman.getRow ()-1; x < 3; x++) {
              for (int y = protoman.getCol ()-1; y < 6; y++) {
                try {
                  Grid[x][y].setDamage(600);
                  Grid[x][y].setDangerVirus(true);
                }
                catch(ArrayIndexOutOfBoundsException e) {
                }
              }
            }
          }
        }
        catch(NullPointerException e) {
        }
        PA[1] = false;
      }
    }
    megaman.barrier(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY());
    /*
    if (megaman.invis){
     megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, 0);
     }else{*/
    if (megaman.invinsibleTimer > 74 && !megaman.chipInvis) {
      megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 1, 0);
    }
    if (megaman.invinsibleTimer == 74) {
      megaman.Hurt.currentFrame = 0;
    }
    //}
    //this basically asks if megaman isn't doing anything. If he isn't, display his standing position.
    if (!currentlyMoving()) {
      megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), 0, 0);
    }
  }
  //this tells megaman to freeze when mode is 1 which is when you are selecting your chips.
  if (MODE > 0) {
    megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY(), megaman.currentAnimation, 1);
    if (navi[0]) {
      if (megaman.Protoman1.currentFrame < 10) {
        megaman.Protoman1.displayChips(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY());
        if (megaman.Protoman1.currentFrame == 9) {
          if (megaman.Protoman2.currentFrame < 3) {
            try {
              megaman.Protoman2.displayChips(Grid[mettaur.getRow()][mettaur.getCol()-1].getLocationX(), Grid[mettaur.getRow()][mettaur.getCol()-1].getLocationY());
            }
            catch(NullPointerException e) {
            }
            try {
              megaman.Protoman2.displayChips(Grid[protoman.getRow()][protoman.getCol()-1].getLocationX(), Grid[protoman.getRow()][protoman.getCol()-1].getLocationY());
            }
            catch(NullPointerException e) {
            }
          }
          if (megaman.Protoman2.currentFrame == 2) {
            try {
              if (megaman.Protoman3.currentFrame < 11) {
                megaman.Protoman3.displayChips(Grid[mettaur.getRow()][mettaur.getCol()-1].getLocationX()-18, Grid[mettaur.getRow()][mettaur.getCol()-1].getLocationY()+32);
              }
            }
            catch(NullPointerException e) {
            }
            try {
              if (megaman.Protoman3.currentFrame < 11) {
                megaman.Protoman3.displayChips(Grid[protoman.getRow()][protoman.getCol()-1].getLocationX()-18, Grid[protoman.getRow()][protoman.getCol()-1].getLocationY()+32);
              }
            }
            catch(NullPointerException e) {
            }
            if (megaman.Protoman3.currentFrame == 10) {
              try {
                Grid[mettaur.getRow()][mettaur.getCol()].setDangerVirus(true);
                Grid[mettaur.getRow()][mettaur.getCol()].setDamage(150);
                try {
                  Grid[mettaur.getRow()-1][mettaur.getCol()].setDangerVirus(true);
                  Grid[mettaur.getRow()-1][mettaur.getCol()].setDamage(150);
                } 
                catch (ArrayIndexOutOfBoundsException e) {
                }
                try {
                  Grid[mettaur.getRow()+1][mettaur.getCol()].setDangerVirus(true);
                  Grid[mettaur.getRow()+1][mettaur.getCol()].setDamage(150);
                }
                catch (ArrayIndexOutOfBoundsException e) {
                }
              }
              catch(NullPointerException e) {
              }
              try {
                Grid[protoman.getRow()][protoman.getCol()].setDangerVirus(true);
                Grid[protoman.getRow()][protoman.getCol()].setDamage(150);
                try {
                  Grid[protoman.getRow()-1][protoman.getCol()].setDangerVirus(true);
                  Grid[protoman.getRow()-1][protoman.getCol()].setDamage(150);
                } 
                catch (ArrayIndexOutOfBoundsException e) {
                }
                try {
                  Grid[protoman.getRow()+1][protoman.getCol()].setDangerVirus(true);
                  Grid[protoman.getRow()+1][protoman.getCol()].setDamage(150);
                }
                catch (ArrayIndexOutOfBoundsException e) {
                }
              }
              catch(NullPointerException e) {
              }
              if  (megaman.Protoman4.currentFrame < 3) {
                try {
                  megaman.Protoman4.displayChips(Grid[mettaur.getRow()][mettaur.getCol()-1].getLocationX(), Grid[mettaur.getRow()][mettaur.getCol()-1].getLocationY());
                }
                catch(NullPointerException e) {
                }
                try {
                  megaman.Protoman4.displayChips(Grid[protoman.getRow()][protoman.getCol()-1].getLocationX(), Grid[protoman.getRow()][protoman.getCol()-1].getLocationY());
                }
                catch(NullPointerException e) {
                }
              }
              if (megaman.Protoman4.currentFrame == 2) {
                megaman.Protoman1.currentFrame = 0;
                megaman.Protoman2.currentFrame = 0;
                megaman.Protoman3.currentFrame = 0;
                megaman.Protoman4.currentFrame = 0;
                navi[0] = false;
                MODE = 0;
              }
            }
          }
        }
      }
    }
    if (navi[1]) {
      if (megaman.Colonel1.currentFrame < 9) {
        megaman.Colonel1.displayChips(Grid[1][1].getLocationX()-22, Grid[1][1].getLocationY()+8);
        if (megaman.Colonel1.currentFrame == 8) {
          if (megaman.Colonel2.currentFrame < 7) {
            megaman.Colonel2.displayChips(Grid[1][1].getLocationX()-30, Grid[1][1].getLocationY());
            if (megaman.Colonel2.currentFrame > 0 && megaman.Colonel2.currentFrame < 6) {
              megaman.Colonel3.displayF(170, 210, megaman.Colonel2.currentFrame - 1);
            }
          }
          if (megaman.Colonel2.currentFrame == 6) {
            Grid[0][3].setDangerVirus(true);
            Grid[0][3].setDamage(300);
            Grid[0][4].setDangerVirus(true);
            Grid[0][4].setDamage(300);
            Grid[0][5].setDangerVirus(true);
            Grid[0][5].setDamage(300);
            Grid[1][4].setDangerVirus(true);
            Grid[1][4].setDamage(300);
            Grid[2][3].setDangerVirus(true);
            Grid[2][3].setDamage(300);
            Grid[2][4].setDangerVirus(true);
            Grid[2][4].setDamage(300);
            Grid[2][5].setDangerVirus(true);
            Grid[2][5].setDamage(300);
            megaman.Colonel1.currentFrame = 0;
            megaman.Colonel2.currentFrame = 0;
            megaman.Colonel2.currentFrame = 0;           
            navi[1] = false;
            MODE = 0;
          }
        }
      }
    }
    if (navi[2]) {
      if (megaman.Protoman1.currentFrame < 10) {
        megaman.Protoman1.displayChips(Grid[megaman.getRow()][megaman.getCol()].getLocationX(), Grid[megaman.getRow()][megaman.getCol()].getLocationY());
        if (megaman.Protoman1.currentFrame == 9) {
          if (megaman.Protoman2.currentFrame < 3) {
            try {
              megaman.Protoman2.displayChips(Grid[mettaur.getRow()][mettaur.getCol()-1].getLocationX(), Grid[mettaur.getRow()][mettaur.getCol()-1].getLocationY());
            }
            catch(NullPointerException e) {
            }
            try {
              megaman.Protoman2.displayChips(Grid[protoman.getRow()][protoman.getCol()-1].getLocationX(), Grid[protoman.getRow()][protoman.getCol()-1].getLocationY());
            }
            catch(NullPointerException e) {
            }
          }
          if (megaman.Protoman2.currentFrame == 2) {
            try {
              if (megaman.Protoman3.currentFrame < 11) {
                megaman.Protoman3.displayChips(Grid[mettaur.getRow()][mettaur.getCol()-1].getLocationX()-18, Grid[mettaur.getRow()][mettaur.getCol()-1].getLocationY()+32);
              }
            }
            catch(NullPointerException e) {
            }
            try {
              if (megaman.Protoman3.currentFrame < 11) {
                megaman.Protoman3.displayChips(Grid[protoman.getRow()][protoman.getCol()-1].getLocationX()-18, Grid[protoman.getRow()][protoman.getCol()-1].getLocationY()+32);
              }
            }
            catch(NullPointerException e) {
            }
            if (megaman.Protoman3.currentFrame == 10) {
              try {
                Grid[mettaur.getRow()][mettaur.getCol()].setDangerVirus(true);
                Grid[mettaur.getRow()][mettaur.getCol()].setDamage(290);
                try {
                  Grid[mettaur.getRow()-1][mettaur.getCol()].setDangerVirus(true);
                  Grid[mettaur.getRow()-1][mettaur.getCol()].setDamage(290);
                } 
                catch (ArrayIndexOutOfBoundsException e) {
                }
                try {
                  Grid[mettaur.getRow()+1][mettaur.getCol()].setDangerVirus(true);
                  Grid[mettaur.getRow()+1][mettaur.getCol()].setDamage(290);
                }
                catch (ArrayIndexOutOfBoundsException e) {
                }
              }
              catch(NullPointerException e) {
              }
              try {
                Grid[protoman.getRow()][protoman.getCol()].setDangerVirus(true);
                Grid[protoman.getRow()][protoman.getCol()].setDamage(290);
                try {
                  Grid[protoman.getRow()-1][protoman.getCol()].setDangerVirus(true);
                  Grid[protoman.getRow()-1][protoman.getCol()].setDamage(290);
                } 
                catch (ArrayIndexOutOfBoundsException e) {
                }
                try {
                  Grid[protoman.getRow()+1][protoman.getCol()].setDangerVirus(true);
                  Grid[protoman.getRow()+1][protoman.getCol()].setDamage(290);
                }
                catch (ArrayIndexOutOfBoundsException e) {
                }
              }
              catch(NullPointerException e) {
              }
              if  (megaman.Protoman4.currentFrame < 3) {
                try {
                  megaman.Protoman4.displayChips(Grid[mettaur.getRow()][mettaur.getCol()-1].getLocationX(), Grid[mettaur.getRow()][mettaur.getCol()-1].getLocationY());
                }
                catch(NullPointerException e) {
                }
                try {
                  megaman.Protoman4.displayChips(Grid[protoman.getRow()][protoman.getCol()-1].getLocationX(), Grid[protoman.getRow()][protoman.getCol()-1].getLocationY());
                }
                catch(NullPointerException e) {
                }
              }
              if (megaman.Protoman4.currentFrame == 2) {
                megaman.Protoman1.currentFrame = 0;
                megaman.Protoman2.currentFrame = 0;
                megaman.Protoman3.currentFrame = 0;
                megaman.Protoman4.currentFrame = 0;
                navi[2] = false;
                MODE = 0;
              }
            }
          }
        }
      }
    }
    if (navi[3]) {
      if (megaman.dblHero.currentFrame < 33) {
        megaman.dblHero.displayChips(Grid[1][1].getLocationX()-50, Grid[1][1].getLocationY()+45);
      }
      if (megaman.dblHero.currentFrame == 32) {
        megaman.dblHero.currentFrame = 0;
        for (int i=0; i<3; i++) {
          for (int j=3; j<6; j++) {
            Grid[i][j].setDangerVirus(true);
            Grid[i][j].setDamage(600);
          }
        }
        navi[3] = false;
        MODE = 0;
      }
    }
    if (navi[4]) {
      if (megaman.TwinLeader.currentFrame < 32) {
        megaman.TwinLeader.displayChips(Grid[1][1].getLocationX()-50, Grid[1][1].getLocationY()+45);
      }
      if (megaman.TwinLeader.currentFrame == 31) {
        megaman.TwinLeader.currentFrame = 0;
        for (int i=0; i<3; i++) {
          for (int j=3; j<6; j++) {
            Grid[i][j].setDangerVirus(true);
            Grid[i][j].setDamage(800);
          }
        }
        navi[4] = false;
        MODE = 0;
      }
    }
  }
}

void checkMode() {
  if (modeChanged && MODE == 1) {
    changeMenu();
  }
  if (modeChanged && MODE == 0) {
    //changeBattle();
  }
  if (modeChanged && MODE == 2) {
    pause();
  }
  if (modeChanged && MODE == 4) {
    displayMenu = false;
    Chips.selected.checkPA();
    if (Chips.selected.PAExists) {
      MODE = 5;
      Chips.throwOutChips();
    } else {
      MODE = 0;
      modeChanged = false;
      customBar.customBarCount = 0;
      Chips.throwOutChips();
      if (start.currentFrame < 6) {
        start.displayChips(100, 100);
      } else {
        start.currentFrame = 0;
      }
    }
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

void pause() {
  //imageMode(CENTER);
  image(pause, 150, 120);
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
    if (mettaurMove) {
      if (mettaur.Attack.currentFrame < FrameCount[7] - 1) {
        mettaur.display(Grid[mettaur.getRow()][mettaur.getCol()].getLocationX(), Grid[mettaur.getRow()][mettaur.getCol()].getLocationY(), 1, 0);
        if (mettaur.Attack.currentFrame == FrameCount[7] - 6) {
          mettaur.attack(virusForce);
        }
      } else if (mettaur.Attack.currentFrame == FrameCount[7] - 1) {
        mettaurMove = false;
        mettaur.Attack.currentFrame = 0;
        mettaurTimer = 0;
        mettaur.display(Grid[mettaur.getRow()][mettaur.getCol()].getLocationX(), Grid[mettaur.getRow()][mettaur.getCol()].getLocationY(), 0, 0);
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
          mettaur.display(Grid[mettaur.getRow()][mettaur.getCol()].getLocationX(), Grid[mettaur.getRow()][mettaur.getCol()].getLocationY(), 1, 0);
        }
      } else {
        mettaur.display(Grid[mettaur.getRow()][mettaur.getCol()].getLocationX(), Grid[mettaur.getRow()][mettaur.getCol()].getLocationY(), 0, 0);
      }
    }
  }
  if (MODE > 0) {
    if (mettaurMove) {
      mettaur.display(Grid[mettaur.getRow()][mettaur.getCol()].getLocationX(), Grid[mettaur.getRow()][mettaur.getCol()].getLocationY(), 1, 1);
    } else {
      mettaur.display(Grid[mettaur.getRow()][mettaur.getCol()].getLocationX(), Grid[mettaur.getRow()][mettaur.getCol()].getLocationY(), 0, 1);
    }
  }
}

void showPanelDanger() {
  int counter = 0;
  while (counter < Grid.length) {
    int counter2 = 0;
    while (counter2 < Grid[0].length) {
      Grid[counter][counter2].panelColor();
      counter2 += 1;
    }
    counter += 1;
  }
}


void showHP(int translation) {
  //Megaman's HP
  fill(56, 80, 104);
  stroke(255);
  rect(4 + translation, 4, 63, 20);
  if (megaman.getHP()%10!=1) {
    image(numberText[megaman.getHP()%10], 55 + translation, 6);
  } else {
    image(numberText[megaman.getHP()%10], 60 + translation, 6);
  }
  if (megaman.getHP()%100/10 != 1) {
    image(numberText[megaman.getHP()%100/10], 43 + translation, 6);
  } else {
    image(numberText[megaman.getHP()%100/10], 48 + translation, 6);
  }
  if (megaman.getHP()%1000/100 != 1) {
    image(numberText[megaman.getHP()%1000/100], 31 + translation, 6);
  } else {
    image(numberText[megaman.getHP()%1000/100], 36 + translation, 6);
  }
  megaman.showStatus(translation);
  //Enemy
  if (isTutorial && mettaur.getHP() > 0) {
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
  if (!isTutorial && protoman.getHP() > 0) {
    if (protoman.getHP()%10!=1) {
      image(numberText[protoman.getHP()%10], Grid[protoman.getRow()][protoman.getCol()].getLocationX()+37, Grid[protoman.getRow()][protoman.getCol()].getLocationY()+7);
    } else {
      image(numberText[protoman.getHP()%10], Grid[protoman.getRow()][protoman.getCol()].getLocationX()+42, Grid[protoman.getRow()][protoman.getCol()].getLocationY()+7);
    }
    if (protoman.getHP()%100/10 != 1) {
      image(numberText[protoman.getHP()%100/10], Grid[protoman.getRow()][protoman.getCol()].getLocationX()+27, Grid[protoman.getRow()][protoman.getCol()].getLocationY()+7);
    } else {
      image(numberText[protoman.getHP()%100/10], Grid[protoman.getRow()][protoman.getCol()].getLocationX()+32, Grid[protoman.getRow()][protoman.getCol()].getLocationY()+7);
    }
    if (protoman.getHP()%1000/10 != 1) {
      image(numberText[protoman.getHP()%1000/100], Grid[protoman.getRow()][protoman.getCol()].getLocationX()+17, Grid[protoman.getRow()][protoman.getCol()].getLocationY()+7);
    } else {
      image(numberText[protoman.getHP()%1000/100], Grid[protoman.getRow()][protoman.getCol()].getLocationX()+22, Grid[protoman.getRow()][protoman.getCol()].getLocationY()+7);
    }
    if (protoman.getHP()%10000/10 != 1) {
      image(numberText[protoman.getHP()%10000/1000], Grid[protoman.getRow()][protoman.getCol()].getLocationX()+7, Grid[protoman.getRow()][protoman.getCol()].getLocationY()+7);
    } else {
      image(numberText[protoman.getHP()%10000/1000], Grid[protoman.getRow()][protoman.getCol()].getLocationX()+12, Grid[protoman.getRow()][protoman.getCol()].getLocationY()+7);
    }
  }
}

void reset() {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 6; j++) {
      Grid[i][j].setDangerVirus(false);
      Grid[i][j].setDamage(0);
    }
  }
}

