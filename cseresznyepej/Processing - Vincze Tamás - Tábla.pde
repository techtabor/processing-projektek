// Rajztábla 

class toll {                      //toll tulajdonságok beállítása
  int vastagsag;

  int mode;
  void meret() {

    strokeWeight(vastagsag);
  }
}

class button {                    // egységes gomb tulajdonságok
  int x;
  int y;

  button(int lx, int ly) {
    x = lx; 
    y = ly;
  }
  void render() {
    fill(0, 0, 100);
    rect(x, y, 75, 50);
  }
}
void textbutton(String text, int weight, int x, int y, float i) {
  button b = new button(x, y);
  fill(255);
  b.render();
  fill(255);
  strokeWeight(weight);
  textAlign(CENTER);
  text(text, x +75/2, y+20);
  text(i, x +75 /2, y + 40);
}
int cont= 0;
  
toll p = new toll();
int r, g, blue;

int cleared;
void setup() {
  size(800, 600);
}
int rx = 100;
int step = 1;
int my =  300;
int mx =  400;
float transparencity = 100;
void draw() {

  if (p.mode == 3) {
    float x = random(120);

    fill(random(255), random(255), random(255), transparencity);
    transparencity = transparencity + step;
    rect(random(width - 100), random( height -100), x, x ); 
    if (transparencity == 0 || transparencity ==255) {
      step= -step; 
      background(random(222));
      delay(20);
    }
  } 
  if (p.mode == 0) {
    noStroke();
    background(255);

    fill (255, 0, 20);

    textMode(CENTER);
    text ("Mode 0, Click on [mode++ & CLEAN] \n Use the buttons [UP+||Down-] \n mode1 = paint \n mode2 = lines [press shift to change breakpoint] \nOTHER MODES UNDER DEVELOPEMENT!", width/2 + 18, 510 );

    fill(r, g, blue, transparencity);
    ellipse(width /2, height / 2, rx, rx);
    fill(255);
    ellipse(width /2, height / 2, rx - 5, rx - 5);
    fill(r, g, blue, transparencity);
    ellipse(width /2, height / 2, rx  - 7, rx - 7);
    fill(255);
    ellipse(width /2, height / 2, rx - 12, rx - 12);
    fill(r, g, blue, transparencity);
    ellipse(width /2, height / 2, rx - 20, rx - 20);
    fill(255);
    ellipse(width /2, height / 2, rx - 35, rx - 35);
    fill(r, g, blue, transparencity);
    ellipse(width /2, height / 2, rx - 40, rx - 40);
    fill(255);
    ellipse(width /2, height / 2, rx - 43, rx - 43);
    fill(r, g, blue, transparencity);
    ellipse(width /2, height / 2, rx  - 50, rx - 50);
    fill(255);
    ellipse(width /2, height / 2, rx - 60, rx - 60);
    fill(r, g, blue, transparencity);
    ellipse(width /2, height / 2, rx - 65, rx - 65);
    fill(255);
    ellipse(width /2, height / 2, rx - 70, rx - 70);
    rx = rx + step;
    if (200 == rx ||  rx == 20) {
      step = -step;
    }
  }



  fill(r, g, blue, 110);
  strokeWeight(3);
  textbutton("Mode ++", 2, 120, 30, p.mode);

  if (mousePressed == true && mouseX > 120  && mouseY > 30 && mouseY < 60 && mouseX < 120 + 60 ) {
    p.mode++ ;
    if  (p.mode > 3) {
      p.mode = p.mode -p.mode;
    }
    delay(600);
  }

  strokeWeight(3);
  textbutton("CLEAR", 4, 30, 30, cleared);
  if (mousePressed == true && mouseX > 30  && mouseY > 30 && mouseY <  60 && mouseX <30 + 60 ) {
    background(255);
    delay(600);
    cleared++;
  }



  strokeWeight(3);
  textbutton("red +/-", 2, 270, 30, r);
  if (mousePressed == true && mouseX > 270  && mouseY > 30 && mouseY < 60  && mouseX < 270 + 75 )
  {   
    r++;
    if (r > 255) {
      r = 255;
    }
  }
  if (mousePressed == true && mouseX > 270  && mouseY > 60 && mouseY < 120 && mouseX < 270 + 75 )
  {   
    r--;
    if (r < 0) {
      r = 0;
    }
  }
  strokeWeight(3);
  textbutton("green +/-", 2, 360, 30, g);
  if (mousePressed == true && mouseX > 360  && mouseY > 30 && mouseY < 30 + 30 && mouseX < 360 + 60 )
  {
    g++; 
    if (g > 255) {
      g = 255;
    }
  }  
  if (mousePressed == true && mouseX > 360  && mouseY > 60 && mouseY < 30 + 60 && mouseX < 360 + 60 )
  {
    g--; 
    if (g < 0) {
      g = 0;
    }
  }  
  strokeWeight(3);
  textbutton("Blue +/-", 2, 440, 30, blue);
  if (mousePressed == true && mouseX > 440  && mouseY > 30 && mouseY < 60 && mouseX  < 440 + 70 && mouseY < 60 )
  {
    blue++;
    if (blue > 255) {
      blue = 255;
    }
  }
  if (mousePressed == true && mouseX > 440  && mouseY >60 &&  mouseY < 70 && mouseX  < 440 + 70 && mouseY < 60 + 30 )
  {

    blue--;
    if (blue < 0) {
      blue = 0;
    }
  }
  strokeWeight(3);
  textbutton("Brush +/-", 3, 600, 30, p.vastagsag);
  if (mousePressed== true && mouseX > 600 &&  mouseY > 30 && mouseY < 60 && mouseX < 650)
    p.vastagsag++; 
  delay(2);

  strokeWeight(p.vastagsag);
  if (p.vastagsag >  50) {
    p.vastagsag = 50;
  }
  if (mousePressed== true && mouseX > 600  &&  mouseY > 30 + 30  && mouseY < 60 + 30 && mouseX < 650 + 30)
    p.vastagsag--;
  ;

  strokeWeight(p.vastagsag);
  if (p.vastagsag <  1) {
    p.vastagsag = 1;
  }
  strokeWeight(3);
  textbutton("Transparencity", 2, 680, 30, transparencity);
  if (mousePressed == true && mouseX > 680 && mouseX < 680 + 75 && mouseY > 30 && mouseY < 60 ) {
    transparencity ++;
    if (transparencity > 255) {
      transparencity = 255;
    }
  }
  if (mousePressed == true && mouseX > 680 && mouseX < 680 + 75 && mouseY > 60 && mouseY < 75)
  {
    transparencity--;
    if (transparencity < 0 ) {
      transparencity = 0;
    }
  }
  print("Brush: " + p.mode + "\n");
  print("Red:"  + r + "\n" + "Green: " + g + "\nBlue: " + blue+ "\n");

  if (mousePressed == true && p.mode == 1) {
    strokeWeight(p.vastagsag);
    stroke(r, g, blue, transparencity);
    line(mouseX, mouseY, pmouseX, pmouseY);
  }

  if (mousePressed == true && p.mode == 2) {
    strokeWeight(p.vastagsag); 
    stroke(r, g, blue, transparencity);
    line(mx, my, mouseX, pmouseY);
    if (keyPressed == true && keyCode == SHIFT ) {
      mx = mouseX;
      my = mouseY;
    }
  }
  
}
