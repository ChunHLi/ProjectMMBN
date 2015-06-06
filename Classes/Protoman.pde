import java.util.*; 

class Protoman {
  int HP, panelRow, panelCol, currentAnimation, state, invincTimer, numMove, attackType, actionDelay, shieldDelay, attackStartDelay, attackEndDelay, moveCap;
  boolean currentlyMoving, raiseGuard, lowerGuard, invinc, moved, megamanLocated, inhurtAnimation;

  Random r;

  Animation hurt = new Animation("../Sprites/bosses/Protoman/01", 4, 4);
  Animation leavePanel = new Animation("../Sprites/bosses/Protoman/02", 2);
  Animation arrivePanel = new Animation("../Sprites/bosses/Protoman/03", 2);
  Animation widesword = new Animation("../Sprites/bosses/Protoman/04", 11);
  Animation longsword = new Animation("../Sprites/bosses/Protoman/05", 11);
  Animation Bwidesword = new Animation("../Sprites/bosses/Protoman/09", 11);
  Animation cross = new Animation("../Sprites/bosses/Protoman/10", 11);
  Animation shieldUp = new Animation("../Sprites/bosses/Protoman/07", 7);
  Animation shieldDown = new Animation("../Sprites/bosses/Protoman/08", 7);
  PImage stand = loadImage("../Sprites/bosses/Protoman/000.png");

  Protoman() {
    this(2800, 1, 4);
  }

  Protoman(int hp, int PanelRow, int PanelCol) {
    HP = hp;
    panelRow = PanelRow;
    panelCol = PanelCol;
    moveCap = 5;
    r = new Random();
    stand.resize((int)(stand.width * 1.5), (int)(stand.height * 1.5));
    actionDelay = 8;
    shieldDelay = 12;
    attackStartDelay = 12;
    attackEndDelay = 18;
    numMove = r.nextInt(moveCap - 2) + 2;
  }

  void move(Panel[][] Grid, Megaman megaman) {
      if (numMove > 0) {
        if (actionDelay == 0 ) {
          currentlyMoving = true;
          if (leavePanel.currentFrame < leavePanel.spriteCount - 1 && !moved) {
            leavePanel.display(Grid[panelRow][panelCol].getLocationX() - leavePanel.spriteFrames[leavePanel.currentFrame].width + 52, Grid[panelRow][panelCol].getLocationY(), invincTimer);
          } else if (leavePanel.currentFrame == leavePanel.spriteCount - 1 && !moved) {
            leavePanel.display(Grid[panelRow][panelCol].getLocationX() - leavePanel.spriteFrames[leavePanel.currentFrame].width + 52, Grid[panelRow][panelRow].getLocationY(), invincTimer);
            randomizeLocation();
            moved = true;
          } else if (arrivePanel.currentFrame < arrivePanel.spriteCount - 1 && moved) {
            arrivePanel.display(Grid[panelRow][panelCol].getLocationX() - arrivePanel.spriteFrames[arrivePanel.currentFrame].width + 52, Grid[panelRow][panelCol].getLocationY(), invincTimer);
          } else if (arrivePanel.currentFrame == arrivePanel.spriteCount - 1 && moved) {
            arrivePanel.display(Grid[panelRow][panelCol].getLocationX() - arrivePanel.spriteFrames[arrivePanel.currentFrame].width + 52, Grid[panelRow][panelCol].getLocationY(), invincTimer);
            moved = false;
            if (r.nextInt(3) == 0) {
              raiseGuard = true;
              actionDelay = 28;
            } else {
              actionDelay = 8;
            }
            currentlyMoving = false;
            numMove -= 1;
          }
        }
      } else {
        if (!megamanLocated) {
          attackType = r.nextInt(3);
          if (attackType == 0) {
            panelRow = megaman.getRow();
            panelCol = megaman.getCol() + 1;
          }
          if (attackType == 1) {
            panelRow = megaman.getRow();
            panelCol = 3;
          }
          if (attackType == 2) {
            panelRow = 1;
            panelCol = 3;
          }
          megamanLocated = true;
        }
        if (attackType == 0){
          attack(widesword,attackType, megaman, Grid);
        }
        if (attackType == 1){
          attack(longsword,attackType, megaman, Grid);
        }
        if (attackType == 2){
          attack(attack1,attackType, megaman, Grid);
        }
        currentlyMoving = true;
      }
    }

