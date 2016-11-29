
class GameEngine {
  int timer = 0;
  int RUN_GAME = 1;
  int GAME_OVER = 2; 
  int YOU_WIN = 3; 
  int gameState = RUN_GAME;




  GameEngine(PApplet pa) {
  }

  void drawScore() {
    fill(0, 128, 255); 
    rect(40, 40, mana, 10);
    textSize(14); 
    text("MANA", 40, 30);
    text(mana, 90, 30); 
  }

  void gameOver() {
    background(0); 
    fill(255);
    textAlign(CENTER); 
    text("GAME OVER", width/2, height/2); 

    text("Swipe to restart", width/2, height/2 +50);
  }

  void evaluateScore() {
    if (numDead == numGhosts) gameState = YOU_WIN; 
    if (mana <= 0) gameState = GAME_OVER;
    if (mana <= 0 && numGhosts > numDead) gameState = GAME_OVER;
  }


  void reset() {
    gameState = RUN_GAME; 
    game.initGhosts();
    mana = 100;
  }

  void win() {
    background(wimg); 
    fill(0);
    textAlign(CENTER);
    textSize(32);  
    text("YOU WIN!", width/2, height/6); 

    text("Swipe to play again!", width/2, height/6 +50);
  }

  void runGame() {
    game.showCharacters();
    game.drawScore(); 
    game.evaluateScore();
  }

  void initGhosts() {
    float speed, angle;
    numDead = 0;
    for (int i = 0; i < numGhosts; i++) {
      ghost[i].setXY(random(50, width - 50), random(-20, height - 200));
      angle = ((int)random(0, 4)) * 45 + random(-20, 20);
      speed = random(40, 100);
      ghost[i].setSpeed(speed, angle);
      ghost[i].setAccXY(4, 4);
      ghost[i].setVisible(true);
      ghost[i].setDead(false);
      ghost[i].setFrameSequence(0, 3, 0.2f);
      System.out.print(ghost[i].getX() + "   " + ghost[i].getY() + "    ");
      System.out.println(ghost[i].getVelX() + "   " + ghost[i].getVelY());
    }
    System.out.println();
  }

  void showCharacters() { 
    S4P.drawSprites();
    // show Wand wherever the Leap senses your hand to be
    for (Hand hand : leap.getHands ()) {
      wand.setXY((int)hand.getPosition().x, height-30);
      wand.setRot((int)hand.getYaw()*0.02);
    }
  }

  void processCollisions() {
    for (int i = 0; i <numBullets; i++) {
      if (bullets[i].isVisible()) {
        for (int g = 0; g < numGhosts; g++) {
          if (!ghost[g].isDead() &&  bullets[i].oo_collision(ghost[g], 60)) {
            numDead++;
            println(numDead);
            bullets[i].setXY(-10000, -10000);
            ghost[g].setXY(10000, 10000);
            ghost[g].setVelXY(0, 0);
            ghost[g].setDead(true);
            bullets[i].setVisible(false);
            mana++; 
            break;
          }
        }
      }
    }
  }
  void handleSpriteEvents(Sprite sprite) {
  }
}

