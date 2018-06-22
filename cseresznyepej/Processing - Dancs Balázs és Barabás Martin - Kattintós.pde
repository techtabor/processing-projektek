int score=0;
int ct,x,y;
int t=second()+minute()*60+hour()*3600;
void setup()
{
  fullScreen();
  smooth();
  if (score==0) {background(0);};
  stroke(255,0,0);
  textAlign(CENTER,CENTER);
  strokeWeight(1);
  line(1819,0,1819,1080);
  line(0,1019,1920,1019);
  noStroke();
  fill(0);
  rect(0,0,1819,1019);
  x=round(random(15,1804));
  y=round(random(15,1003));
}

void draw()
{
  textAlign(CENTER,CENTER);
  fill(255);
  noStroke();
  ellipse(1870, 50, 100, 100);
  fill(0);
  textSize(12); 
  text("3",1915,49);
  text("6",1874,92);
  text("9",1827,48);
  text("12",1870,5);
  float s = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
  float m = map(minute(), 0, 60, 0, TWO_PI) - HALF_PI;
  float h = map(hour() % 12, 0, 12, 0, TWO_PI) - HALF_PI;
  stroke(255,0,0);
  strokeWeight(1);
  line(1870, 50, cos(s) * 40 + 1870, sin(s) * 40 + 50);
  strokeWeight(2);
  stroke(0);
  line(1870, 50, cos(m) * 30 + 1870, sin(m) * 30 + 50);
  strokeWeight(4);
  stroke(0);
  line(1870, 50, cos(h) * 20 + 1870, sin(h) * 20 + 50);
  if (hour()>11) { textSize(16); fill(0,0,255); text("PM",1870,65); } else { textSize(16); fill(0,0,255); text("AM",1870,65);}
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  fill(0);
  strokeWeight(1);
  rect(1820,1020,145,60);
  rect(1315,1020,500,60);
  ct=second()+minute()*60+hour()*3600-t;
  fill(255);
  noStroke();
  ellipse(x,y,30,30);
  textSize(30);
  text(nf(round((ct-ct%60)/60),2,0)+":"+nf(ct%60,2,0),1870,1045);
  textAlign(LEFT,CENTER);
  if (ct!=0) {text("Score/min: "+nf(score*60/ct,0,0),1300,1045);} else {text("Score/min: 0",1300,1045);}
  text("Score: "+score,1650,1045);
}

void mousePressed()
{
   if (sqrt(sq((mouseX-x))+sq((mouseY-y)))<=15) {score++; setup();}
}
