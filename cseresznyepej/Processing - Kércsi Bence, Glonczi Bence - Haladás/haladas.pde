PGraphics pg;
PImage urhajo;
int rnd = int(random(3, 6));
int a = 1;
int m =0;
PFont mono;
int random=int(random(100, 200));
int [] x= new int[random];
int [] y= new int[random];
int [] enemyx=new int [rnd];
int [] enemyy=new int [rnd];
int olesek=0;
boolean riset=true;
int delay;
int h=0;
int p=0;
int q=0;
int v=0;
int t=0;

void setup() {
  size(750, 700);
  pg = createGraphics(750, 700);
  for (int szam=0; szam<random; szam++) {
    x[szam]=int(random(1, 749));
    y[szam]=int(random(1, 699));}
  for (int szam=0; szam<rnd; szam++) {
    enemyx[szam]=int(random(1, 749));
    enemyy[szam]=0;
  }
}

void restart() {
  rnd = int(random(3, 6));
  a = 1;
  m =0;
  random=int(random(100, 200));
  x= new int[random];
  y= new int[random];
  enemyx=new int [rnd];
  enemyy=new int [rnd];
  olesek=0;
  riset=true;
  h=0;
  p=0;  
  pg = createGraphics(750, 700);
  for (int szam=0; szam<random; szam++) {
    x[szam]=int(random(1, 749));
    y[szam]=int(random(1, 699));}
  for (int szam=0; szam<rnd; szam++) {
    enemyx[szam]=int(random(1, 749));
    enemyy[szam]=0; 
    v=0;
  }
}

void draw() {
  runGame();
}
  
void keyPressed() {
    if ( (key=='p') || (key=='P') ) {
    p++;
    noLoop();
    }
    if (p>=1) {
        if ( (key=='r') || (key=='R') ) {
              loop();
              p--;
        }
    } 
    if (h>=1) {
        if ( (key=='r') || (key=='R') ) {
          h--;
          restart();   
          loop();
        }
    }
}




void runGame() {
  
  String [] rekord=loadStrings("rekord.txt");
  pg.beginDraw();
  pg.background(0);
  urhajo=loadImage("urhajo.png");
  pg.stroke(255);
  if (mousePressed == true) {
    pg.strokeWeight(2);
    pg.stroke(random(1, 225), random(1, 225), random(1, 225));                     /*ez itt a vonal színe*/
    pg.line(mouseX, 600, mouseX, 100);}
  pg.stroke(255);
  pg.strokeWeight(random(1, 5));
  for (int szamlalo=0; szamlalo<x.length; szamlalo++) {
    y[szamlalo]+=1;
    pg.strokeWeight(random(1, 6));
    pg.point(x[szamlalo], y[szamlalo]);
    if (y[szamlalo]+10>=700){
      x[szamlalo]=int(random(1, 749));
      y[szamlalo]=0;}}
  for (int szamlalo2=0; szamlalo2<rnd; szamlalo2++) {
    pg.stroke(255, 0, 0);
    pg.fill(0, 0, 255);
    pg.strokeWeight(5);
    if (millis()<5000) {m=1;
    } else m=millis()/5000;
        enemyy[szamlalo2]+=1*m;
    if (h>0) {
    enemyy[szamlalo2]=0;
    }   
    pg.ellipse(enemyx[szamlalo2], enemyy[szamlalo2], 20, 40);
    if (mousePressed ==true) {
      for (int szamlalo3=0; szamlalo3<30; szamlalo3++)
        if ((enemyx[szamlalo2]==mouseX-15+szamlalo3)&&(enemyy[szamlalo2]+20>=100)) {
          enemyy[szamlalo2]=0;
          enemyx[szamlalo2]=int(random(1, 749));
          olesek+=1;
          if (olesek>int(rekord[0])) {
            rekord[0]=str(olesek);
            saveStrings("rekord.txt", rekord);}}}
    if (enemyy[szamlalo2]>=700) {
      pg.textSize(15);
      q=millis()-t;
      image(pg, 0, 0);
      pg.filter(BLUR, 6);
      pg.text("Ölések: "+olesek+" \n"+"Túlélt idő: "+q/1000+" másodperc \n All time rekord: "+rekord[0], pg.width/2-90, pg.height/2-15);
      println(v);
      h++;
      t+=millis();
      pg.endDraw();
      noLoop();}}
  mono =loadFont("jesus.vlw");
  pg.textFont(mono);
  pg.textSize(15);
  pg.text("Ölések: "+olesek, 10, 30); 
  pg.strokeWeight(5);
  pg.fill(255, 255, 255);
  pg.stroke(255);
  pg.image(urhajo,mouseX-189.5, 450);
  pg.endDraw();
  image(pg, 0, 0);
  
}
