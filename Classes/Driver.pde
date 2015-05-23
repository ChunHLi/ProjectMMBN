import java.util.*;
Megaman megaman;
PImage backGround;
float xpos;
float ypos;
boolean[] Keys = {false,false,false,false}; 
Panel[][] Grid = {{new Panel(64,119.5),new Panel(124,119.5),new Panel(184,119.5),new Panel(244,119.5),new Panel(304,119.5),new Panel(364,119.5)},
             {new Panel(64,158.5),new Panel(124,158.5),new Panel(184,158.5),new Panel(244,158.5),new Panel(304,158.5),new Panel(364,158.5)},
             {new Panel(64,197.5),new Panel(124,197.5),new Panel(184,197.5),new Panel(244,197.5),new Panel(304,197.5),new Panel(364,197.5)}};
int[] FrameCount = {1,8,4,4};
boolean moved;

void setup(){
  size(480,320);
  background(0);
  frameRate(30);
  backGround = loadImage("../Sprites/platform/backGround.png");
  backGround.resize((int)(backGround.width*1.5),(int)(backGround.height*1.5));
  image(backGround,width/2 , height/2); 
  //parameter1 gives the directory, parameter2 is the amount of frames
  //look in the directory and replace "07" with the first two numbers
  //of the sequence of frames you want to see. Replace the second parameter
  //with the amount of frames in the sequence.
  megaman = new Megaman();
}

void draw(){
  background(0);
  image(backGround,width/2 - backGround.width/2, height/2 - backGround.height/2); 
  move();
}

void mousePressed(){
  print(mouseX + " " + mouseY + "\n");
}


void keyPressed(){
  if (keyCode == 37){
    if (!currentlyMoving() && megaman.getCol() > 0){
      Keys[0] = true;
    }
  }
  if (keyCode == 39){
    if (!currentlyMoving() && megaman.getCol() < 2){
      Keys[1] = true;
    }
  }
  if (keyCode == 38){
    if (!currentlyMoving() && megaman.getRow() > 0){
      Keys[2] = true;
    }
  }
  if (keyCode == 40){
    if (!currentlyMoving() && megaman.getRow() < 2){
      Keys[3] = true;
    }
  }
}

boolean currentlyMoving(){
  for (int i = 0; i < Keys.length; i++){
    if (Keys[i]){
      return true;
    }
  }
  return false;
}

void move(){
   if (Keys[0]){
     if (megaman.LeavePanel.currentFrame < FrameCount[3] - 1){  
       megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(),Grid[megaman.getRow()][megaman.getCol()].getLocationY(),3);
     }
     else if (megaman.LeavePanel.currentFrame == FrameCount[3] - 1){
       if (!moved){
          megaman.setCol(megaman.getCol() - 1);
          moved = true;
       }
       if (megaman.ArrivePanel.currentFrame < FrameCount[2] - 1){  
         megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(),Grid[megaman.getRow()][megaman.getCol()].getLocationY(),2);
       }
       else if (megaman.ArrivePanel.currentFrame == FrameCount[2] - 1){
         megaman.LeavePanel.currentFrame = 0;
         megaman.ArrivePanel.currentFrame = 0;
         Keys[0] = false;
         moved = false;
       }
     }
   }
   if (Keys[1]){
     if (megaman.LeavePanel.currentFrame < FrameCount[3] - 1){  
       megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(),Grid[megaman.getRow()][megaman.getCol()].getLocationY(),3);
     }
     else if (megaman.LeavePanel.currentFrame == FrameCount[3] - 1){
       if (!moved){
         megaman.setCol(megaman.getCol() + 1);
         moved = true;
       }
       if (megaman.ArrivePanel.currentFrame < FrameCount[2] - 1){  
         megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(),Grid[megaman.getRow()][megaman.getCol()].getLocationY(),2);
       }
       else if (megaman.ArrivePanel.currentFrame == FrameCount[2] - 1){
         megaman.LeavePanel.currentFrame = 0;
         megaman.ArrivePanel.currentFrame = 0;
         Keys[1] = false;
         moved = false;
       }
     }
   }
   if (Keys[2]){
     if (megaman.LeavePanel.currentFrame < FrameCount[3] - 1){  
       megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(),Grid[megaman.getRow()][megaman.getCol()].getLocationY(),3);
     }
     else if (megaman.LeavePanel.currentFrame == FrameCount[3] - 1){
       if (!moved){
         megaman.setRow(megaman.getRow() - 1);
         moved = true;
       }
       if (megaman.ArrivePanel.currentFrame < FrameCount[2] - 1){  
         megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(),Grid[megaman.getRow()][megaman.getCol()].getLocationY(),2);
       }
       else if (megaman.ArrivePanel.currentFrame == FrameCount[2] - 1){
         megaman.LeavePanel.currentFrame = 0;
         megaman.ArrivePanel.currentFrame = 0;
         Keys[2] = false;
         moved = false;
       }
     }
    }  
   if (Keys[3]){
     if (megaman.LeavePanel.currentFrame < FrameCount[3] - 1){  
       megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(),Grid[megaman.getRow()][megaman.getCol()].getLocationY(),3);
     }
     else if (megaman.LeavePanel.currentFrame == FrameCount[3] - 1){
       if (!moved){
         megaman.setRow(megaman.getRow() + 1);
         moved = true;
       }
       if (megaman.ArrivePanel.currentFrame < FrameCount[2] - 1){  
         megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(),Grid[megaman.getRow()][megaman.getCol()].getLocationY(),2);
       }
       else if (megaman.ArrivePanel.currentFrame == FrameCount[2] - 1){
         megaman.LeavePanel.currentFrame = 0;
         megaman.ArrivePanel.currentFrame = 0;
         Keys[3] = false;
         moved = false;
       }
     }
   }
   else if (!currentlyMoving()){
     megaman.display(Grid[megaman.getRow()][megaman.getCol()].getLocationX(),Grid[megaman.getRow()][megaman.getCol()].getLocationY(),0);
   }
}


