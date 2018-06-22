int ArectX = 42;    
int BrectX = 30;    //2 - vel oszthato kell legyen!!!
int ABrectY = 42;   //3 - mal oszthato kell legyen!!!
int Aspace = 10;
int Bspace = 10;
int ABshape = 7;

int BYspace = 4;

int AXCoords[][] = {{0,0},{0,0},{0,0},{0,0},{0,0}};
int ABYCoords[] = {0,0};
int BXCoords[] = {0,0};

int trashX = 35;
int trashY = 35;


int selectedItem = 0;
int red = 255;
int green = 255;
int blue = 255;
int S = 0;
int G = 0;


void setup()
{
  size(700,500);
  background(255);
  
  //calculating rects Coords
  
  //Y
  ABYCoords[0] = trashY;
  ABYCoords[1] = trashY + ABrectY;
  
  int first = 0;
  int second = 0;
  
  //AX
  for(int j = 0; j < 10; j++){
    AXCoords[first][second] = trashX;
    if(j%2 == 0){
      trashX = trashX + ArectX;
    }else{
      trashX = trashX + Aspace;
    }
    
    if(j%2 == 1){
      second = 0;
      first++;
    } else{
      second = 1;
    }
  }
  
  //BX
  trashX = trashX + Bspace;
  for(int j = 0; j < 2; j++){BXCoords[j] = trashX; trashX = trashX + 4*Bspace + 3*BrectX;}
  
}


boolean mouseMenu(int minX, int maxX, int minY, int maxY)
{
  boolean Mc = mousePressed == true;
  boolean MouseMenuResult = mouseX > minX && mouseX < maxX && mouseY > minY && mouseY < maxY && Mc;
  return MouseMenuResult;
}


void backgroundMenuRGB(int xCoord,int yCoord){
  strokeWeight(1);
  int W = 0;
  int Vertical = ABrectY/3;
  int SmallBXCoords[][][] = {{{0,0},{0,0},{0,0}},{{0,0},{0,0},{0,0}},{{0,0},{0,0},{0,0}}};
  int SmallBYCoords[][][] = {{{0,0},{0,0},{0,0}},{{0,0},{0,0},{0,0}},{{0,0},{0,0},{0,0}}};
  for(int j = 0; j < 3; j++){
     W = W + Bspace;
     
     SmallBXCoords[j][0][0] = W + xCoord + 1;
     SmallBXCoords[j][0][1] = W + BrectX + xCoord - 1;
     SmallBXCoords[j][1][0] = W + xCoord;
     SmallBXCoords[j][1][1] = W + xCoord + BrectX;
     SmallBXCoords[j][2][0] = W + xCoord + 1;
     SmallBXCoords[j][2][1] = W + (BrectX/2) + xCoord;
     
     SmallBYCoords[j][0][0] = ABYCoords[0] + Vertical - BYspace;
     SmallBYCoords[j][0][1] = ABYCoords[0] + BYspace;
     SmallBYCoords[j][1][0] = ABYCoords[0] + Vertical;
     SmallBYCoords[j][1][1] = ABYCoords[0] + 2*Vertical;
     SmallBYCoords[j][2][0] = ABYCoords[0] + 2*Vertical + BYspace;
     SmallBYCoords[j][2][1] = ABYCoords[0] + 3*Vertical - BYspace;
     
     triangle(SmallBXCoords[j][0][0], SmallBYCoords[j][0][0], SmallBXCoords[j][0][1], SmallBYCoords[j][0][0], SmallBXCoords[j][2][1], SmallBYCoords[j][0][1]);
     rect(SmallBXCoords[j][1][0],SmallBYCoords[j][1][0],BrectX,Vertical);
     triangle(SmallBXCoords[j][2][0], SmallBYCoords[j][2][0], SmallBXCoords[j][0][1], SmallBYCoords[j][2][0], SmallBXCoords[j][2][1], SmallBYCoords[j][2][1]);
     W = W + BrectX;
  }
  //ellenorzes
  
}

void backgroundMenu()
{ 
  clear();
  color[] colors = {#00ffdc,#009984,#00d4b7,#32ff8a,#94ffff};
  
  if(selectedItem == 5){
    background(red,green,blue);
  } else{
    background(colors[selectedItem]);
  }
  
  for(int i = 0; i < 6; i++){
    strokeWeight(1);
    if(i == selectedItem){
      strokeWeight(2);
      stroke(#000000);
    }
    
    switch(i){
      case 0:fill(colors[0]);break;
      case 1:fill(colors[1]);break;
      case 2:fill(colors[2]);break;
      case 3:fill(colors[3]);break;
      case 4:fill(colors[4]);break;
      case 5:noFill();
    }
    
    if(i == 5){
      rect(BXCoords[0],ABYCoords[0],4*Bspace + 3*BrectX,ABrectY,ABshape);
      backgroundMenuRGB(BXCoords[0],ABYCoords[0]);
    } else{
      rect(AXCoords[i][0],ABYCoords[0],ArectX,ABrectY,ABshape);
    }
  }
  if(mouseMenu(AXCoords[0][0],AXCoords[0][1],ABYCoords[0],ABYCoords[1])){
    selectedItem = 0; 
  } else if(mouseMenu(AXCoords[1][0],AXCoords[1][1],ABYCoords[0],ABYCoords[1])){
    selectedItem = 1;
  } else if(mouseMenu(AXCoords[2][0],AXCoords[2][1],ABYCoords[0],ABYCoords[1])){
    selectedItem = 2; 
  } else if(mouseMenu(AXCoords[3][0],AXCoords[3][1],ABYCoords[0],ABYCoords[1])){
    selectedItem = 3;
  } else if(mouseMenu(AXCoords[4][0],AXCoords[4][1],ABYCoords[0],ABYCoords[1])){
    selectedItem = 4; 
  } else if(mouseMenu(BXCoords[0],BXCoords[1],ABYCoords[0],ABYCoords[1])){
    selectedItem = 5; 
  }
}

void clock(int X, int Y,int radius){
  stroke(255);
  strokeWeight(3);
  ellipse(X,Y,radius,radius);
  
  translate(X,Y);
  rotate(second()*6/57.3);
  line(0,0,0,0-(radius/2-5));
  rotate(second()*6/57.3*(-1));
  rotate(minute()*6/57.3);
  line(0,0,0,0-(radius/2-20));
  rotate(minute()*6/57.3*(-1));
  rotate(hour()*30/57.3);
  line(0,0,0,0-(radius/2-50));
}

void draw(){
  backgroundMenu();
  clock(200,270,200);
}
