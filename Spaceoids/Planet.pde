// creates planets to add to the background 
class Planet {
  private float x, y, r = 50, g = 50, b = 150, rings = 10;  
      
  /* constructor */  
  Planet (float x, float y) {
    this.x = x; 
    this.y = y;
  }
  
  /* set x,y and RGB for the new planet */
  void setXY(int x, int y, int r, int g, int b){
    this.x = x; // x coord
    this.y = y; // y coord
    this.r = r; // red RGB
    this.g = g; // green RGB
    this.b = b; // blue RGB
  }
  
  /** draw a planet with craters and some moons */
  void draw(){
    ellipseMode(CENTER); // set ellipse draw mode to start x,y in center
    fill(r, g, b); // set RGB
    
    noStroke();
    
    // STEP1: draw Planet
    float pw = 100, inc = 5, dw = 1.2;  
    for(int i = 0; i < rings; i++){
      fill(r, g, b + (i * inc));
      ellipse(x, y, pw, pw);  
      pw /= dw;
    }
    // STEP2: draw craters on planet 
    fill(r-15, g-15, b - 20);
    ellipse(x + 10, y + 20, 20, 20);  
    ellipse(x - 20, y - 15, 20, 20);  
    
    // STEP3: draw moons
    pw = 40; inc = 5; dw = 1.2;  
    // Moon
    for(int i = 0; i < rings; i++){
      fill(b + 20 + (i * inc), g * 2, r);
      ellipse(x - 80, y - 80, pw, pw);  
      pw /= dw;
    }
 
    ellipseMode(CORNER); // set ellipse draw mode to start x,y in corner 
  }  
}
