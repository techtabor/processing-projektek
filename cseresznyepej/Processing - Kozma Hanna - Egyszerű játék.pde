void setup() {
  size(300, 300);
}
int x=0, y=0, i=0, h=0;
int msgDelay = 0 ,mssDelay=0;
String msg;
boolean square;
void draw() {
  background(0, 150, 230);
  if (square) {
    rect(x, y, 20, 20);
  } else {
    ellipse(x+10, y+10, 20, 20);
  }
  if (x<0) {
    x=0;
  }
  if (x>width-20) {
    x=width-20;
  }
  if (y<0) {
    y=0;
  }
  if (y>height-20) {
    y=height-20;
  }
  if (keyPressed) {
    if (key=='d' || key == 'D' || key==CODED && keyCode==RIGHT) {
      x=x+1;
    }
  }
  if (keyPressed) {
    if (key=='w' || key == 'W'|| key==CODED && keyCode==UP) {
      y=y-1;
    }
  }
  if (keyPressed) {
    if (key=='a' || key == 'A'|| key==CODED && keyCode==LEFT) {
      x=x-1;
    }
  }
  if (keyPressed) {
    if (key=='s' || key == 'S'|| key==CODED && keyCode==DOWN) {
      y=y+1;
    }
  }
  text("score: "+i, width-50, 30);
  text("miss: "+h, width-50, 60);
  if (msgDelay>0) {
    text(msg, width-50, height-50);
    msgDelay--;
  }
  if(mssDelay>0){
    fill(0,100,0);
    mssDelay--;
  }else{
    fill(255);
  }
}
void mousePressed() {
  if (mousePressed==true) {
    if (mouseX>=x && mouseY>=y && mouseX<20+x && mouseY<20+y) {
      fill(0);
      if (square) {
        rect(x, y, 20, 20);
      } else {
        ellipse(x+10, y+10, 20, 20);
      }
      fill(255);
      i++;
    } else {
      h++;
      msgDelay = 20;
      msg = "missed";
    }
  }
  if (i==25 && h<25) {
    i++;
    text("You win!", 140, 140);
    noLoop();
  }
  if (i<25 && h==25) {
    h++;
    text("Game over", 140, 140);
    noLoop();
  }
}
void keyPressed() {
  if (key==ENTER) {
    square = !square;
  }
  if(key ==CODED && keyCode==SHIFT){
    mssDelay=60;
     if (square) {
    rect(x, y, 20, 20);
  } else {
    ellipse(x+10, y+10, 20, 20);
  }
  }
  
}
