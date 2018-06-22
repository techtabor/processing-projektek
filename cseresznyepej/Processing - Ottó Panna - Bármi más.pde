class Ellipse{
  int x;
  int y;
  Ellipse (int x1, int y1){
    x = x1;
    y = y1;
  }
  int top(){
    return y - 50;
  }
  int bot(){
    return y + 50;
  }
  int left(){
    return x - 50;
  }
  int right(){
    return x + 50;
  }
  int X(){
    return x;
  }
  int Y(){
    return y;
  }
}

ArrayList<Ellipse> players = new ArrayList<Ellipse>();

void setup(){
  size(800,800);
  players.add(new Ellipse(750,50));
  players.add(new Ellipse(650,50));
  players.add(new Ellipse(750,150));
  
}

void draw(){
  background(255);
   for (int y = height; y > -100; y = y - 100){
    for (int x = width; x > -100; x = x - 100){
      noStroke();
      fill(225);
      rect(x,y,100,100);
      x = x - 100;
      fill(0);
      rect(x,y,100,100);
    }
    y = y - 100;
    for (int x = width; x > -100; x = x - 100){
      fill(0);
      rect(x,y,100,100);
      x = x - 100;
      fill(255);
      rect(x,y,100,100);
    }
  }
  stroke(0,255,0);
  strokeWeight(10);
  line(800,0,800,200);
  line(800,0,600,0);
  line(800,200,700,200);
  line(600,0,600,100);
  line(700,200,700,100);
  line(600,100,700,100);
  for (int i = players.size()-1; i > -1; i = i - 1){
    fill(255,0,0);
    stroke(255,0,0);
    ellipse(players.get(i).x,players.get(i).y,50,50);
  }
}

void mousePressed(){
  int xMouse = mouseX;
  int yMouse = mouseY;
  int listnum = 0;
  for (int i = players.size()-1; i > -1; i = i - 1){
    if ((players.get(i).right() > xMouse) && (xMouse > players.get(i).left()) && (players.get(i).bot() > yMouse) && (yMouse > players.get(i).top())){
      for (int k = players.size()-1; k > -1; k = k - 1){
        if(((players.get(k).x) == (players.get(i).x-100) && (players.get(k).y) == (players.get(i).y)) || ((players.get(k).y) == (players.get(i).y+100) && (players.get(k).x) == (players.get(i).x))){
          listnum = listnum + 1;
        }
      }
      if(listnum == 0){
          players.add(new Ellipse(players.get(i).x-100,players.get(i).y));
          players.add(new Ellipse(players.get(i).x,players.get(i).y+100));
          players.remove(i);
          return;
      }
    }
  }
}
