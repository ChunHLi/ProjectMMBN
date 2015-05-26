import ddf.minim.*;
import java.util.*;

class playList{
  ArrayList<AudioPlayer> PlayList;
  int currentSong;
  Random r;
  
  playList(){
    r = new Random();
    currentSong = -1;
    PlayList = new ArrayList<AudioPlayer>(0);
  }
  
  
  void add(String directory, Minim minim){
    AudioPlayer player = minim.loadFile(directory,512);
    player.setGain(-15);
    PlayList.add(player);
  }
  
  void add(String directory, Minim minim, int milliseconds){
    AudioPlayer player = minim.loadFile(directory,512);
    player.setGain(-15);
    player.skip(milliseconds);
    PlayList.add(player);
  }
  
  void nextSong(){
    if (PlayList.size() == 0){
    }
    else{
      PlayList.get(currentSong).pause();
      PlayList.get(currentSong).rewind();
      currentSong = r.nextInt(PlayList.size());
      PlayList.get(currentSong).play();
    }
  }
  
  void playTheList(){
    if (currentSong == -1){
      currentSong = r.nextInt(PlayList.size());
      PlayList.get(currentSong).play();
    }
  }
}
