Animation Megaman;
Megaman megaman;
PImage backGround;
float xpos;
float ypos;
Panel[][] Grid = {{new Panel(89,197.5),new Panel(149,197.5),new Panel(209,197.5),new Panel(269,197.5),new Panel(329,197.5),new Panel(389,197.5)},
             {new Panel(89,158.5),new Panel(149,158.5),new Panel(209,158.5),new Panel(269,158.5),new Panel(329,158.5),new Panel(389,158.5)},
             {new Panel(89,119.5),new Panel(149,119.5),new Panel(209,119.5),new Panel(269,119.5),new Panel(329,119.5),new Panel(389,119.5)}};

void setup(){
  size(480,320);
  background(0);
  frameRate(12);
  backGround = loadImage("../Sprites/platform/backGround.png");
  backGround.resize((int)(backGround.width*1.5),(int)(backGround.height*1.5));
  image(backGround,width/2 , height/2); 
  //parameter1 gives the directory, parameter2 is the amount of frames
  //look in the directory and replace "07" with the first two numbers
  //of the sequence of frames you want to see. Replace the second parameter
  //with the amount of frames in the sequence.
  Megaman = new Animation("../Sprites/megaman/noCross/07",8);
  megaman = new Megaman();
  ypos = height * 0.5;
  xpos = width * 0.25;
}

void draw(){
  background(0);
  image(backGround,width/2 - backGround.width/2, height/2 - backGround.height/2); 
  Megaman.display(xpos,ypos);
}

void mousePressed(){
  print(mouseX + " " + mouseY + "\n");
}

void keyPressed(){
  print(keyCode);
}
