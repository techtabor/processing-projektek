boolean[][] bomba= new boolean[8][8];
boolean[][] lenyomva= new boolean[8][8];
boolean[][] zaszlo= new boolean[8][8];
boolean[][] beszinezett= new boolean[8][8];
boolean kezdes=false;
int bombaszam=0;
int lenyomott=0;
int deathTimer=-1;
int winTimer=-2;

void setup() 
{
  surface.setTitle("Aknakereső");
  size (800, 900);
  background(169);
  noFill();
  rect(200,300,400,200);
  textSize (120);
  textAlign (CENTER, CENTER);
  fill(0);
  text("START",400,400);
  textSize(20);

  if (mouseX<=600 && mouseX>=200 && mouseY<=500 && mouseY>=300)
  { 
    for (int i=0; i<=7; i++)
    {
      for (int j=0; j<=7; j++)
      {
        fill(144);
        rect(i*100+5, j*100+5, 90, 90);
        bomba [i][j]= randombool();
        zaszlo[i][j]=false;
        if (bomba [i][j] == true)
          bombaszam++;
        lenyomva[i][j]=false;
        
      }
    }
  }
  fill(0);
}

void mousePressed()
{
  if (mouseX<=790 && mouseX>=710 && mouseY<=890 && mouseY>=810)
  {
    kezdes=false;
    background(169);
    noFill();
    rect(200,300,400,200);
    textSize (120);
    textAlign (CENTER, CENTER);
    fill(0);
    text("START",400,400);
    textSize(20);
  }
  if (winTimer<0 && deathTimer<0)
    {
      if (kezdes==false)
      {
        if (mouseX<=600 && mouseX>=200 && mouseY<=500 && mouseY>=300)
        {
          background(169);
          fill(144);
          for (int i=0; i<=7; i++)
          {
            for (int j=0; j<=7; j++)
            {
              rect(i*100+5, j*100+5, 90, 90);
              bomba [i][j]= randombool();
              if (bomba [i][j] == true)
              bombaszam++;
              lenyomva[i][j]=false;
              beszinezett[i][j]=false;
              zaszlo[i][j]=false;
            }
          }
          kezdes=true;
          noFill();
          rect(710, 810, 80, 80);
          fill(0);
          text("R", 750, 850);
        }
      }
   else 
   {
     for (int i=0; i<=7; i++)
        {
          for (int j=0; j<=7; j++)
          {
            if (mouseX<=i*100+95 && mouseX>=i*100+5 && mouseY<=j*100+95 && mouseY>=j*100+5)
            {
              if (bomba[i][j]==true)
              {
                fill(144);
                rect(i*100+5, j*100+5, 90, 90);
                fill(0);
                ellipse(i*100+50, j*100+50, 20, 20);
                fill(196);
                line(i*100+50, j*100+40, i*100+50, j*100+30);
                fill(255,0,0);
                ellipse(i*100+50, j*100+30, 5, 5);
                deathTimer = 120;
              }
              else
              {
                
                if (lenyomva[i][j]==false)
                {
                  lenyomott++;
                  fill(144);
                  rect(i*100+5, j*100+5, 90, 90);
                }
                lenyomva[i][j]=true;
                zaszlo[i][j]=false; 
              }
            }
          }
        }
        if (lenyomott+bombaszam==64)
        {
          winTimer=180;
        }
    }
  }
}

void  keyPressed()
{
  for (int i=0; i<=7; i++)
    {
      for (int j=0; j<=7; j++)
      {
        if (mouseX<=i*100+95 && mouseX>=i*100+5 && mouseY<=j*100+95 && mouseY>=j*100+5)
        {
          if(lenyomva[i][j]==false)
          {
            if(zaszlo[i][j]==false)
            {            
              line(i*100+50, j*100+20, i*100+50, j*100+80);
              triangle(i*100+50, j*100+65, i*100+25, j*100+80, i*100+75, j*100+80);
              fill(255,0,0);
              triangle(i*100+50, j*100+20, i*100+50, j*100+50, i*100+15, j*100+35);
              zaszlo[i][j]=true;
            }
            else
            {
           fill(144);
           rect(i*100+5, j*100+5, 90, 90);
           zaszlo[i][j]=false;         
            }
           }
        }
      }
    }


}

void draw()
{
  if(kezdes==true)
  {
    if (deathTimer > 0)
    {
      textSize(100);
      text("BUMMMMMMM\n"+"Vesztettél", 400, 400);
      deathTimer--;
    }
    if (deathTimer == 0)
    {
      exit();
    }
    
    if (winTimer > 0)
    {
      textSize(200);
      text("Iziwin", 400, 400);
      winTimer--;
    }
    if (winTimer == 0)
    {
      exit();
    } 
    
    for (int i=0; i<=7; i++)
    {
      for (int j=0; j<=7; j++)
      {
        if(lenyomva[i][j]==true)
        {
          textSize(20);       
          if (korbebomba(i, j)==0)
            {
              kiurito(i, j);
              if(beszinezett[i][j]==false)
              { 
                fill(169);
                rect(i*100+5, j*100+5, 90, 90);
                fill(0);
                beszinezett[i][j]=true;
              }  
            }
          
        }
      }
    } 
    fill(0);
  }
}

boolean randombool()
{
  float r= random(1);
  if (r<=0.125)
    return true;
  else
    return false;
}

int korbebomba(int i, int j)
{
  if (zaszlo[i][j]==true)
  {
    fill(144);
    rect(i*100+5, j*100+5, 90, 90);
    zaszlo[i][j]=false;
  }
  
  int korbebomba=0;
  for (int k=(i-1+abs(i-1))/2; k<=-(abs(i-6.5))+7.5; k++)
    for (int l=(j-1+abs(j-1))/2; l<=-(abs(j-6.5))+7.5; l++)
      if (bomba[k][l]==true)
        korbebomba++;
  
  if(korbebomba!=0)
  text(korbebomba, 100*i+50, 100*j+50);
  return korbebomba;
}


void kiurito (int i, int j)
{
  for (int k=(i-1+abs(i-1))/2; k<=-(abs(i-6.5))+7.5; k++)
    for (int l=(j-1+abs(j-1))/2; l<=-(abs(j-6.5))+7.5; l++)
      if (lenyomva[k][l]==false)
      {
        lenyomott++;
        lenyomva[k][l]=true;
        if (korbebomba(k, l)==0)
        kiurito(k,l);
      }
}
