int kepx=int( random(150, 1050));
int kepy=int ( random(150, 450));
int minhatarx= kepx-25;
int maxhatarx= kepx+25;
int minhatary= kepy-25;
int maxhatary= kepy+25;
PImage img;
boolean find = false;
PGraphics maskg;
PGraphics hidden;
boolean parancs;
boolean animate = false ;
int sizeOfImage = 100;
int time;
int times;





void setup() {
  parancs=false;
  background(255);
  size(1200, 600);
  noFill();
  img = loadImage("lajhar.jpg");
  maskg = createGraphics(1200, 600);
  hidden = createGraphics(1200, 600);
  textSize(28);
  textAlign(CENTER);
  fill(0);
  text("Találd meg a lajhárt!", 600, 300);
}

void draw() {
  if (parancs==false) {
    delay(3000);
  }                                                                  ////////noLoooooop!!!!!!!!!!!!!!!!!
  if (find==false) {
    background(200, 0, 0);
    noFill();
    maskg.beginDraw();
    maskg.background(0);
    maskg.fill(255);
    maskg.ellipse(mouseX, mouseY, 100, 100);
    maskg.endDraw();
    hidden.beginDraw();
    hidden.background(255);
    hidden.imageMode(CENTER);
    hidden.image(img, kepx, kepy, 100, 100);
    hidden.endDraw();
    mask(hidden, maskg);
    image(hidden, 0, 0);
    ellipse(mouseX, mouseY, 100, 100);
    parancs=true;
    time=millis()/1000-4;
    textAlign(LEFT, TOP);
    textSize(20);
    text(time+  " másodperc", 0, 0);
  }
  if (animate) {
    if (sizeOfImage < 300) {
      sizeOfImage+= 2;
    }
    fill(0);
    image(img, kepx, kepy, sizeOfImage, sizeOfImage);
  }
 
   if (mousePressed==true&&mouseX>1100&&mouseY<25) {
     exit();
    }
  
}

void mouseMoved() {
  if (pmouseX>minhatarx&&pmouseX<maxhatarx&&pmouseY>minhatary&&pmouseY<maxhatary) {
    find=true;
    background(255);
    times=time;
    textAlign(LEFT, TOP);
    textSize(20);
    fill(200, 0, 0);
    text(times+ " másodperc", 0, 0);
    fill(0);
    textSize(20);
    textAlign(CENTER, TOP);
    if (times<=2) { 
      text("Olyan gyors vagy, mint egy számítógép!", 600, 0);
    }
    if (times>2&&times<=5) { 
      text("Szép teljesítmény!", 600, 0);
    }
    if (times>5&&times<=8) { 
      text("Csak így tovább!", 600, 0);
    }
    if (times>8&&times<=12) { 
      text("Van még mit fejlődnöd!", 600, 0);
    }
    if (times>12) { 
      text("Rádfér még a gyakorlás!", 600, 0);
    }



    fill(150);
    rect(1100, 0, 100, 25);
    fill(255);
    textAlign(CENTER);
    text("Kilépés", 1150, 20);


    imageMode(CENTER);
    image(img, kepx, kepy, 100, 100);
    animate=true;
    
   
    
  }
}



void mask(PImage target, PImage mask) {
  mask.loadPixels();
  target.loadPixels();
  if (mask.pixels.length != target.pixels.length) {
    println("Images are not the same size");
  } else {
    for (int i=0; i<target.pixels.length; i++) {
      target.pixels[i] = ((mask.pixels[i] & 0xff) << 24) | (target.pixels[i] & 0xffffff);
    }
    target.updatePixels();
  }
}
