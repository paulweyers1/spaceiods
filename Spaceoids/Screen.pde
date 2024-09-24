// Screen class manages all methods related to wrting text to screen, running splashscreens and ending the game 
class Screen  {
 
  /** builds header that goes at the top of the screen - main method in screen class */
  void buildHeader(){
    title();  // prints the title ,life and score at the top of the screen
    if (timer >= timeMax){  // if the timer has run out
      RUN=false; // stop gameplay for splashscreen
      if (level < 3) { // if u are on level 1,2 time to switch to new level a play new splashscreen before levele starts
        NEWLEVEL = true; // activate splashscreen to play for next level
        level++; // increase level by one
        timer = 0; // reset the game timer
        start = System.currentTimeMillis(); // reset the start point so timer starts @ 0
      } else { 
        gameOver(); // if you have finished level 3 then the game is over 
      }  
  }
    if (life <= 0.25) { // if you are out of life you die and game ends
      gameOver();  // runs gameover code
      RUN = false; // stops the game
    } 
  }
  
  /** prints title header includes title, timer, lives and score */
  void title(){
    fill(255); //light grey
    textSize(20); // game name text size
    text ("SPACEOIDS", width / 2 - 40, 30);  
    textSize(14); // game stats text size
    text ("Timer "+timer+" secs", width * 0.775, 23); // timer stats
    text ("Level: "+level, width * 0.775, 37); // level stats
    text ("Score: "+(int)score, 10, 23); // hits and lives stats
    text ("Life: "+life, 10, 37); // level stats
    noStroke(); //remove stroke before leaving
  }
  
  /** game over - writes end of the game on the screen */ 
  void gameOver(){
    drawStars();          // draw stars 
    ship.draw();
    title();  // prints the title ,life and score at the top of the screen
    fill(220,100);  // file grey
    rect(width / 3.2, height/5.1, 230, 250);
    fill(220);  // file grey
    textSize(34); // game stats text size
    text ("GAME OVER", width / 3, height / 3.5); // prints game over to screen
    text ("Score "+(int)score, width / 2.7, (height / 3.5) + 70); // prints final score to screen
    if (life <= 0.25) {
      text ("You Died ", width / 2.8, (height / 3.5) + 130); // prints you died to screen is life gone
    }
  }
  
  /** game over - writes end of the game on the screen */ 
  void newLevel(){
    fill(220, 255 - newtimer);  // sets fill colour and changing opacity of text
    textSize(50); // sets text size
    text ("SPACOIDS", width / 3.5, height / 3.5); // prints game name to screen
    textSize(34); // sets text size
    text ("LEVEL"+level, width / 2.6, height / 2.1); // prints game level to screen
    String desc = "";
    if (level == 1) desc = "SMILEY CENTAURI";    // asteroid belt name for level 1
    else if (level == 2) desc = "BLACK HOLE CRUSHERS";// asteroid belt name for level 2
    else if (level == 3) desc = "ALPHA BELLY ROCK";   // asteroid belt name for level 3
    text (desc, width / (0.33 * desc.length()), (height / 1.8) + 45); // prints asteroid belt name to screen
    textSize(18); // sets text size
    if(level == 1) desc = "Asteroid belt 1 mil light years from earth";    // asteroid belt name for level 1
    else if(level == 2) desc = "Asteroid belt 5 mil light years from earth";// asteroid belt name for level 2
    else if(level == 3) desc = "Asteroid belt 10 mil light years from earth";   // asteroid belt name for level 3
    text (desc, width / (0.2 * desc.length()), (height / 1.8) + 105); // prints asteroid belt name to screen
  }
  
}