  void stand(Panel[][] Grid) {
    if (!currentlyMoving) {
      image(stand, Grid[panelRow][panelCol].getLocationX() - 20, Grid[panelRow][panelCol].getLocationY() - stand.height + 5);
      actionDelay -= 1;
    }
  }

  void guard(Panel[][]Grid) {
    if (raiseGuard) {
      if (shieldUp.currentFrame < shieldUp.spriteCount - 1) {
        shieldUp.display(Grid[panelRow][panelCol].getLocationX() - 24, Grid[panelRow][panelCol].getLocationY(), invincTimer);
      } else if (shieldUp.currentFrame == shieldUp.spriteCount - 1) {
        if (shieldDelay > 0) {
          image(shieldUp.spriteFrames[shieldUp.currentFrame], Grid[panelRow][panelCol].getLocationX() - 24, Grid[panelRow][panelCol].getLocationY() - stand.height + 15);
          shieldDelay -= 1;
        } else {
          shieldUp.display(Grid[panelRow][panelCol].getLocationX() - 24, Grid[panelRow][panelRow].getLocationY(), invincTimer);
          raiseGuard = false;
          lowerGuard = true;
          shieldDelay = 12;
        }
      }
    } else if (lowerGuard) {
      if (shieldDown.currentFrame < shieldDown.spriteCount - 1) {
        shieldDown.display(Grid[panelRow][panelCol].getLocationX() - 24, Grid[panelRow][panelCol].getLocationY(), invincTimer);
      } else if (shieldDown.currentFrame == shieldDown.spriteCount - 1) {
        shieldDown.display(Grid[panelRow][panelCol].getLocationX() - 24, Grid[panelRow][panelRow].getLocationY(), invincTimer);
        lowerGuard = false;
        currentlyMoving = false;
      }
    }
  }

  void sequence(Panel[][] Grid, int mode, Megaman megaman) {
    if (mode == 0 && !inhurtAnimation) {
      if (actionDelay == 0) {
        move(Grid, megaman);
      } else {
        stand(Grid);
        guard(Grid);
      }
    } else if (!inhurtAnimation){
      image(stand, Grid[panelRow][panelCol].getLocationX() - 20, Grid[panelRow][panelCol].getLocationY() - stand.height + 5);
    }
  }

