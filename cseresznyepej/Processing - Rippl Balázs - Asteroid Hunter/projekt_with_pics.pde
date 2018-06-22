Ship hajo = new Ship();
PImage foto;
PImage asteroid;
PImage explode;
int mozgat;
int ido;
int db =0;
int csdb =0;
int r;
int r2;
int idoz;
int vertik;
boolean over;
boolean pause;
int count;
int loves;
boolean cd;
int h;
boolean csill = true;
float sp1;
float sp2;
int startmillis = 0;
int pausemillis = 0;
Akad[] arrayOfAkad = new Akad[900000];
Shot[] shots = new Shot[9000000];
Star[] csillagok = new Star[51];
void setup() {
  size(450, 600);
  background(0);
  frameRate(180);
  over = false;
  loves =0;
  foto = loadImage("ship.png");
  asteroid = loadImage("asteroid.png");
  explode = loadImage("explode.png");
  for(int i=0;i<50;i++){
    r2 = int(random(450));
    csillagok[i] = new Star(r2);
    csdb++;
  }
}
void draw() {
  int fps = int(frameRate);
  ido = millis()-startmillis;
  sp1 = 1 + ido/8000.0;
  sp2 = 3 + ido/8000.0;
  background(0);
  r = int(random(450));
  idoz = ido%200;
  if (idoz < 8) {
    arrayOfAkad[db] = new Akad(r);
    db++;
  }
  for(int i=0;i<csdb;i++){
    if(csillagok[i]==null){
      csillagok[i] = new Star(r2);
    }
  }
  if (db>0) {  
    for (int d=0; d<csdb; d++) {
      if (csill ==true) { 
        csillagok[d].display();
        csillagok[d].move();
      }
    }
    for (int i=0; i<db; i++) {
      arrayOfAkad[i].display();
      arrayOfAkad[i].megy();
      arrayOfAkad[i].check();
    }
  }
  for (int j=0; j<loves; j++) {
    shots[j].display();
    shots[j].move();
  }
  fill(0, 255, 255);
  text("FPS:"+fps+"  Pontszám:"+count+" Szünet: p   Csillagok: c", 30, 30);
  if (over ==true) {
    textSize(30);
    textAlign(CENTER);
    text("Játék vége\nPontjaid:"+count+"\nNyomj r-t az újrakezdéshez", 225, 150);
    noLoop();
  }
  hajo.display();
  hajo.move(mozgat);
  hajo.getter();
}
class Ship {
  int x;
  int y;
  Ship() {
    x = 225;
    y = 550;
  }
  void display() {
    fill(255, 0, 0);
    imageMode(CENTER);
    image(foto, x, y);
  }
  void move(int irany) {
    if (irany == 2 && x<430) {
      x+=4;
    }
    if (irany == 1 && x>20) {
      x-=4;
    }
  }
  void getter() {
    vertik = x;
  }
}
void keyPressed() {
  if (keyCode==RIGHT) {
    mozgat = 2;
  } 
  if (keyCode==LEFT) {
    mozgat = 1;
  }
  if (key=='p') {
    if (pause==false) {
      pausemillis = millis();
      noLoop();
      pause = true;
    } else {
      startmillis = pausemillis;
      loop();
      pause = false;
      mozgat = 0;
    }
  }
  if (keyCode==UP) {
    if (cd != true) {
      shots[loves] = new Shot();
      loves++;
      cd = true;
    }
  }
  if (key=='c') {
    if (csill==true) {
      csill = false;
    } else {
      csill = true;
    }
  }
  if (key=='r') {
    if (over == true) {
      hajo.x = 255;
      for (int ez=0; ez<db; ez++) {
        arrayOfAkad[ez] = null;
      }
      db = 0;
      mozgat = 0;
      count = 0;
      sp1 = 1;
      sp2 = 3;
      for (int ez=0; ez<db; ez++) {
        shots[ez] = null;
      }
      loves = 0;
      cd = false;
      over=false;
      startmillis = millis();
      textSize(11);
      textAlign(LEFT);
      loop();
    }
  }
}
void keyReleased() {
  if (keyCode==RIGHT || keyCode==LEFT) {
    mozgat = 0;
  }
  if (keyCode == UP) {
    cd = false;
  }
}
class Akad {
  int x;
  float y;
  float speed = random(sp1,sp2);
  boolean alive;
  int robb = 10;
  Akad(int get) {
    x = get;
    y = 0;
    alive = true;
  }
  void display() {
    if (alive==true) {
      fill(0, 0, 255);
      imageMode(CENTER);
      image(asteroid,x, y);
    }
    if(alive == false && robb < 10){
      image(explode,x,y);
      robb++;
    }
  }
  void megy() {
    if (y<650) {
      y += speed;
    }
  }
  void check() {
    if (y>=520 && y<580 && alive == true) {
      if (x<vertik+35 && x>vertik-35) {
        over = true;
      }
    }
    if (y>616) {
      alive = false;
    }
    for (h=0; h<loves; h++) {
      if (shots[h].x>this.x-15 && shots[h].x<this.x+15) {
        if (shots[h].y>this.y-15 && shots[h].y<this.y+15) {
          if (shots[h].alive == true && this.alive == true) {
            alive = false;
            shots[h].alive = false;
            image(explode,x,y);
            robb = 0;
            count++;
          }
        }
      }
    }
  }
}
class Shot {
  int x;
  int y;
  color c;
  boolean alive;
  Shot() {
    x = vertik;
    y = 520;
    c = color(255, 255, 0);
    alive = true;
  }
  void display() {
    if (alive==true) {
      fill(c);
      rectMode(CENTER);
      rect(x, y, 8, 20, 5);
    }
  }
  void move() {
    y-=8;
    if (y<-11) {
      alive = false;
    }
  }
}
class Star {
  int x;
  float y;
  color c;
  float speed = random(0.3);
  Star(int hely) {
    x = hely;
    y = random(height);
    c = color(255);
  }
  void display() {
    fill(c);
    ellipseMode(CENTER);
    ellipse(x, y, 3, 3);
  }
  void move() {
    if (y<630) {
      y+= speed;
    } else {
      y = 0.0;
    }
  }
}
