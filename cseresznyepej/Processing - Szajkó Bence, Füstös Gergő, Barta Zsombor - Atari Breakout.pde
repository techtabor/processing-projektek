int points=0;
int x=300, y=550;
boolean pause=false;
String mooving="";
int rad = 10;
float xpos=300, ypos=300;
float speed = 30;
float xspeed = 4.8;
float yspeed=sqrt(speed-xspeed*xspeed);
float xdirection=-1, ydirection=1;
boolean gameover=false;
int colour1;
int colour2;
int colour3;

class teglalap {
  int px, py;
  int w, h;
  boolean exists;
  teglalap(int lpx, int lpy, int lw, int lh) {
    px = lpx;
    py = lpy;
    w = lw;
    h = lh;
    exists = true;
  }
  void render() {
    if (exists) {
      //fill(random(0,255),random(0,255),random(0,255));
      fill(#02ED2F);
      rect(px, py, w, h);
    }
  }
  boolean isIn(float bx, float by, float bw, float bh) {
    return exists && (max(bx, px) <= min(bx + bw, px + w) && max(by, py) <= min(by + bh, py + h));
  }
  boolean isIn2(float bx, float by) {
    return exists && (px <= bx) && (bx <= px + w) &&(py <= by) && (by <= py + h);
  }
}

teglalap[] teglalapok;
teglalap[] menu;

void setup() {
  size(600, 600);
  background(0);
  ellipseMode(RADIUS);

  xpos=width/2;
  ypos=height/2;

  teglalapok = new teglalap[25];
  menu = new teglalap[3];
  menu[0] = new teglalap(300,250,220,60);
  menu[1] = new teglalap(300,350,220,60);
  menu[2] = new teglalap(300,450,220,60);

  int k = 0;

  for (int i=50; i<200; i+=35) {
    for (int j=80; j<=480; j=j+89) {
      teglalapok[k++] = new teglalap(j, i, 84, 30);
    }
  }
  
    rectMode(CENTER);
    textAlign(CENTER);
    textSize(50);
    fill(0, 255, 0);
    text ("PONG GAME", 300, 150);
    fill(255);
    textSize(20);
    text("Press E, M or H", 300, 180);
    textSize(50);
    fill(0, 255, 0);
    rect(300,250,220,60);
    rect(300,350,220,60);
    rect(300,450,220,60);
    fill(0);
    text("EASY", 300, 270);
    text("MEDIUM", 300, 370);
    text("HARD", 300, 470);
    rectMode(CORNER);
}
void draw() {
  
    

  
  if (key == 'm') {
    if (gameover || points==25) {
      if (points == 25) {
        textSize(60);
        textAlign(CENTER);
        if ((millis()/200)%2==0) {
          colour1 = (int)random(255);
          colour2 = (int)random(255);
          colour3 = (int)random(255);
          fill(colour1, colour2, colour3);
          text("YOU WIN", 300, 300);
        } else {
          background(255);
        }
      } else {
        textSize(60);
        textAlign(CENTER);
        if ((millis()/200)%2==0) {
          colour1 = (int)random(255);
          colour2 = (int)random(255);
          colour3 = (int)random(255);
          fill(colour1, colour2, colour3);
          text("GAME OVER\n"+points, 300, 300);
        } else {
          background(255);
        }
      }
    } else {

      background(0);
      
      if (frameCount%100==0) {
        speed += 8;
      }

      for (int i=0; i<25; i++) {
        teglalapok[i].render();
      }

      fill(255);
      textSize(30);
      text(points, 20, 50);
      fill(255, 255, 0);
      rect(mouseX-35, height-50, 70, 15, 5);  
      x=mouseX;
      y=mouseY;
      if (mouseX<=35) {
        rect(0, height-50, 70, 15, 5);
      }
      if (mouseX>=565) {
        rect(530, height-50, 70, 15, 5);
      }
      fill(255, 0, 0);
      ellipse(xpos, ypos, rad, rad);
      fill(255);
      //rect(xpos-(rad-rad/5),ypos-(rad-rad/5),2*(rad-rad/5),2*(rad-rad/5));
      xpos= xpos + (xspeed*xdirection);
      ypos= ypos + (yspeed*ydirection);

      for (int i=0; i<25; i++) {
        if (teglalapok[i].isIn(xpos-(rad-rad/5), ypos-(rad-rad/5), 2*(rad-rad/5), 2*(rad-rad/5))) {
          //xdirection*=-1;
          ydirection*=-1;
          teglalapok[i].exists = false;
          points++;
          break;
        }
      }

      if (xpos<rad || xpos>width-rad) {
        xdirection *=-1;
      }
      if (ypos<rad) {
        ydirection *= -1;
      }



      /*if (ypos>=height-rad-50 && xpos<mouseX+rad+35 && xpos>mouseX-rad-35) {
       ydirection *=-1;
       
       xspeed += random(-0.5, 0.5);
       xspeed = abs(xspeed);
       if(xspeed*xspeed > 0.9*speed) {
       xspeed = sqrt(0.9*speed);
       }
       yspeed=sqrt(speed-xspeed*xspeed);
       
       } */
      if (ypos>=height-rad-50 && xpos<mouseX+rad+35 && xpos>mouseX-rad-35) {
        xdirection = -1;
        ydirection *= -1;
        xspeed = (mouseX-xpos)/40*sqrt(speed);
        xspeed += random(-0.2, 0.2) * sqrt(speed);
        if (xspeed*xspeed > 0.9*speed) {
          xspeed = xspeed / abs(xspeed) *sqrt(0.9*speed);
        }
        yspeed=sqrt(speed-xspeed*xspeed);
      } else if (ypos>=height-rad-50) {
        background(255);
        gameover = true;
      }
    }
  }
  
  if (key=='e') {
    if (gameover || points==25) {
      if (points == 25) {
        textSize(60);
        textAlign(CENTER);
        if ((millis()/200)%2==0) {
          colour1 = (int)random(255);
          colour2 = (int)random(255);
          colour3 = (int)random(255);
          fill(colour1, colour2, colour3);
          text("YOU WIN", 300, 300);
        } else {
          background(255);
        }
      } else {
        textSize(60);
        textAlign(CENTER);
        if ((millis()/200)%2==0) {
          colour1 = (int)random(255);
          colour2 = (int)random(255);
          colour3 = (int)random(255);
          fill(colour1, colour2, colour3);
          text("GAME OVER\n"+points, 300, 300);
        } else {
          background(255);
        }
      }
    } else {

      background(0);
      if (frameCount%150==0) {
        speed += 3;
      }

      for (int i=0; i<25; i++) {
        teglalapok[i].render();
      }

      fill(255);
      textSize(30);
      text(points, 20, 50);
      fill(255, 255, 0);
      rect(mouseX-35, height-50, 70, 15, 5);  
      x=mouseX;
      y=mouseY;
      if (mouseX<=35) {
        rect(0, height-50, 70, 15, 5);
      }
      if (mouseX>=565) {
        rect(530, height-50, 70, 15, 5);
      }
      fill(255, 0, 0);
      ellipse(xpos, ypos, rad, rad);
      fill(255);
      //rect(xpos-(rad-rad/5),ypos-(rad-rad/5),2*(rad-rad/5),2*(rad-rad/5));
      xpos= xpos + (xspeed*xdirection);
      ypos= ypos + (yspeed*ydirection);

      for (int i=0; i<25; i++) {
        if (teglalapok[i].isIn(xpos-(rad-rad/5), ypos-(rad-rad/5), 2*(rad-rad/5), 2*(rad-rad/5))) {
          //xdirection*=-1;
          ydirection*=-1;
          teglalapok[i].exists = false;
          points++;
          break;
        }
      }

      if (xpos<rad || xpos>width-rad) {
        xdirection *=-1;
      }
      if (ypos<rad) {
        ydirection *= -1;
      }



      /*if (ypos>=height-rad-50 && xpos<mouseX+rad+35 && xpos>mouseX-rad-35) {
       ydirection *=-1;
       
       xspeed += random(-0.5, 0.5);
       xspeed = abs(xspeed);
       if(xspeed*xspeed > 0.9*speed) {
       xspeed = sqrt(0.9*speed);
       }
       yspeed=sqrt(speed-xspeed*xspeed);
       
       } */
      if (ypos>=height-rad-50 && xpos<mouseX+rad+35 && xpos>mouseX-rad-35) {
        xdirection = -1;
        ydirection *= -1;
        xspeed = (mouseX-xpos)/40*sqrt(speed);
        xspeed += random(-0.2, 0.2) * sqrt(speed);
        if (xspeed*xspeed > 0.9*speed) {
          xspeed = xspeed / abs(xspeed) *sqrt(0.9*speed);
        }
        yspeed=sqrt(speed-xspeed*xspeed);
      } else if (ypos>=height-rad-50) {
        background(255);
        gameover = true;
      }
    }
  }
  
  if (key=='h') {
    if (gameover || points==25) {
      if (points == 25) {
        textSize(60);
        textAlign(CENTER);
        if ((millis()/200)%2==0) {
          colour1 = (int)random(255);
          colour2 = (int)random(255);
          colour3 = (int)random(255);
          fill(colour1, colour2, colour3);
          text("YOU WIN", 300, 300);
        } else {
          background(255);
        }
      } else {
        textSize(60);
        textAlign(CENTER);
        if ((millis()/200)%2==0) {
          colour1 = (int)random(255);
          colour2 = (int)random(255);
          colour3 = (int)random(255);
          fill(colour1, colour2, colour3);
          text("GAME OVER\n"+points, 300, 300);
        } else {
          background(255);
        }
      }
    } else {

      background(0);
      if (frameCount%80==0) {
        speed += 15;
      }

      for (int i=0; i<25; i++) {
        teglalapok[i].render();
      }

      fill(255);
      textSize(30);
      text(points, 20, 50);
      fill(255, 255, 0);
      rect(mouseX-35, height-50, 70, 15, 5);  
      x=mouseX;
      y=mouseY;
      if (mouseX<=35) {
        rect(0, height-50, 70, 15, 5);
      }
      if (mouseX>=565) {
        rect(530, height-50, 70, 15, 5);
      }
      fill(255, 0, 0);
      ellipse(xpos, ypos, rad, rad);
      fill(255);
      //rect(xpos-(rad-rad/5),ypos-(rad-rad/5),2*(rad-rad/5),2*(rad-rad/5));
      xpos= xpos + (xspeed*xdirection);
      ypos= ypos + (yspeed*ydirection);

      for (int i=0; i<25; i++) {
        if (teglalapok[i].isIn(xpos-(rad-rad/5), ypos-(rad-rad/5), 2*(rad-rad/5), 2*(rad-rad/5))) {
          //xdirection*=-1;
          ydirection*=-1;
          teglalapok[i].exists = false;
          points++;
          break;
        }
      }

      if (xpos<rad || xpos>width-rad) {
        xdirection *=-1;
      }
      if (ypos<rad) {
        ydirection *= -1;
      }



      /*if (ypos>=height-rad-50 && xpos<mouseX+rad+35 && xpos>mouseX-rad-35) {
       ydirection *=-1;
       
       xspeed += random(-0.5, 0.5);
       xspeed = abs(xspeed);
       if(xspeed*xspeed > 0.9*speed) {
       xspeed = sqrt(0.9*speed);
       }
       yspeed=sqrt(speed-xspeed*xspeed);
       
       } */
      if (ypos>=height-rad-50 && xpos<mouseX+rad+35 && xpos>mouseX-rad-35) {
        xdirection = -1;
        ydirection *= -1;
        xspeed = (mouseX-xpos)/40*sqrt(speed);
        xspeed += random(-0.2, 0.2) * sqrt(speed);
        if (xspeed*xspeed > 0.9*speed) {
          xspeed = xspeed / abs(xspeed) *sqrt(0.9*speed);
        }
        yspeed=sqrt(speed-xspeed*xspeed);
      } else if (ypos>=height-rad-50) {
        background(255);
        gameover = true;
      }
    }
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (pause==false) {
      noLoop();
      pause = true;
    } else {
      loop();
      pause = false;
    }
  }
}