  void attack(Animation attack,int type, Megaman megaman, Panel[][] Grid) {
    if (currentlyMoving) {
      if (type == 0 || type == 1 || type == 2) {
        if (attack.currentFrame < attack.spriteCount - 1) {
          if (attackStartDelay > 0) {
            warnDanger(Grid, attackStartDelay, type);
            if (type == 0){
              image(attack.spriteFrames[attack.currentFrame], Grid[panelRow][panelCol].getLocationX() - 55, Grid[panelRow][panelCol].getLocationY() - 100);
            }
            if (type == 1){
              image(attack.spriteFrames[attack.currentFrame], Grid[panelRow][panelCol].getLocationX() - 140, Grid[panelRow][panelCol].getLocationY() - 94);
            }
            if (type == 2){
              image(attack.spriteFrames[attack.currentFrame], Grid[panelRow][panelCol].getLocationX() - 55, Grid[panelRow][panelCol].getLocationY() - 100);
            }
            attackStartDelay -= 1;
          } else {
            if (attack.currentFrame == 0) {
              becomeDanger(Grid, type, true);
            }
            if (type == 0){
              attack.display(Grid[panelRow][panelCol].getLocationX() - 55, Grid[panelRow][panelCol].getLocationY() + 30, invincTimer);
            }
            if (type == 1){
              attack.display(Grid[panelRow][panelCol].getLocationX() - 140, Grid[panelRow][panelCol].getLocationY(), invincTimer);
            }
            if (type == 2){
              attack.display(Grid[panelRow][panelCol].getLocationX() - 55, Grid[panelRow][panelCol].getLocationY() + 30, invincTimer);
            }
          }
        } else if (attack.currentFrame == attack.spriteCount - 1) {
          if (attackEndDelay == 18) {
            becomeDanger(Grid, type, false);
          }
          if (attackEndDelay > 0) {
            if (type == 0){
              image(attack.spriteFrames[attack.currentFrame], Grid[panelRow][panelCol].getLocationX() - 55, Grid[panelRow][panelCol].getLocationY() - 100);
            }
            if (type == 1){
              image(attack.spriteFrames[attack.currentFrame], Grid[panelRow][panelCol].getLocationX() - 140, Grid[panelRow][panelCol].getLocationY() - 94);
            }
            if (type == 2){
              image(attack.spriteFrames[attack.currentFrame], Grid[panelRow][panelCol].getLocationX() - 55, Grid[panelRow][panelCol].getLocationY() - 100);
            }
            attackEndDelay -= 1;
          } else {
            if (type == 0){
              attack.display(Grid[panelRow][panelCol].getLocationX() - 55, Grid[panelRow][panelCol].getLocationY() + 30, invincTimer);
            }
            if (type == 1){
              attack.display(Grid[panelRow][panelCol].getLocationX() - 140, Grid[panelRow][panelCol].getLocationY(), invincTimer);
            }
            if (type == 2){
              attack.display(Grid[panelRow][panelCol].getLocationX() - 55, Grid[panelRow][panelCol].getLocationY() + 30, invincTimer);
            }
            currentlyMoving = false;
            attackStartDelay = 12;
            attackEndDelay = 18;
            numMove = r.nextInt(moveCap - 2) + 2;
            megamanLocated = false;
          }
        }
      }
    }
  }

  void warnDanger(Panel[][] Grid, int frame, int attackType) {
    if (frame % 3 != 0) {
      noStroke();
      fill(248, 248, 64);
      if (attackType == 0) {
        if (panelRow == 1) {
          rect(Grid[panelRow - 1][panelCol - 1].getLocationX() - 5, Grid[panelRow - 1][panelCol].getLocationY() - 25, 60, 38);
          rect(Grid[panelRow][panelCol - 1].getLocationX() - 5, Grid[panelRow][panelCol].getLocationY() - 25, 60, 38);
          rect(Grid[panelRow + 1][panelCol - 1].getLocationX() - 5, Grid[panelRow + 1][panelCol].getLocationY() - 25, 60, 38);
        }
        if (panelRow == 0) {
          rect(Grid[panelRow][panelCol - 1].getLocationX() - 5, Grid[panelRow][panelCol].getLocationY() - 25, 60, 38);
          rect(Grid[panelRow + 1][panelCol - 1].getLocationX() - 5, Grid[panelRow + 1][panelCol].getLocationY() - 25, 60, 38);
        }
        if (panelRow == 2) {
          rect(Grid[panelRow - 1][panelCol - 1].getLocationX() - 5, Grid[panelRow - 1][panelCol].getLocationY() - 25, 60, 38);
          rect(Grid[panelRow][panelCol - 1].getLocationX() - 5, Grid[panelRow][panelCol].getLocationY() - 25, 60, 38);
        }
      }
      if (attackType == 1) {
        rect(Grid[panelRow][0].getLocationX() - 5, Grid[panelRow][0].getLocationY() - 25, 60, 38);
        rect(Grid[panelRow][1].getLocationX() - 5, Grid[panelRow][1].getLocationY() - 25, 60, 38);
        rect(Grid[panelRow][2].getLocationX() - 5, Grid[panelRow][2].getLocationY() - 25, 60, 38);
      }
      if (attackType == 2) {
        rect(Grid[0][1].getLocationX() - 5, Grid[0][1].getLocationY() - 25, 60, 38);
        rect(Grid[1][0].getLocationX() - 5, Grid[1][0].getLocationY() - 25, 60, 38);
        rect(Grid[1][1].getLocationX() - 5, Grid[1][1].getLocationY() - 25, 60, 38);
        rect(Grid[1][2].getLocationX() - 5, Grid[1][2].getLocationY() - 25, 60, 38);
        rect(Grid[2][1].getLocationX() - 5, Grid[2][1].getLocationY() - 25, 60, 38);
      }
    }
  }


