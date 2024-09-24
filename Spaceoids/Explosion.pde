// explosions created when the spaceship or asteriods are destroyed
final float G = 0.01; // used in explosion as gravitational factor

ArrayList<Explosion> explosions = new ArrayList(); // list of sparks for a single explosion
ArrayList<ArrayList<Explosion>> explosionList = new ArrayList(); // list of all current explosions

/** setup explosion object */
void setupExplosion(float x, float y, ArrayList<Explosion> explosions){
  explosions.clear();  // clear object out of the explosions array
  color c = color(200, 200, 0); // set the colour
  int numExp = (int)random(4, 2500); // set the number of explosions i need 
  for (int i=0; i<numExp; i++) {
    float r = random(0, TWO_PI); // angle for caculating x and y
    float R = random(0, 2);      // inner radius
    explosions.add(new Explosion(x, y, R*sin(r), R*cos(r), c)); // create a new explosion
  }
}

/** build an explosion when the asteriod or spaceship is destroyed */
void explode (ArrayList<Explosion> explosions){
  noStroke(); // remove line stroke
  for (int i = 0; i < explosions.size(); i++) { //draw explosions 
    explosions.get(i).update(); // update parameters so explosion happens at right coordinates
    explosions.get(i).draw();   // draw the explosion
  }
}

/** explosions creates an explosion when the asteroid is destroyed - had some help using other code to do this bit */
class Explosion {
  float x; // x start position of explosion
  float y; // y start position of explosion
  float vx; // speed in x direction - rate at which explosion grows out
  float vy; // speed in y direction - rate at which explosion grows out
  color col; // color of the explosion
  float lifetime = 100; // how long the explosions will continue for

  Explosion(float x, float y, float vx, float vy, color col) {
    this.x = x; // x start
    this.y = y; // y start
    this.vx = vx; // x speed - angular
    this.vy = vy; // y speed - angular
    this.col = col; // explosion colour
  }

  void draw() {
    if (lifetime - 50 > 0) {
      noStroke();  // ensure there is stroke before drawing
      fill(col, lifetime - 50); // set fill color and gradual opacity
      ellipse(x, y, 4, 4); // draw the explosion
      lifetime -= 0.5; // decrease the lifetime
    }
  } 

  void update() { // increments the x, y and speed (vy) values in preperation for the next move 
    vy += G; // vy increases by a gravitational factor which we have set low in this instance
    x += vx; // increase x by the angular speed calcualtion we passed into the constructor
    y += vy; // increase y by vy
  }
}
