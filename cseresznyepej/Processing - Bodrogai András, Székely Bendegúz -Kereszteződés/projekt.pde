int [][] position=new int[4][3];
int k;
int [][] v=new int[4][2];
int ido;
int [] idok=new int[4];
void first(){
  position[0][0]=int(322.5);
  position[0][1]=601;
  delay();
  idok[0]=ido;
  v[0][0]=int(random(-5,-1));
  v[0][1]=v[0][0];
  mcar[0]=int(random(0,4));
}
void secondd(){
  position[1][0]=int(322.5);
  position[1][1]=-61;
  delay();
  idok[1]=ido;
   v[1][0]=int(random(1,5));
   v[1][1]=v[1][0];
  mcar[1]=int(random(0,4));
}
void third(){
  position[2][0]=int(247.5);
  position[2][1]=-61;
  delay();
  idok[2]=ido;
   v[2][0]=int(random(1,5));
   v[2][1]=v[2][0];
  mcar[2]=int(random(0,4));
}
void fourth(){
  position[3][0]=int(247.5);
  position[3][1]=600;
  delay();
  idok[3]=ido;
  v[3][0]=int(random(-5,-1));
  v[3][1]=v[3][0];
  mcar[3]=int(random(0,4));
}

void delay(){
  ido=minute()*60+second()+int(random(0,3));
  
}

void initialize(){
  first();
  secondd();
  third();
  fourth();
}

PImage[][] car=new PImage[4][4];
int[] mcar=new int[4];
void setup(){
  size(600,600);
  initialize();
  car[0][0]=loadImage("fel.png");
  car[1][0]=loadImage("jobb.png");
  car[2][0]=loadImage("le.png");
  car[3][0]=loadImage("balra.png");
  car[0][1]=loadImage("fel2.png");
  car[1][1]=loadImage("jobb2.png");
  car[2][1]=loadImage("le2.png");
  car[3][1]=loadImage("balra2.png");
  car[0][2]=loadImage("policeup.png");
  car[1][2]=loadImage("policeright.png");
  car[2][2]=loadImage("policedown.png");
  car[3][2]=loadImage("police.png");
  car[0][3]=loadImage("fel3.png");
  car[1][3]=loadImage("balra3.png");
  car[2][3]=loadImage("le3.png");
  car[3][3]=loadImage("jobb3.png");
  
}

void hatter(){
  background(40,255,40);
  fill(255);
  stroke(0);
  rect(225,0,150,600);
  rect(0,225,600,150);
  stroke(255);
  line(226,0,374,0);
  line(226,225,374,225);
  line(226,375,374,375);
  line(0,226,0,374);
}

void car(){
  stroke(0);
  fill(150,150,150);
  rect(0,0,60,60);
  
}

void egyenes(){
  position[k][1]+=v[k][0];
}

void dugo(){
  if (v[1][0]==0 && v[2][0]==0 && v[3][0]==0 && v[0][0]==0){
    v[0][0]=v[0][1];
    
  }
  
}

void draw(){
  hatter();
  pushMatrix();
  translate(position[0][0],position[0][1]);
  image(car[0][mcar[0]],0,0);
  if(position[0][1]<=380 && position[0][1]>=375){if((position[3][1]<=450&&position[3][1]>=240)||(position[1][1]>165 && position[1][1]<375)){v[0][0]=0;}else{v[0][0]=v[0][1];}}
  dugo();
  if(position[0][1]>-59 && minute()*60+second()>idok[0]){k=0;egyenes();}else {if(position[0][1]!=601) {first();}}
  popMatrix();
  
  pushMatrix();
  translate(position[1][1],position[1][0]);
  image(car[1][mcar[1]],0,0);
  if(position[1][1]>=160 && position[1][1]<=165){if(position[0][1]<=450 && position[0][1]>=240||(position[2][1]>165 && position[2][1]<375)){v[1][0]=0;}else{v[1][0]=v[1][1];}}
  dugo();
  if(position[1][1]<600 && minute()*60+second()>idok[1]){k=1;egyenes();}else {if(position[1][1]!=-61) {secondd();}}
  popMatrix();
  
  pushMatrix();
  translate(position[2][0],position[2][1]);
  image(car[2][mcar[2]],0,0);
  if(position[2][1]>=160 && position[2][1]<=165){if(position[1][1]<=300 && position[1][1]>=90||(position[3][1]>165 && position[3][1]<375)){v[2][0]=0;}else{v[2][0]=v[2][1];}}
  dugo();
  if(position[2][1]<600 && minute()*60+second()>idok[2]){k=2;egyenes();}else {if(position[2][1]!=-61) {third();}}
  popMatrix();
  
   pushMatrix();
  translate(position[3][1],position[3][0]);
  image(car[3][mcar[3]],0,0);
  if(position[3][1]>=375 && position[3][1]<=380){if(position[2][1]<=300 && position[2][1]>=90||(position[0][1]>165 && position[0][1]<375)){v[3][0]=0;}else{v[3][0]=v[3][1];}}
  dugo();
  if(position[3][1]>-60 && minute()*60+second()>idok[3]){k=3;egyenes();}else {if(position[3][1]!=600) {fourth();}}
  popMatrix();
  
}
