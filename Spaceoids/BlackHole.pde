// blachole where the asteriods disspear into
enum BSTATE {HIDE, SHOW};
BSTATE bstate = BSTATE.HIDE; 
final int TIME_MAX = 250; 

/** Blackhole class creates a blackhole to consume asteroids of spaceship */
class BlackHole extends Rectangle {
  int timer = 0; 
  float x_inc = random(0,2), y_inc = -random(0,5);

  /* constructor */  
  BlackHole (float x, float y) { 
    super(x, y, 120, 10, 0, 0); 
  }
  
  /** draw blackhole */
  void draw(){
    if(bstate == BSTATE.SHOW) {
      float dw = 1.2, dh = 1.05, f_inc = 10, tw = w, th = h;
      super.draw(x - w/2 + (x_inc*tw) + 20, y - h/2 + (y_inc*th)); // set collision detection coordinates (need to adjust to compensate for rotation)
      fill(Color.white.getRGB());  
      ellipseMode(CENTER); // set ellipse draw mode to start x,y in center
      for (int i = 0; i < 8; i++){
         ellipse(x + (x_inc * w) + 20, y + (y_inc * h), tw, th); 
         fill(240 - (f_inc * i)); 
         tw /= dw; 
         th /= dh;
      }
      tw = w; th = h; // have to reset values for next run
      ellipseMode(CORNER); // set ellipse draw mode to start x,y in corner
    } 
    
    if(level == 1) { // blackhole appears on level 1 to make it easier for the player
      timer++;   
      if(timer == TIME_MAX){
        timer = 0; 
        if(bstate == BSTATE.HIDE) {
          x_inc = random(0,2);
          y_inc = -random(0,5);
          //println (x_inc + " " + y_inc);
          bstate = BSTATE.SHOW;
        }
        else bstate = BSTATE.HIDE;
      }  
    }
  }
}
