// ship class creates a spaceship and checks for asteriod collisions 
class Ship extends Rectangle {
  private float col_grey = 200, col_lt_grey = 111, col_white = 255;  // colors for the spaceship
  private int i = 0; // jitter incrementer
  private int   JITTER = 10; // used to create spaceship jitter
  private final float STEP = 5;    // one step left of right if key pressed
      
  /* constructor */  
  Ship (float x, float y, float vx, float vy) { 
//    super(x-10, y-20, 20, 20, vx, vy); // set values for the inherited/extended rectangle class
    super(x, y, 65, 35, vx, vy); 
  }
  
  /** jitters ship to simulate engine behavior */
  void jitter() {
    if(i < JITTER) {x += vx; y += vy;} 
    else {x -= vx; y -= vy;} 
    i++; 
    if(i >= 2 * JITTER) i = 0;
  }
  
  /** moves ship left or right depending on the key pressed */
  void left() {if(!checkCollideScreen()) x -= STEP;}
  void right() {if(!checkCollideScreen()) x += STEP;}
  
  /** get x and get y coordinates */
  float getX() {return x;}
  float getY() {return y;}
  
  /** check if rect has hit the top, bottom, left or right side of the window */
  boolean checkCollideScreen(){
    // check if hit left, right top and bottom edges of screen
    if(x < w/3.5) {x += 2; return true;}        // left side 
    if(x > width - w/1.5) {x -= 2; return true;}// right side
    return false;
  }
    
  /** draw ship */
  void draw(){
    super.draw(x-13,y-30); // for debugging colisions
    if(life > 0.5) normal(); // draw a normal spaceship if there is enough life
    else skeleton(); // draw a skeleton spaceship if there is not enough life
    noStroke(); // reset to nostroke
    jitter(); // makes ship jitter//
  }

  /** normal spaceship when life is good */
  void normal(){
    stroke(col_grey); // grey 
    strokeWeight(4);  // line thickness
    line(x + 10, y - 20, x, y + 5);      // leg left - line
    line(x + 20, y - 20, x + 30, y + 5); // leg right - line
    noStroke();
    fill(col_white); // top circle is white
    ellipseMode(CORNER); // set ellipse draw mode to start x,y in corner 
    ellipse(x + 4, y - 30 , 25, 25);    // top (circle) - white top
    fill(col_lt_grey); // middle ellipse is light grey 
    ellipse(x - 13, y - 23, 60, 20);   // middle (oval) - grey oval
    noFill();         // no fill for windows 
    stroke(col_grey); // grey
    strokeWeight(2);  // window border
    ellipse(x - 3, y - 16, 7, 7);  // 1st window - circle
    ellipse(x + 12, y - 16, 7, 7); // 2nd window - circle
    ellipse(x + 27, y - 16, 7, 7); // 3rd window - circle
  }

  /** skeleton spaceship when close to dead */
  void skeleton(){
    stroke(col_grey); // grey 
    noFill();         // no fill for windows 
    strokeWeight(2);  // line thickness
    line(x + 10, y - 20, x, y + 5);      // leg left - line
    line(x + 20, y - 20, x + 30, y + 5); // leg right - line
    ellipseMode(CORNER); // set ellipse draw mode to start x,y in corner 
    ellipse(x + 4, y - 30 , 25, 25);    // top (circle) - white top
    ellipse(x - 13, y - 23, 60, 20);   // middle (oval) - grey ovals 
    ellipse(x - 3, y - 16, 7, 7);  // 1st window - circle
    ellipse(x + 12, y - 16, 7, 7); // 2nd window - circle
    ellipse(x + 27, y - 16, 7, 7); // 3rd window - circle
    fill(220);  // file grey
    textSize(16); // game stats text size
    text ("RIP", x+2, y - 35); // timer stats
  }
}
