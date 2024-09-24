// bullet fired by the space ship to destry the asteriods 
void newBullet(String input){  
  if(bullets.size() > 10) {bullets.remove(0);} // only allowed 10 bullets at a time removes from the front
  bullets.add(new Bullet(ship.getX() + 15, ship.getY() - 30)); // adds a new bullet when mouse/up_key was pressed
  for(Bullet b: bullets){b.bulletTrajectory(ship.getX(),input);}  // sets trajectory of all active bullets in direction of mouse
}
 
/** bullet class creates a bullet to destory asteriods */
class Bullet extends Rectangle {
  private float col_red = Color.red.getRGB(); // color of bullet
  private final float speed = 8; // speed in x and y direction 
  
  /** constructor */  
  Bullet (float x, float y) {super(x, y, 5, 5, 1, 3);} // update values in inherited rectangle class
  
  /** step bullet one movement forward */ 
  void stepXYb() {x -= vx; y -= vy;}
  
  /** sets the trajectory of the bullet to follow the current mouse x and y location */
  void bulletTrajectory(float ship_x, String input){  
    float vxb = ship_x - mouseX;  // get mouse locations to use in clac
    float vyb = 550 - mouseY;
    if(input == "k"){
     vxb = ship_x - 200;  // get mouse locations to use in clac
     vyb = 550;
    }
    double len = Math.sqrt(vxb * vxb + vyb * vyb); // get length of hypotenuse to determine direction
    vxb *= speed / (float)len;  // calc velocity that will move bullet x, y in direction of mouse 
    vyb *= speed / (float)len;
    vx = vxb; // 1.09 is a calibration required to get more accurate alignment to the mouse
    vy = vyb; // no calibrration required here
  }

  /** draw bullet */
  void draw(){
    super.draw(x,y); // set coordinates for colission detection
    strokeWeight(4); // border thickness for elipse representing the bullet
    stroke(col_red); // bullet is red
    float xy_inc=0, w_inc=1, s_inc=0; // factors used to create bullet tail
    for (int i = 0; i < 7; i++){ // draws bullet with a tail
      ellipse(x + xy_inc, y + xy_inc, w/w_inc, w/w_inc); 
      stroke(235 + s_inc, 0, 0); // set next ellipse border color
      xy_inc++; // moves the starting x,y back to start behind previous thus creating tail
      w_inc = (w_inc == 1) ? 1.2 : w_inc + i * 4; // adjusts the width to make it smaller
      s_inc = 30 + (i * 10);  // adjusts color to make it darker
    }
    stepXYb(); // increments position of bullet for next draw cycle
  }  
}
