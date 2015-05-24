class Animation {
  PImage[] spriteFrames;
  int spriteCount;
  int currentFrame;

  Animation(String spriteFolderDirectory, int count) {
    spriteCount = count;
    spriteFrames = new PImage[spriteCount];
    for (int i = 0; i < spriteCount; i++) {
      String spriteDirectory = spriteFolderDirectory + i + ".png";
      spriteFrames[i] = loadImage(spriteDirectory);
      spriteFrames[i].resize((int)(spriteFrames[i].width*1.5), (int)(spriteFrames[i].height*1.5));
    }
  }

  void display(float xpos, float ypos) {
    if (currentFrame < spriteCount - 1) {
      currentFrame += 1;
    } else {
      currentFrame = 0;
    }
    image(spriteFrames[currentFrame], xpos, ypos - spriteFrames[currentFrame].height + 5);
  }
}

