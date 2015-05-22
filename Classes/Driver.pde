Animation Megaman;

float xpos;
float ypos;

void setup(){
  size(320,320);
  background(255,204,0);
  frameRate(12);
  //parameter1 gives the directory, parameter2 is the amount of frames
  //look in the directory and replace "07" with the first two numbers
  //of the sequence of frames you want to see. Replace the second parameter
  //with the amount of frames in the sequence.
  Megaman = new Animation("../Sprites/megaman/noCross/07",8);
  ypos = height * 0.5;
  xpos = width * 0.5;
}

void draw(){
  background(255,204,0);
  Megaman.display(xpos,ypos);
}
