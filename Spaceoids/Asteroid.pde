// asteriods dropping from the sky that could destroy the spaceship if it collides with that
int al1_cnt = 5; // level 1 asteroid count
float aw = 104, ah = 75; // asteroid width and hieght when factor is 1.0

/** builds first set and adds new asteroids for each level of the game */
void buildAsteroids(boolean one, float cx){
  /**  To challenge the gamer asteroids will change as levels increase
   *   1. More asteroids to deal with
   *   2. Asteroids move faster (maintain same speed from level 2-3 else too fast)
   *   3. Asteroids are on average bigger
   */
  if(level == 1){         // level 1 - easy
    int s1 = 1; //speed of asteroid
    int x = 120, y = 0, x_inc = 220;// x,y coords and x_inc increments for the next asteroid
    float size = 0.8;   // asteroid size as a factor between 0 and 1
    if(one) {asteroids.add(new Asteroid(cx, 0, size, s1+1)); return;}
    for (int i = 0; i < al1_cnt; i++) { 
      asteroids.add(new Asteroid(x, y, size, (i%2 == 0) ? s1 + 1 : s1)); // create asteroid toggle speed
      x += x_inc; // create each asteroid further along the x axis
      size = random(0.4, 0.6);// pick a randow size for each asteroid bigger as level increase
//      println(x+" "+y+" "+size+" "+size+" "+((i%2 == 0)? s2 : s1));
    }
  } else if (level == 2) { // level 2 - moderate
    int s1 = 2; //speed of asteroid
    int x = 90, y = 0, x_inc = 140;// x,y coords and x_inc increments for the next asteroid
    float size = 0.8;   // asteroid size as a factor between 0 and 1 
    if(one) {asteroids.add(new Asteroid(cx, 0, size, s1+1)); return;}
    for (int i = 0; i < al1_cnt*2; i++) { 
      asteroids.add(new Asteroid(x, y, size, (i%2 == 0) ? s1 + 1 : s1)); // create asteroid toggle speed
      x += x_inc;// create each asteroid further along the x axis
      size = random(0.3, 0.8);// pick a randow size for each asteroid bigger as level increase
//      println(x+" "+y+" "+size+" "+size+" "+((i%2==0)?s2:s1));
    }
  } else if( level == 3) {  // level 3 - difficult
    int s1 = 2; //speed of asteroid
    int x = 80, y = 0, x_inc = 80; // x,y coords and x_inc increments for the next asteroid    
    float size = 0.8;   // asteroid size as a factor between 0 and 1
    if(one) {asteroids.add(new Asteroid(cx, 0, size, s1+1)); return;}
    for (int i = 0; i < al1_cnt*2.5; i++) { 
      asteroids.add(new Asteroid(x, y, size, (i%2 == 0) ? s1 + 1 : s1)); // create asteroid toggle speed
      x += x_inc;// create each asteroid further along the x axis
      size = random(0.4, 1.0); // pick a randow size for each asteroid bigger as level increase
//      println(x+" "+y+" "+size+" "+size+" "+((i%2==0)?s2:s1));
    }
  }  
}
 
/** asteroid class creates and manages a single asteroid */
class Asteroid extends Rectangle {  
  private float xf = 0.8; // factor for adjusting the size of each asteriod
  private float xa = -44; // relative x position starting to draw the asteroid
  private float ya = -37; // relative y position starting to draw the asteroid

  private float xt = 400; // screen x starting position - required fo to translate and rotate 
  private float yt = 100; // screen y starting position - required fo to translate and rotate
  private boolean replaced = false; // flag to manage that an asteroid is replaced only once when it dies or dissapears off screen
  
  /** constructor */  
  Asteroid (float x, float y, float xf, float vty) {
    super(x, y, aw*xf, ah*xf, vty, vty); // initialise inherited Rectangle variables
    this.xt = x; // set x coordinate
    this.yt = y; // set y coordinate  
    this.xf = xf; //sets size of asteroid (size is calculated as factor of 0 to 1.0)  
  } 
  
  /** take one step for y translate location (i.e. moving down */
  void stepY() {this.yt += vy; y += vy;}
    
  /** get current x,y translate (movement) locations for explosion location */
  float getXt() {return xt;}
  float getYt() {return yt;}
  float getXc() {return cx+30;}
  float getYc() {return cy+15;}
   
  /* draws a single asteriod  - get all of this into a for loop to simplify the code - repetitions are for texture */
  void draw(){ 
    super.draw((xt-(80*xf))*xf, (yt-(40*xf))*xf); // set collision detection coordinates (need to adjust to compensate for rotation)
    float dxf = xf;         // factor to decrease the shape evertime we loop to make it look textured
    Color col = colour;     // use the adjusted colour (adjusted in rectangle everytime asteroid is hit)
    int c = 0;              // value used to lighten color with every loop of texturing
    noStroke();                   // do not want a border here
    pushMatrix();                 // push current matrix so not impacted by translate/rotate below
    translate(xt*xf, yt*xf);      // required for the tumbling effect - moves the relative location of the asteroid
    rotate(radians(frameCount));  // creates the tumbling effect of the asteroid (framerate creates a smooth motion inline current motion speed of game)
    for(int i = 0; i < 7 ; i++){  // loop to create the textured look of the asteroid
      fill(col.getRed()-c);  // set adjusted color for next ellipse
      beginShape();  // draw asteroid vertices
        vertex(xa*dxf, ya*dxf); // all vetrices use relative locations to xa,ya and the size factor (xf)
        vertex(xa*dxf+(84*dxf), ya*dxf+(10*dxf));
        vertex(xa*dxf+(72*dxf), ya*dxf+(63*dxf));
        vertex(xa*dxf+(24*dxf), ya*dxf+(85*dxf));
        vertex(xa*dxf+(-20*dxf), ya*dxf+(17*dxf));
      endShape(CLOSE);
      c-=10; dxf-=0.1; // draw smaller version inside asteroid to create texture and dimension
    }
    popMatrix(); // return the previoud matrix tht is unaffected by the transformation above
    stepY(); // moves asteroid one step in the tumbling sequence
  }
  
  /* remove an asteroid if it has been hit more than 3 times */
  boolean destroyed(){return (hits>=3);}
  
  /* remove an asteroid if its past bottom of the screen */
  boolean kill(){return (this.yt+h > height + 200);}
  
  /* replace an asteroid that has passed bottom of the screen */
  boolean add(){  
    if(this.yt > height + 100) // asteroid has passed bottom of screen you can replace it 
       if(!replaced) {replaced = true; return true;} // set the reaplced flag so it only replaces the asteroid once 
    return false;
  }

}
