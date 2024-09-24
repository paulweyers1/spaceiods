// main game class the runs a asteriods smashed with space invaders
// 2D game - really basic 
import java.awt.*;           // included for Color class
import java.util.ArrayList;  // included for vectors/lists

int level = 1, s = 1, FLICKER = 40, STARS = 1000;  // used to make stars dynamic
ArrayList<PVector> stars = new ArrayList();        // list of stars
ArrayList<Bullet> bullets = new ArrayList();       // list of bullets
ArrayList<Asteroid> asteroids = new ArrayList();   // list of asteroids
Ship ship = new Ship(230, 550, 0.2, 0.2);          // create a new spaceship
Screen screen = new Screen();                      // create a new screen 
BlackHole bhole = new BlackHole(80, 400);          // create a new spaceship
Planet planet = new Planet (150, 150);              // create a new background planet
long newtimer = 0, start = 0, timer = 0, timeMax = 20; // variables used in managing timer 
float life = 20, score = 0;                         // player score (detroy asteroids) and spaceship remaining life
boolean RUN = false, NEWLEVEL = true;               // state flags for NEWLEVEL and RUN states  

void setup() {
  size(500, 600); // set screen size
  for(int i = 0; i < STARS; i++) stars.add(new PVector(random(1,width), random(1,height)));  // create stars
  start  = System.currentTimeMillis(); // start time marker for the timer
}

void draw() {
  
  /** STATE RUN - true when game is running */
  if(RUN){ 
     timer = ((System.currentTimeMillis() - start) / 1000) % (timeMax+10); // increment timer by 1    
     drawStars();                        // draw stars
     collisions();                       // checks collisions between asteroids/spacehip/bulletsp
     planet.draw();                      // planet in the background
     for(Bullet b: bullets) b.draw();    // draw current active bullets (10 max at any time)
     for(Asteroid a: asteroids) a.draw();// draw asteroids
     ship.draw();                        // draw spaceship
     for(ArrayList<Explosion> e : explosionList) explode(e); // draw any active explosions
     bhole.draw();                       // draw blackholed that destorys asteroids
     screen.buildHeader();               // draw header (title/score/life/level/timer) for game
  }
  
  /* STATE NEW LEVEL - true when game starts or starting a newlevel (shows splash screen) */
  if(NEWLEVEL){ 
    drawStars();          // draw stars 
    if(level == 2) planet.setXY(300, 450, 200, 50, 50); // setup for red background planet
    if(level == 3) planet.setXY(300, 200, 50, 200, 50); // setup for blue background planet
    planet.draw();        // draw planet in background for splash screen
    screen.newLevel();    // draw level splash screen
    newtimer++;           // increment timer used to display splash screen for a while
    if(newtimer >= 200){  // if splashscreen timer has run out setup for game at next level
      NEWLEVEL = false;   // end level splash screen
      RUN = true;         // start running game
      newtimer = 0;       // reset new timer for next level splash screen
      bullets.clear();    // reset bullets for next level
      asteroids.clear();  // reset asteroids for next level
      explosionList.clear(); // reset explosions for next level
      buildAsteroids(false, 0);   // build array of asteroids for this level
      bstate = BSTATE.HIDE; // hide any previously active blackholes
    }
  }
}

/** Checks and responds to collisions between asteroids, spaceship and bullets */
void collisions(){
  
  /** CHECK 1: collision bullet and asteroid */
  ArrayList<Asteroid> ar = new ArrayList(); // list to remove asteroids 
  ArrayList<Asteroid> aa = new ArrayList(); // list to add replacement asteroids
  ArrayList<Bullet>   br = new ArrayList(); // list to remove bullets
  for(Bullet b: bullets) 
    for(Asteroid a: asteroids){ 
       if(a.collides(b)) { // asteroid-bullet
         if(a.destroyed()) {// if asteroid is destroyed i.e. has been hit by a bullet > 3 times  
           ar.add(a);       // remove asteroid if bullet has hit it
           aa.add(a);       // adds a replacement asteroid
           explosionList.add(new ArrayList()); // add explosion for asteroid as you remove it
           setupExplosion(a.getXc(), a.getYc(), explosionList.get(explosionList.size()-1));
         }           
         br.add(b);   // remove bullet if it has hit asteroid
         score += 5;  // increases score if a bullet has hit asteroid
      } 
  }
          
  /** CHECK 2: collision asteroid and ship */
  for(Asteroid a: asteroids){ 
    if(ship.collides(a)) {// ship-asteroid
      if(life >= 0) life -= 5; // decrease spaceship life if it shit by asteroid
      ar.add(a);               // remove asteroid if hits spaceship
      aa.add(a);               // adds a replacement asteroid
    }
    if (a.add()) aa.add(a);  // adds replacement asteroid if past bottom of the screen
    if (a.kill()) ar.add(a); // remove if asteroid is past the screen  
  }
  

  /** CHECK 3: collision asteroid and blackhole */
  if(bstate == BSTATE.SHOW) {
    for(Asteroid a: asteroids){ 
      if(bhole.collides(a)) {// ship-asteroid
        ar.add(a);       // remove asteroid if it hits blackhole
        aa.add(a);       // adds a replacement asteroid
        explosionList.add(new ArrayList()); // add explosion for asteroid as you remove it
        setupExplosion(a.getXc(), a.getYc(), explosionList.get(explosionList.size()-1));
      }
    }
  }
  
  /** NOTE: Can only delete the asteroids, bullets outside of for loop else get exception - due to use of iterator in for loop */
  for(int i = 0; i<ar.size(); i++) asteroids.remove(ar.get(i));  // remove destroyed asteroids
  for(int i = 0; i<aa.size(); i++) buildAsteroids(true, aa.get(i).getXt());
  for(int i = 0; i<br.size(); i++) bullets.remove(br.get(i)); // remove bullets that hit asteroids
}

/** create background of dynamic stars that grow/shrink and sparkle */
void drawStars(){
  background(0);    // black background
  stroke(255, 150); // white stars with some opacity
  for(int i = 0; i < STARS; i++){
    strokeWeight(0.1 * s++);      // adjust weight to create flickering effect
    point(stars.get(i).x, stars.get(i).y); // draw a single star
    if(s >= FLICKER) s = 1;       // creates flickers/sparkles in stars on background
  }
}

/** checks if the left and right keys have been pressed then moves the spaceship accordningly */
void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT)    ship.left();    // move space ship left
    if (keyCode == RIGHT)   ship.right();   // move spaceship right
    if (keyCode == UP)      newBullet("k"); // create one new bullet
  }
}

/** manages bullets when the mouse is pressed */
void mousePressed() {newBullet("m");} // create one new bullet in direction of the mouse pointer
