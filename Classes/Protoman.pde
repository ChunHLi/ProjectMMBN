import java.util.*; 

class Protoman {
  int HP, panelRow, panelCol, currentAnimation, state, invincTimer, numMove, numAttack, actionDelay;
  boolean currentlyMoving,guardUp,invinc,moved;
  Random r;

  Animation hurt = new Animation("../Sprites/bosses/Protoman/01", 4, 1);
  Animation leavePanel = new Animation("../Sprites/bosses/Protoman/02", 2);
  Animation arrivePanel = new Animation("../Sprites/bosses/Protoman/03", 2);
  Animation attack = new Animation("../Sprites/bosses/Protoman/04", 10);
  Animation wideSword = new Animation("../Sprites/bosses/Protoman/05", 4);
  Animation longSword = new Animation("../Sprites/bosses/Protoman/06", 4);
  Animation shieldUp = new Animation("../Sprites/bosses/Protoman/07", 7);
  Animation shieldDown = new Animation("../Sprites/bosses/Protoman/07", 7);
  PImage stand = loadImage("../Sprites/bosses/Protoman/000.png");

  Protoman() {
    this(2800, 1, 4);
  }

  Protoman(int hp, int PanelRow, int PanelCol) {
    HP = hp;
    panelRow = PanelRow;
    panelCol = PanelCol;
    numMove = 3;
    r = new Random();
    stand.resize((int)(stand.width * 1.5), (int)(stand.height * 1.5));
    actionDelay = 8;
  }

  void move(Panel[][] Grid) {
    if (actionDelay == 0) {
      currentlyMoving = true;
      if (leavePanel.currentFrame < leavePanel.spriteCount - 1 && !moved) {
        leavePanel.display(Grid[panelRow][panelCol].getLocationX() - 4, Grid[panelRow][panelCol].getLocationY(),0);
      } else if (leavePanel.currentFrame == leavePanel.spriteCount - 1 && !moved) {
        leavePanel.display(Grid[panelRow][panelCol].getLocationX() - 4, Grid[panelRow][panelRow].getLocationY(),0);
        randomizeLocation();
        moved = true;
      } else if (arrivePanel.currentFrame < arrivePanel.spriteCount - 1 && moved) {
        arrivePanel.display(Grid[panelRow][panelCol].getLocationX() - 13, Grid[panelRow][panelCol].getLocationY(),0);
      } else if (arrivePanel.currentFrame == arrivePanel.spriteCount - 1 && moved) {
        arrivePanel.display(Grid[panelRow][panelCol].getLocationX() - 13, Grid[panelRow][panelCol].getLocationY(),0);
        currentlyMoving = false;
        moved = false;
        actionDelay = 8;
      }
    }
  }

  void stand(Panel[][] Grid) {
    if (!currentlyMoving) {
      image(stand, Grid[panelRow][panelCol].getLocationX() - 20, Grid[panelRow][panelCol].getLocationY() - stand.height + 5);
      actionDelay -= 1;
    }
  }

  void sequence(Panel[][] Grid, int mode) {
    if (mode == 0){
      if (actionDelay == 0){
        move(Grid);
      } else {
      stand(Grid);
      }
    }
    else{
      image(stand, Grid[panelRow][panelCol].getLocationX() - 20, Grid[panelRow][panelCol].getLocationY() - stand.height + 5);
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

