int mode = 1;
int prevmouseX = 0;
int prevmouseY = 0;
int r = 0;
int g = 0;
int b = 0;
int rr = 255;
int gg = 255;
int bb = 255;
boolean linestart = true;
boolean rectstart = true;
boolean ellipsestart = true;

void setup()
{
	//KEZELŐFELÜLET
  size (1000,600);
  background(0);
	fill(255);
	rect(0,0,width,height); 
	line(0,height/10,width,height/10);
	
	rect(0,0,height/10,height/10); //pencilbutton
	rect(height/10,0,height/10,height/10);//linetoolbutton
	rect(2*height/10,0,height/10,height/10);//rectbutton
	rect(3*height/10,0,height/10,height/10);//ellipsebutton
	rect(4*height/10,0,height/10,height/10);//reset
	
	strokeWeight(8);
	point(height/20,height/20);
	strokeWeight(5);
	line(height/10+height/40,height/40,height/10+3*height/40,3*height/40);
	strokeWeight(3);
	rect(2*height/10+height/40,height/40,height/20,height/20);
	ellipse(3.5*height/10,height/20,height/18,height/18);
	textAlign(CENTER,CENTER); textSize(20); fill(0); text("ÚJ",4.5*height/10,height/20);//ikonok
	
	strokeWeight(1);
	noFill();
	rect(0,height-20,110,40);//koordinátadoboz
	
	
	strokeWeight(1); stroke(1);//színválasztódobozk
	for(int i=1; i<=2; i++)
	{
		for(int j=4; j>=1; j--)
		{
			if (i == 1 && (j == 2 || j == 4)) fill(255,0,0);
			if (i == 1 && (j == 1 || j == 3)) fill(0,255,0);
			if (i == 2 && (j == 1 || j == 3)) fill(0,0,0);
			if (i == 2 && (j == 2 || j == 4)) fill(0,0,255);
			rect(width-j*height/20,(i-1)*height/20,height/20,height/20);
		}
	}
	
}
void draw()
{
	fill(255); noStroke(); rectMode(CORNER);
	rect(1,height-19,100,35);
	fill(0); textAlign(LEFT,BOTTOM); textSize(16);
	text("Y: "+str(mouseY),55,height);
	text("X: "+str(mouseX),5,height);
	//if (mode == 3)
	//	recttool();
	//if (mode == 4)
	//	ellipsetool();
	
	//tollvastagság
	int sW =35;
	
	//színnövelés
	if (mousePressed)
	{
		if (mouseButton == LEFT)
		{
			if (inside(width-4*height/20,0,height/20,height/20)) r++;//piros1fel
			if (inside(width-3*height/20,0,height/20,height/20)) g++;//zold1fel
			if (inside(width-4*height/20,height/20,height/20,height/20))b++;//kek1fel
			if (inside(width-3*height/20,height/20,height/20,height/20)) {r = 0; g = 0; b = 0;}//fekete1
			if (inside(width-2*height/20,0,height/20,height/20)) rr++;;//piros2fel
			if (inside(width-1*height/20,0,height/20,height/20)) gg++;//zold2fel
			if (inside(width-2*height/20,height/20,height/20,height/20))bb++;//kek2fel
			if (inside(width-1*height/20,height/20,height/20,height/20)) {rr = 0; gg = 0; bb= 0;} ;//fekete2
			
			if(mode == 1 && inside(0,height/10,width,9*height/10))
			{
				 	strokeWeight(3); stroke(r,g,b);
					line(pmouseX,pmouseY,mouseX, mouseY);
				
					linestart = true;
					ellipsestart = true;
					rectstart = true;
			}
		}
		if(mouseButton == RIGHT)
		{
			if (inside(0,height/10+sW/2,width,9*height/10))
			{ //radír
				strokeWeight(sW); stroke(255);
				line(pmouseX,pmouseY,mouseX, mouseY);
			}
			if (inside(width-4*height/20,0,height/20,height/20)) r--;//pirosle
			if (inside(width-3*height/20,0,height/20,height/20)) g--;//zold1le
			if (inside(width-4*height/20,height/20,height/20,height/20)) b--;//kek1le
			if (inside(width-3*height/20,height/20,height/20,height/20)) {r = 255; g = 255; b= 255;}//feher1
			if (inside(width-2*height/20,0,height/20,height/20))rr--;//piros2le
			if (inside(width-1*height/20,0,height/20,height/20))gg--;//zold2le
			if (inside(width-2*height/20,height/20,height/20,height/20))bb--;//kek2le
			if (inside(width-1*height/20,height/20,height/20,height/20)) {rr = 255; gg = 255; bb= 255;}//feher2
		}
	}

	stroke(0); rectMode(CORNER); strokeWeight(1);
	fill(r,g,b); rect(width-4*height/10,0,height/10,height/10);
	fill(rr,gg,bb); rect(width-3*height/10,0,height/10,height/10);//színmutatók
	stroke(r,g,b);
	
}

void mouseClicked()
{
	if(mouseButton == LEFT)
	{
		//mode gombok
		if (inside(0,0,height/10,height/10))  mode = 1;
		if (inside(height/10,0,height/10,height/10)) mode = 2;
		if (inside(2*height/10,0,height/10,height/10)) mode = 3;
		if (inside(3*height/10,0,height/10,height/10)) mode = 4;
		if (inside(4*height/10,0,height/10,height/10)) {noStroke(); fill(255); rect(0,height/10+1,width,9*height/10);}
		
		//linetool
		if (mode == 2 && inside(0,height/10,width,9*height/10))
		{
			if(linestart) {prevmouseX = mouseX; prevmouseY = mouseY; linestart = false;}
			else {stroke(r,g,b); line(prevmouseX,prevmouseY,mouseX,mouseY); linestart = true;}
			
			ellipsestart = true;
			rectstart = true;
		}
		//recttool
		if (mode == 3 && inside(0,height/10,width,9*height/10))
		{
			stroke(r,g,b); fill(rr,gg,bb);
			if(rectstart) {prevmouseX = mouseX; prevmouseY = mouseY; rectstart = false;}
			else {rect(prevmouseX,prevmouseY,mouseX-prevmouseX,mouseY-prevmouseY); rectstart = true;}
			
			linestart = true;
			ellipsestart = true;
		}
		//ellipsetool
		if (mode == 4 && inside(0,height/10,width,9*height/10))
		{
			stroke(r,g,b); fill(rr,gg,bb);
			if(ellipsestart) {prevmouseX = mouseX; prevmouseY = mouseY; strokeWeight(5); point(mouseX, mouseY); ellipsestart = false;}
			else 
			if(height/10 < prevmouseY - sqrt(sq(prevmouseX-mouseX)+sq(prevmouseY-mouseY)))
			{ellipse(prevmouseX,prevmouseY,sqrt(sq(prevmouseX-mouseX)+sq(prevmouseY-mouseY))*2,sqrt(sq(prevmouseX-mouseX)+sq(prevmouseY-mouseY))*2); ellipsestart = true;}
			
			rectstart = true;
			linestart = true;
		}
	}

}
boolean inside(int a, int b, int x, int y)
{
	if (a < mouseX && a+x > mouseX && b < mouseY && b+y > mouseY && a < pmouseX && a+x > pmouseX && b < pmouseY && b+y > pmouseY) {return true;}
	else return false;
}

