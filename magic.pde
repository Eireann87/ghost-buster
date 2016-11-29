/* Code written by Erin Brooker. For RTA 948, Nick Stedman 2015. 
   
   Some code adapted from https://github.com/mleonhart/LeapMotion_AngelaBlaster.git
   
   Some code adapted from http://www.lagers.org.uk/s4p/download.html
   
   Background image from http://hdwallpapersfit.com/wp-content/uploads/2015/01/freaky-haunted-house-hd-wallpapers.jpg
*/ 


import sprites.utils.*;
import sprites.maths.*;
import sprites.*;

import de.voidplus.leapmotion.*;

LeapMotion leap;
GameEngine game;

PImage bimg; 
PImage wimg; 

int numBullets = 10;
Sprite[] bullets = new Sprite[numBullets];
Sprite wand;
final int numGhosts = 6;
Sprite[] ghost = new Sprite[numGhosts];

int mana = 100; 

int RUN_GAME = 1;
int GAME_OVER = 2; 
int YOU_WIN = 3; 
int gameState = RUN_GAME;

int numDead = 0;

StopWatch sw = new StopWatch();


void setup() {
  size (1024, 768);
  
  bimg = loadImage("hauntedhouse.jpg"); 
  wimg = loadImage("housepretty.jpg"); 

  leap = new LeapMotion(this).withGestures("key_tap, swipe");

  game = new GameEngine(this);

  for (int i = 0; i < numBullets; i++) {
    bullets[i] = new Sprite(this, "sparkler.png", 4, 1, 21);
    bullets[i].setXY(-10000, -10000); 
    bullets[i].setFrameSequence(0, 3, 0.05f); 
    bullets[i].setVisible(false); 
    bullets[i].setVelXY(-20.0f, 0);
  }

  wand = new Sprite(this, "Star_Wand.png", 50);

  for (int i = 0; i < numGhosts; i++) {
    ghost[i] = new Sprite(this, "ghost2.png", "ghostmask2.png", 4, 1, 0);
    ghost[i].setDomain(-100, -60, width + 100, height - 100, Sprite.REBOUND);
  }

  game.initGhosts();

  registerMethod("pre", this);
}


void draw() {
  background(bimg); 
  if (game.gameState == RUN_GAME) runGame(); 
  if (game.gameState == GAME_OVER) game.gameOver(); 
  if (game.gameState == YOU_WIN) game.win();
}

void runGame() {
  game.runGame();  
  S4P.drawSprites();
}



void pre() {
  // Calculate time difference since last call
  float elapsedTime = (float) sw.getElapsedTime();
  game.processCollisions();
  S4P.updateSprites(elapsedTime);
}

