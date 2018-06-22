boolean win=false;
boolean lose=false;

int stilesX=10,tilesX;
int stilesY=10,tilesY;
int stileSize=30,tileSize;
int sbombs=10,bombs;
int discovered=0;
int sflagged=0,flagged;
int sec=0;
int lsec=second();

void reset()
{
  tilesX=stilesX;
  tilesY=stilesY;
  tileSize=stileSize;
  bombs=sbombs;
  sec=0;
  discovered=0;
  flagged=0;
  lose=false;
  win=false;
}

Tile[][] tiles = new Tile[stilesX][stilesY];

void setup()
{
  size(300,400);
  reset();
  if(bombs>=tilesX*tilesY) bombs=tilesX*tilesY-1;
  for(int i=0; i<tilesX; ++i)
  {
   for(int j=0; j<tilesY; ++j)
   {
    tiles[i][j] = new Tile(i*tileSize,j*tileSize); 
   }
  }
  for(int i=0; i<bombs; ++i)
  {
    int x,y;
    do
    {
      x=(int)random(tilesX);
      y=(int)random(tilesY);
    }while(tiles[x][y].bomb);
    tiles[x][y].bomb=true;
  }
  for (int i = 0; i< tilesX; i++) {
    for (int j = 0; j< tilesY; j++) {
      if (i > 0 && tiles[i-1][j].bomb) tiles[i][j].bombsnear++;
      if (i < tilesX-1 && tiles[i+1][j].bomb) tiles[i][j].bombsnear++;
      if (i > 0 && j > 0 &&  tiles[i-1][j-1].bomb) tiles[i][j].bombsnear++;
      if (i < tilesX-1 &&j > 0 &&  tiles[i+1][j-1].bomb) tiles[i][j].bombsnear++;
      if (i > 0 && j < tilesY-1 &&  tiles[i-1][j+1].bomb) tiles[i][j].bombsnear++;
      if (i < tilesX-1 &&j < tilesY-1 &&  tiles[i+1][j+1].bomb) tiles[i][j].bombsnear++;
      if (j < tilesY-1 && tiles[i][j+1].bomb) tiles[i][j].bombsnear++;
      if (j > 0 &&  tiles[i][j-1].bomb) tiles[i][j].bombsnear++;
    }
  }
}

void draw()
{
  background(255);
  frameRate(300);
  if(lsec!=second() && (!win && !lose))
  {
   lsec=second();
   ++sec;
  }
  for(int i=0; i<tilesX; ++i)
  {
   for(int j=0; j<tilesY; ++j)
   {
     if(tiles[i][j].bombsnear==0 && !tiles[i][j].bomb && !tiles[i][j].hidden && !tiles[i][j].flagged) calcZeros(i,j);
    tiles[i][j].Show(); 
   }
  }
  if(discovered+bombs==tilesX*tilesY && bombs==flagged)
  {
    for(int i=0; i<tilesX; ++i)
   {
    for(int j=0; j<tilesY; ++j)
    {
     tiles[i][j].Show();
    }
   }
   fill(255,90);
   rect(0,0,width,height);
   win=true;
   textSize(sqrt(width*height)/3);
   fill(0);
   text("Win",25,sqrt(width*height)/3);
  }
  if(lose)
  {
   for(int i=0; i<tilesX; ++i)
   {
    for(int j=0; j<tilesY; ++j)
    {
     if(tiles[i][j].bomb) tiles[i][j].hidden=false;
     tiles[i][j].Show();
    }
   }
   fill(255,90);
   rect(0,0,width,height);
   fill(255,0,0);
   textSize(sqrt(width*height)/3);
   text("LOSE",25,sqrt(width*height)/3);
  }
  fill(64);
  rect(width/2-37,height-87,75,75);
  textSize(20);
  fill(255);
  text("Restart",width/2-35,height-40);
  String stat="Mezők\nfelfedezve\n"+discovered+"/"+(tilesX*tilesY-bombs);
  fill(0);
  text(stat,0,height-75);
  String flags="Zászlók\nhátra:"+flagged+"/"+bombs+"\nIdő:"+sec+"mp";
  text(flags,width/2+40,height-75);
}

