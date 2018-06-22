Branch branches[]=new Branch[2049];
float growRate[]={1.2,1.2,1.2,1.2,1.2,1.2,1.2};
int branchWidth[]={3,6,10,15,25,30,40};
int NoB=1;
public class vector{
  public int x1;
  public int y1;
  public int x2;
  public int y2;
}
vector root=new vector();

void setup(){
  size(1000,600);
  background(255);
  
  root.x1=500;
  root.x2=449;
  root.y1=0;
  root.y2=7;
  branches[1] = new Branch();
  branches[1].BranchMaker(false,root,0);
  for(int i=2;i<2049;i++)
   branches[i] = new Branch();
  
}

void draw(){
  background(255);
  displayBranches();
  if(NoB<1025) growTheTree(NoB);
  
}


public class Branch{
  public int generation;
  public int brake;
  public int motherId;
  public boolean leftOrRight; // ha igaz akkor jobbra megy
  public vector branchPartVectors[]=new vector[4];
  float brakeAngle[]=new float[4];
  float angle;
  float lenght;
  Branch(){
    generation=1;
    brake=int(random(2));
    motherId=1;
    leftOrRight=true;
    for(int i=1;i<=brake;i++){
    branchPartVectors[i]=new vector();
    }
  }
  void BranchMaker(boolean side, vector motherVector,int motherOfId){
    generation=1;
    motherId=motherOfId;
    leftOrRight=side;
    
    
    lenght=random(10,20)/(brake+1);
    if(side) {
     if(motherVector.y2-motherVector.y1!=0) angle=random(0.17,0.69)+atan((motherVector.x2-motherVector.x1)/(motherVector.y2-motherVector.y1));
     else angle=random(0.17,0.69);
     branchC(motherVector.x2,motherVector.y2);
    }
    if(!side) {
     if(motherVector.y2-motherVector.y1!=0) angle=random(-0.69,-0.17)+atan((motherVector.x2-motherVector.x1)/(motherVector.y2-motherVector.y1));
     else angle=random(-0.69,-0.17);
     for(int i=1;i<=brake;i++){
       if((branchPartVectors[i].y2-branchPartVectors[i].y1)!=0) brakeAngle[i]=random(-0.09,0.09)+atan((branchPartVectors[i].x2-branchPartVectors[i].x1)/(branchPartVectors[i].y2-branchPartVectors[i].y1));
       else brakeAngle[i]=random(-0.09,0.09);
     }
     branchC(motherVector.x2,motherVector.y2);
    }
  }
  void grow()
  {
    lenght=lenght*growRate[generation];
    generation++;
    branches[motherId]=new Branch();
    branches[motherId].branchPartVectors[branches[motherId].brake+1]=new vector();
    int newStartingPointX=branches[motherId].branchPartVectors[branches[motherId].brake+1].x2;
    int newStartingPointY=branches[motherId].branchPartVectors[branches[motherId].brake+1].y2;
    branchC(newStartingPointX,newStartingPointY);
     }
  
  void branchC(int startingPointX,int startingPointY){
    branchPartVectors[1]=new vector();
    branchPartVectors[1].x1=startingPointX;
     branchPartVectors[1].y1=startingPointY;
     branchPartVectors[1].x2=startingPointX+int(cos(angle)*lenght);
     branchPartVectors[1].y2=startingPointY+int(sin(angle)*lenght);
     for(int i=1;i<=brake;i++){
       if((branchPartVectors[i].y2-branchPartVectors[i].y1)!=0) brakeAngle[i]=random(-0.09,0.09)+atan((branchPartVectors[i].x2-branchPartVectors[i].x1)/(branchPartVectors[i].y2-branchPartVectors[i].y1));
       else brakeAngle[i]=random(-0.09,0.09);
       branchPartVectors[i]=new vector();
       branchPartVectors[i+1]=new vector();
       branchPartVectors[i+1].x1=branchPartVectors[i].x2;
       branchPartVectors[i+1].y1=branchPartVectors[i].y2;
       branchPartVectors[i+1].x2=branchPartVectors[i].x2+int(cos(brakeAngle[i])*lenght);
       branchPartVectors[i+1].y2=branchPartVectors[i].y2+int(sin(brakeAngle[i])*lenght);
    
  }
}
}

void growTheTree(int numberOfBranches){
  println("numberOfBranches " + numberOfBranches);
  for(int i=1;i<=numberOfBranches;i++){
    branches[i].grow(); 
    println("motherId " + branches[i].motherId);
  }
  for(int i=1;i<=numberOfBranches;i++){
    if(branches[i].generation==2){
     numberOfBranches++;
      
    branches[numberOfBranches].BranchMaker(true,branches[i].branchPartVectors[branches[i].brake+1],i);
    numberOfBranches++;
    
    branches[numberOfBranches].BranchMaker(false,branches[i].branchPartVectors[branches[i].brake+1],i);
    }
  }
  NoB=numberOfBranches;
}
void displayBranches(){
  stroke(139,69,19);
  for(int i=1;i<=NoB;i++){
    strokeWeight(branchWidth[branches[i].generation]);
    for(int j=1;j<=branches[i].brake;j++){
      line(parseFloat(branches[i].branchPartVectors[j].x1),parseFloat(branches[i].branchPartVectors[j].y1),parseFloat(branches[i].branchPartVectors[j].x2),parseFloat(branches[i].branchPartVectors[j].x2));
    }
  }
}
