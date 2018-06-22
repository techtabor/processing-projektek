int x = 50;
int y = 50;
int irany=1;
int x2=600;
int y2=100;
int letezik;
int letezik2;
void setup()
{
  size (800, 800);  
  letezik = 1;
  letezik2=1;
} 
void draw()
{
  background(80);
  if (mov[0]) 
  {
    y-=5; 
    irany=1;
  }
  if (mov[1]) 
  {
    y+=5; 
    irany=2;
  }
  if (mov[2]) 
  {
    x-=5; 
    irany=3;
  }
  if (mov[3]) 
  {
    x+=5; 
    irany=4;
  }
  if (x<0) 
  {
    x=0;
  }
  if (x>775) 
  {
    x=775;
  }
  if (y<0) 
  {
    y=0;
  }
  if (y>775) 
  {
    y=775;
  }
  if (y<=200 && y>175 && x<400)
  {
    if (mov[0]) y=200;
    else if (mov[1]) y=175;
  } 
  if (y<=500 && y>475 && x>300 && x<800)
  {
    if (mov[0]) y=500;
    else if (mov[1]) y=475;
  }
  if (letezik == 1) 
  {
    rect(x2, y2, 25, 25);
  }
  if (letezik2 == 1)
  {
    rect(300,300, 25, 25);
  }
  rect(x, y, 25, 25);
  stroke(0,0,0);
  line(0, 200, 400, 200); 
  line(800, 500, 300, 500);
  if (mousePressed==true)
  {
    stroke(202,0,42);
    strokeWeight(1); 
    if (irany==1)
    {
      line(x+12.5, y, x+12.5, 0);
      if (x2<=x+12.5 && x + 12.5 <= x2+25 && y2<y) 
      {
        letezik = 0;
      }
    } else if (irany==2)
    {
      line(x+12.5, y+25, x+12.5, height-1);
      if (x2<=x+12.5 && x + 12.5 <= x2+25 && y2>y)
      {        
        letezik = 0;
      }
    } else if (irany==3)
    {
      line(x, y+12.5, 0, y+12.5);
      if (y2<=y+12.5 && y + 12.5 <= y2+25 && x2<x)
      {        
        letezik = 0;
      }
    }else if (irany==4)
    {
      line(x+25, y+12.5, width-1, y+12.5);
      if (y2<=y+12.5 && y + 12.5 <= y2+25 && x2>x)
      {        
        letezik = 0;
      }
    }
    if(irany==1) {
      line(x+12.5, y, x+12.5, 0);
      if (x2<=x+12.5 && x + 12.5 <= x2+25 && y2<y) 
      {
        letezik2 =0;
      }
    } else if (irany==2)
    {
      line(x+12.5, y+25, x+12.5, height-1);
      if (x2<=x+12.5 && x + 12.5 <= x2+25 && y2>y)
      {        
        letezik2 =0;
      }
    } else if (irany==3)
    {
      line(x, y+12.5, 0, y+12.5);
      if (y2<=y+12.5 && y + 12.5 <= y2+25 && x2<x)
      {        
        letezik2 =0;
      }
    } else if (irany==4)
    {
      line(x+25, y+12.5, width-1, y+12.5);
      if (y2<=y+12.5 && y + 12.5 <= y2+25 && x2>x)
      {        
        letezik2 =0;
      }
    }
  }
}

boolean mov[] = new boolean[4];
void keyPressed() 
{
  if (key == CODED) 
  {
    if (keyCode == UP) 
    {
      mov[0] = true;
    } else if (keyCode == DOWN) 
    {
      mov[1] = true;
    } else if (keyCode == LEFT) 
    {
      mov[2] = true;
    } else if (keyCode == RIGHT) 
    {
      mov[3] = true;
    }
  }
}
void keyReleased() 
{
  if (key == CODED) 
  {
    if (keyCode == UP) 
    {
      mov[0] = false;
    } else if (keyCode == DOWN) 
    {
      mov[1] = false;
    } else if (keyCode == LEFT) 
    {
      mov[2] = false;
    } else if (keyCode == RIGHT) 
    {
      mov[3] = false;
    }
  }
}