  void becomeDanger(Panel[][] Grid, int attackType, boolean become) {
    if (attackType == 0) {
      if (panelRow == 1) {
        Grid[panelRow - 1][panelCol - 1].setDangerMM(become);
        Grid[panelRow][panelCol - 1].setDangerMM(become);
        Grid[panelRow + 1][panelCol - 1].setDangerMM(become);
      }
      if (panelRow == 0) {
        Grid[panelRow][panelCol - 1].setDangerMM(become);
        Grid[panelRow + 1][panelCol - 1].setDangerMM(become);
      }
      if (panelRow == 2) {
        Grid[panelRow - 1][panelCol - 1].setDangerMM(become);
        Grid[panelRow][panelCol - 1].setDangerMM(become);
      }
    }
    if (attackType == 1) {
      Grid[panelRow][0].setDangerMM(become);
      Grid[panelRow][1].setDangerMM(become);
      Grid[panelRow][2].setDangerMM(become);
    }
    if (attackType == 2) {
      Grid[0][1].setDangerMM(become);
      Grid[1][0].setDangerMM(become);
      Grid[1][1].setDangerMM(become);
      Grid[1][2].setDangerMM(become);
      Grid[2][1].setDangerMM(become);
    }
  }

  void hurt(Panel[][] Grid) {
    if (Grid[panelRow][panelCol].isDangerVirus() && invincTimer == 0) {
      inhurtAnimation = true;
      if (currentlyMoving){
        widesword.currentFrame = 0;
        longsword.currentFrame = 0;
        attack1.currentFrame = 0;
        attackStartDelay = 12;
        attackEndDelay = 18;
        actionDelay = 0;
        currentlyMoving = false;
        numMove = r.nextInt(moveCap - 2) + 2;
        int row = 0;
        int col = 0;
        while (row < Grid.length){
          while (col < Grid[0].length){
            Grid[row][col].setDangerMM(false);
            col += 1;
          }
          col = 0;
          row += 1;
        }
      }  
      HP -= Grid[panelRow][panelCol].getDamage();
      invincTimer = 44;
    } else if (invincTimer > 36) {
      hurt.display(Grid[panelRow][panelCol].getLocationX() - 20, Grid[panelRow][panelCol].getLocationY(), invincTimer);
    }
    if (hurt.currentFrame >= hurt.spriteCount - 1) {
      hurt.display(Grid[panelRow][panelCol].getLocationX() - 20, Grid[panelRow][panelCol].getLocationY(), invincTimer);
      currentlyMoving = false;
      inhurtAnimation = false;
    }
    if (invincTimer > 0) {
      invincTimer -= 1;
    }
  }


  void randomizeLocation() {
    int newPanelRow = panelRow;
    int newPanelCol = panelCol;
    while (newPanelRow == panelRow && newPanelCol == panelCol) {
      newPanelRow = r.nextInt(3);
      newPanelCol = r.nextInt(3) + 3;
    }
    panelRow = newPanelRow;
    panelCol = newPanelCol;
  }
}

