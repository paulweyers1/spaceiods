// rectangle used to manage object collisions - base class for moving objects 
class Rectangle {
  float  cx, cy, x, y, w, h, vx, vy; // x,y positions, (w)width & (h)height of the rectangle or ball and sx,sy speed of the ball sx,sy = 0 if not moving
  Color colour = new Color(200,200,200);             // for the asteroid when it gets hit
  int hits = 0;                                      // number os hits for the asteroid
  
  // constructor  
  Rectangle (float x, float y, float w, float h, float vx, float vy){
    this.x = x;  // left x position of rectangle 
    this.y = y;  // top  y position of rectangle
    this.cx = x; // left collision detection x position of rectangle 
    this.cy = y; // top  collision detection y position of rectangle
    this.w = w;  // width of rectangle
    this.h = h;  // height of rectangle
    this.vx = vx; // speed (number of pixels) to increase x by and move left or right
    this.vy = vy; // speed (number of pixels) to increase y by and move up or down
  }

  /** check if rect has hit rectangle (bullet, asteroid or space ship) */  
  boolean collides(Rectangle rt){
    // CHECK1: check for collision top and bottom
    if (cx + w > rt.cx && 
        cx < rt.cx + rt.w && 
        cy + h + vy > rt.cy && 
        cy - h + vy < rt.cy + rt.h) {hit(); return true;}
    
    // CHECK2: check for collision left or right    
    if (cx + w + vx > rt.cx && 
        cx - w + vx < rt.cx + rt.w && 
        cy + h > rt.y && 
        cy < rt.cy + rt.h) {hit(); return true;}      
    return false;
  }
  
  void draw(float cx, float cy){
    this.cx = cx;
    this.cy = cy;
/** DEBUG CODE - For testing collisions if they fail */
//    collide();
  }
  
  /** adds a rect around each object to help debug collisions */
  void collide(){
    stroke(255,0,0);
    noFill();
    rect(cx,cy,w,h);
  }
  
  /** if you hit an asteroid this method changes the hit level asteroid needs 3 bullets each to be destoyed */
  void hit(){    
    hits++;
    if (hits >= 0) colour = new Color(220, 220, 220);  // light grey 3 hits left
    if (hits >= 1) colour = new Color(130, 130, 130);  // darker grey 2 hits left
    if (hits >= 2) colour = new Color(60, 60, 60);     // darkest grey 1 hit left
  }
}
