void leapOnKeyTapGesture(KeyTapGesture g) {
  int       id               = g.getId();
  Finger    finger           = g.getFinger();
  PVector   position         = g.getPosition();
  PVector   direction        = g.getDirection();
  long      duration         = g.getDuration();
  float     duration_seconds = g.getDurationInSeconds();

  for (int i = 0; i < numBullets; i++) {
    if (!bullets[i].isOnScreem()) {
      bullets[i].setDead(false);
      bullets[i].setXY(wand.getX(), wand.getY() - bullets[i].getHeight()/2); 
      bullets[i].setVelXY(0, -500);
      bullets[i].setAccXY(0, -300);
      bullets[i].setDirection(radians(45*-1)+wand.getRot()); 
      bullets[i].setVisible(true); 
      bullets[i].setFrameSequence(0, 3, 0.1f, 5);
      mana--;
    }
  }
}

void leapOnSwipeGesture(SwipeGesture g, int state) {
  int     id               = g.getId();
  Finger  finger           = g.getFinger();
  PVector position         = g.getPosition();
  PVector position_start   = g.getStartPosition();
  PVector direction        = g.getDirection();
  float   speed            = g.getSpeed();
  long    duration         = g.getDuration();
  float   duration_seconds = g.getDurationInSeconds();

 switch(state){
    case 1:  // Start
      break;
    case 2: // Update
      break;
    case 3: // Stop
      println("SwipeGesture: "+id);
      if (game.gameState == GAME_OVER || game.gameState == YOU_WIN) {
      game.reset();
      break;
    }
  }
}

