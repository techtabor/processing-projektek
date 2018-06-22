/*********
processing
*********/
int N = 10;
int side = 50;
float p = 0.35;
boolean mines[][];
boolean exposed[][];
boolean select[][];
boolean elindult=false;
boolean end = true;
float ver =0.56;

int s_b=0, m=0, h=0;
float s=0;
String a,b,c;

void setup() {
  size(N*side+1+4*side,N*side+1);
  
  fill(255);
  mines = new boolean[N][N];
  exposed = new boolean[N][N];
  select= new boolean[N][N];
  
  for (int i=0; i < N; i++) for (int j=0; j < N; j++)  {
    mines[i][j] =  (random(0,1) < p);
    exposed[i][j] = false;
  }
  for (int i=0; i < N; i++) for (int j=0; j < N; j++)  {
    rect(i*side,j*side,(i+1)*side,(j+1)*side);
    select[i][j]  = false; 
}

fill(0,255,0);
  rect(N*side,0,4*side,N*side);
  fill(255,0,0);
  textSize(16);
  text("Aknakereső v."+ver,N*side+side-20,20);
}
boolean done() {
  for (int i=0; i < N; i++) for (int j=0; j < N; j++) {
    if (exposed[i][j] == false && mines[i][j] == false) return(false);
  }
  return(true);
}

void mousePressed() {
  if(end){
  int i = mouseX/side;
  int j = mouseY/side;
  println("x=",i);
  println("y=",j);
  println("--------");
  if(i<=N-1){
    if(mouseButton == LEFT && select[i][j]==false){
    elindult=true;
    exposed[i][j] = true;
    fill(137);
    rect(i*side,j*side,side,side);
    textAlign(CENTER,CENTER);
    
    if (mines[i][j]) {
      println("Vesztettél");
      fill(199,0,0);
      rect(i*side,j*side,side,side);
      end=false;
       textAlign(CENTER,CENTER);
       textSize(100);
      fill(255,0,0);
      text("Vesztettél",(N*side+1+4*side)/2,N*side/2);
    }
    else number(i,j);
    if (done()) { println("Nyertél");
      textSize(100);
      textAlign(CENTER,CENTER);
      fill(255,0,0);
      text("Nyertél",(N*side+1+4*side)/2,N*side/2);
      end=false; }
    }
    else if(mouseButton == RIGHT){
      if(elindult && exposed[i][j]==false ){
      if(select[i][j]==false){
      select[i][j]=true;
      fill(0,0,255);
      rect(i*side,j*side,side,side);
      println(select[i][j]);
    if(mines[i][j]){println("Jó tipp");}
    else{println("EZ félre ment");}
      }
      else if(select[i][j]==true){
           select[i][j]=false;
           println(select[i][j]);
           fill(255);
            rect(i*side,j*side,side,side);
           } 
         }
  }
   }  
}
}

int neighbor(int i, int j) {
  int t=0;
  for (int ii=i-1; ii <= i+1; ii++) {
    if (ii < 0 || ii >= N) continue;
    for (int jj = j-1; jj <= j+1; jj++) {
      if (jj < 0 || jj >= N) continue;
      if (mines[ii][jj]) t++;
    }
  }
  return(t);
}

void number(int i, int j) {
  int n;
  char c[] = new char[1];
  
  
  n = neighbor(i,j);
  c[0] = char('0' + n);
  println(c[0]);
  switch(c[0]){
    case '0' : fill(255,126,241);break;
    case '1' : fill(18,23,204);break;
    case '2' : fill(74,234,58);break;
    case '3' : fill(252,0,0);break;
    case '4' : fill(0,10,127);break;
    case '5' : fill(127,51,51);break;
    case '6' : fill(245,181,181);break;
    case '7' : fill(248,255,60);break;
    case '8' : fill(126,253,255);break;
    default : println("Hát eez nem jó ha lefut");break;}
  textSize(28);
  text(new String(c),i*side+side/2,j*side+side/2);


}

void draw() {
  if(elindult){
    delay(100);
    s++;
    //if(s>=10){s=s/10;}
    fill(0,255,0);
    rect(N*side,0,4*side,N*side);
    fill(255,0,0);
    textSize(16);
    text("Aknakereső v."+ver,N*side+side+45,10);
    println(s);
    s_b=int(s/10);
  if(s_b>=60){
    s=0;
    m++;
  }
  if(m>=60){
    m=0;
    h++;
  }
  if(h>=24){exit();}
  c=nf(s_b,2);
  b=nf(m,2);
  a=nf(h,2);
  String time=a+":"+b+":"+c;
    fill(255);
    textSize(24);
    text(time,N*side+side+45,100);
    if(end==false){delay(100000);}
}  
}