void mousePressed()
{
  int x=mouseX/tileSize, y=mouseY/tileSize;
  if(x>=tilesX || y>=tilesY)
  {
    if(mouseX>=width/2-37 && mouseX<=width/2+38 && mouseY>=height-87 && mouseY<=height-12)
    {
     reset(); 
     setup();
    }
  }
  else if(tiles[x][y].hidden || tiles[x][y].flagged)
  {
    tiles[x][y].hidden=false;
  if(mouseButton == LEFT)
  {
   if(tiles[x][y].bomb && !tiles[x][y].flagged)
   {
    lose=true; 
   }
   else if(!tiles[x][y].flagged)
   {
    ++discovered;
   }
  }
  else
  {
   if(tiles[x][y].flagged)
   {
     tiles[x][y].flagged=false;
     tiles[x][y].hidden=true;
--flagged;
   }
   else if(flagged<bombs)
   {
     tiles[x][y].flagged=true;
++flagged;
   }
  }
  }
}

void calcZeros(int i, int j)
{
  if(i>0 && !tiles[i-1][j].bomb && tiles[i-1][j].hidden)
  {
   tiles[i-1][j].hidden=false;
   ++discovered;
  }
  if(i<tilesX-1 && !tiles[i+1][j].bomb && tiles[i+1][j].hidden)
  {
   tiles[i+1][j].hidden=false;
   ++discovered;
  }
  if(j>0 && !tiles[i][j-1].bomb && tiles[i][j-1].hidden)
  {
   tiles[i][j-1].hidden=false;
   ++discovered;
  }
  if(j<tilesY-1 && !tiles[i][j+1].bomb && tiles[i][j+1].hidden)
  {
   tiles[i][j+1].hidden=false;
   ++discovered;
  }
  if(i>0 && j>0 && !tiles[i-1][j-1].bomb && tiles[i-1][j-1].hidden)
  {
   tiles[i-1][j-1].hidden=false;
   ++discovered;
  }
  if(i<tilesX-1 && j<tilesY-1 && !tiles[i+1][j+1].bomb && tiles[i+1][j+1].hidden)
  {
   tiles[i+1][j+1].hidden=false;
   ++discovered;
  }
  if(i>0 && j<tilesY-1 && !tiles[i-1][j+1].bomb && tiles[i-1][j+1].hidden)
  {
   tiles[i-1][j+1].hidden=false;
   ++discovered;
  }
  if(i<tilesX-1 && j>0 && !tiles[i+1][j-1].bomb && tiles[i+1][j-1].hidden)
  {
   tiles[i+1][j-1].hidden=false;
   ++discovered;
  }
}

class Tile
{
 int x, y, bombsnear=0, hiddennear=8;
 boolean bomb=false;
 boolean flagged=false;
 boolean hidden=true;
 Tile(int a, int b)
 {
   x=a;
   y=b;
 }
 void Show()
 {
  fill(128);
  stroke(192);
  textSize(tileSize*2/3);
  rect(x,y,tileSize,tileSize);
  if(!hidden)
  {
    if(flagged)
    {
      fill(200,0,0);
     text("F",x+tileSize/3,y+tileSize*2/3);
    }
    else if(bomb || (lose && bomb))
    {
      fill(0);
     text("B",x+tileSize/3,y+tileSize*2/3); 
    }
     else
     {
       if(bombsnear>0)
       {
         fill(0,255,0);
        text(bombsnear,x+tileSize/3,y+tileSize*2/3); 
       }
       else
       {
         fill(150);
         stroke(100);
        rect(x,y,tileSize,tileSize);
       }
     }
    }
  }
}
