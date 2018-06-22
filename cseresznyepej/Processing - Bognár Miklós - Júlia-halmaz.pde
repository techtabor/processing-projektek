import java.awt.Color;
float a = 0.7, b = 0.3;
int scale = 150;
int iterations = 600;
int offsetx, offsety;
void setup(){
  background(0);
 size(800, 600);
 render();
 text("WASD - mozgatás", 50, 50);
 text("SPACE - zoomolás (középre)", 50, 75);
}

void render(){
 for(int x = 0; x < width; x++){
  for(int y = 0; y < height; y++){
   set(x, y, (int)(calculate(((x-width/2f-offsetx)/scale), (y-height/2f-offsety)/scale)));
  }
 }
}

int calculate(float x, float y){
  float cx = x;
  float cy = y;
  int i=0;
  for(; i <iterations; i++){
   float nx = x*x - y*y -a;
   float ny = 2*x*y -b;
   if(nx*nx+ny*ny > 4)break;
   
   
   x = nx;
   y = ny;
  }
  if(i == iterations)return Color.HSBtoRGB(x/y, 0.7f, 0);
  return Color.HSBtoRGB((float)i*2/iterations, 0.7f, 1.2);
}

void draw(){
  
}

void keyPressed(){
 if(key == 'd'){
   offsetx -=10;
 }
 if(key == 'a'){
  offsetx +=10; 
 }
 if(key == 's'){
  offsety-=10; 
 }
 if(key=='w'){
  offsety+=10; 
 }
 
 if(key==' '){scale+=100;}
 render();
 
}