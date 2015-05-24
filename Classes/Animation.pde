class Animation {
  PImage[] spriteFrames;
  int spriteCount;
  int currentFrame;
  int animationDelay;
  int counter;

  Animation(String spriteFolderDirectory, int count) {
    animationDelay = 0;
    spriteCount = count;
    spriteFrames = new PImage[spriteCount];
    for (int i = 0; i < spriteCount; i++) {
      String spriteDirectory = spriteFolderDirectory + i + ".png";
      spriteFrames[i] = loadImage(spriteDirectory);
      spriteFrames[i].resize((int)(spriteFrames[i].width*1.5), (int)(spriteFrames[i].height*1.5));
    }
  }
  Animation(String spriteFolderDirectory, int count, int delay) {
    animationDelay = delay;
    spriteCount = count;
    spriteFrames = new PImage[spriteCount];
    for (int i = 0; i < spriteCount; i++) {
      String spriteDirectory = spriteFolderDirectory + i + ".png";
      spriteFrames[i] = loadImage(spriteDirectory);
      spriteFrames[i].resize((int)(spriteFrames[i].width*1.5), (int)(spriteFrames[i].height*1.5));
    }
  }
  
  void display(float xpos, float ypos) {
    if (animationDelay == counter){
      if (currentFrame < spriteCount - 1) {
        currentFrame += 1;
      } else {
        currentFrame = 0;
      }
      image(spriteFrames[currentFrame], xpos, ypos - spriteFrames[currentFrame].height + 5);
    }else{
     counter ++; 
    }
  }
  
  void display(float xpos, float ypos, int frame){
   image(spriteFrames[frame], xpos, ypos - spriteFrames[frame].height + 5);
  }
  
  void display(int delay, float xpos, float ypos) {
    wait(delay);
    if (currentFrame < spriteCount - 1) {
      currentFrame += 1;
    } else {
      currentFrame = 0;
    }
    image(spriteFrames[currentFrame], xpos, ypos - spriteFrames[currentFrame].height + 5);
  }
  
  void wait(int millis){
    try {
      Thread.sleep(millis);
    } catch (InterruptedException e) {
    }
  }
}

