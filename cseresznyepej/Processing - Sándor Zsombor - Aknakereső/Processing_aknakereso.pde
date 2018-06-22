def setup():
    global table,base,inMenu,menuVar,ended
    inMenu = True
    menuVar = MenuVar()
    base = Base()
    size(400,300)
    this.surface.setResizable(True)
    background(255)   
    print(base.side)
    ended = False

def draw():
    global table,base,inMenu,ended,delay_counter,start_time
    if ended == False:
        delay_counter = 0
        if not(inMenu): #in game
            seen = 0
            flag = 0
            background(255)
            for row in table:
                for tile in row:
                    if tile.flagged:
                        flag += 1
                        drawFlag(tile)
                    elif tile.revealed:
                        seen += 1
                        if tile.adjMines == 0:
                            drawEmpty(tile)
                        else:
                            drawNum(tile)
                    else:
                        drawNew(tile)
            textSize(12);fill(0)
            text("Hatraevo aknak:",5,15)
            textSize(15)
            text(str(base.mines-flag),40,35)
            print(seen+base.mines, base.row*base.col)
            if seen+base.mines == base.row*base.col:
                print("******YOU WON*******")
                ended = "won"
            current_time = hour()*3600+minute()*60+second()
            elapsed_time = current_time-start_time
            print(current_time,start_time)
            elapsed_min = elapsed_time//60
            elapsed_sec = elapsed_time%60
            elapsed_sec = str(elapsed_sec).zfill(2)
            elapsed_time = "{0}:{1}".format(elapsed_min,elapsed_sec)
            textSize(30)
            text(elapsed_time,base.side*base.col-80,35)
                
        else: #in menu        
            ended = False
            background(255)

            #textAlign(LEFT,BOTTOM)
            textSize(20)
            fill(0)
            text("Sorok", 40,60)
            text("Oszlopok", 140,60)
            text("Aknak", 280,60)
            
            textSize(40)
            text(str(base.row),40,110)
            text(str(base.col),160,110)
            text(str(base.mines),280,110)
            
            textSize(25)
            text("-   +",40,140)
            text("-   +",160,140)
            text("-   +",280,140)
            
            textSize(15)
            fill(255); stroke(0)
            rect(70,180,230,50)
            #textAlign(CENTER,CENTER)
            fill(0)
            text("Nyomd meg az entert vagy kattints ide az inditashoz!",75,180,220,50)
            
            start_time = hour()*3600+minute()*60+second()
    
    else: #vége a játéknak
        if ended == "lost":
            message = "Vesztettel"
        elif ended == "won":
            message = "Nyertel"
        
        y1 = base.row*base.side/2
        x1 = base.col*base.side/2-80
        x2 = base.col*base.side/2+80
        y2 = base.row*base.side/2+40
        stroke(0);fill(255)
        rect(x1,y1,x2-x1,y2-y1)
        fill(0);textSize(32)#;textAlign(CENTER,CENTER)
        text(message,x1,y1,x2-x1,y2-y1)
        if delay_counter >= 200:
            inMenu = True
            this.surface.setResizable(True)
            this.surface.setSize(400,300)
            this.surface.setResizable(False)
            ended = False
        else:
            delay(1);delay_counter += 1
            print(delay_counter)
        
        
        
def mouseClicked():
    global table,inMenu,menuVar,base,ended
    if not(inMenu): #Játékban
        x = mouseX//base.side
        y = (mouseY - 40)//base.side
        tile = table[x][y]
        if mouseButton == LEFT:
            if tile.mine:                
                print("******YOU DIED***********")
                ended = "lost"
            else:
                reveal(tile)
        elif mouseButton == RIGHT:
            tile.flagged = not(tile.flagged)
        elif mouseButton == CENTER:
            print(tile.__dict__)
    
    else: #menüben
        x = mouseX
        y = mouseY
        if mouseButton == LEFT:
            if menuVar.row_minus["x1"] <= x <= menuVar.row_minus["x2"] and menuVar.row_minus["y1"] <= y <= menuVar.row_minus["y2"]:
                base.row -= 1
            elif menuVar.row_plus["x1"] <= x <= menuVar.row_plus["x2"] and menuVar.row_plus["y1"] <= y <= menuVar.row_plus["y2"]:
                base.row += 1
            elif menuVar.col_minus["x1"] <= x <= menuVar.col_minus["x2"] and menuVar.col_minus["y1"] <= y <= menuVar.col_minus["y2"]:
                base.col -= 1
            elif menuVar.col_plus["x1"] <= x <= menuVar.col_plus["x2"] and menuVar.col_plus["y1"] <= y <= menuVar.col_plus["y2"]:
                base.col += 1
            elif menuVar.mine_minus["x1"] <= x <= menuVar.mine_minus["x2"] and menuVar.mine_minus["y1"] <= y <= menuVar.mine_minus["y2"]:
                base.mines -= 1
            elif menuVar.mine_plus["x1"] <= x <= menuVar.mine_plus["x2"] and menuVar.mine_plus["y1"] <= y <= menuVar.mine_plus["y2"]:
                base.mines += 1
            elif menuVar.begin["x1"] <= x <= menuVar.begin["x2"] and menuVar.begin["y1"] <= y <= menuVar.begin["y2"]:
                generate()
                inMenu = False

def lose():
    global base,inMenu
    delay(2000)
    inMenu = True
             

#####
def generate():
    global table,base
    table = [[Square(x*base.side,y*base.side+40) for y in range(base.row)] for x in range(base.col)] 
    i = 0
    this.surface.setResizable(True)
    this.surface.setSize(base.col*base.side,40+base.row*base.side)
    this.surface.setResizable(False)
    
    while i < base.mines :
        mine_x = int(random(base.col))
        mine_y = int(random(base.row))
        if table[mine_x][mine_y].mine == True:
            pass
        else:
            table[mine_x][mine_y].mine = True
            i += 1
    
    
    for x in range(base.col):
        for y in range(base.row):
            for nx in [x-1,x,x+1]:
                for ny in [y-1,y,y+1]:
                    if nx < 0 or ny < 0:
                        continue
                    try:
                        table[nx][ny].adjTiles.append(table[x][y])
                    except:
                        pass
            table[x][y].adjTiles.remove(table[x][y])
    
    
    for x in range(base.col):
        for y in range(base.row):
            if table[x][y].mine == False:
                find_mines(table[x][y])


def reveal(tile):
    if not(tile.revealed):
        tile.revealed = True
        if tile.adjMines == 0:
            for adj in tile.adjTiles:
                reveal(adj)
            

def drawNum(tile):
    global base
    x = tile.x
    y = tile.y
    fill(255)
    stroke(0)
    rect(x,y,base.side,base.side)
    textSize(20)
    fill(0)
    text(str(tile.adjMines),x,y,x+base.side,y+base.side)

def drawEmpty(tile):
    global base
    x = tile.x
    y = tile.y
    fill(255)
    stroke(0)
    rect(x,y,base.side,base.side)

def drawNew(tile):
    global base
    x = tile.x
    y = tile.y
    fill(100)
    stroke(0)
    rect(x,y,base.side,base.side)

def drawMine(tile):
    global base
    x = tile.x
    y = tile.y
    fill(255)
    stroke(0)
    rect(x,y,base.side,base.side)
    fill(255,0,0)
    ellipse((x+0.5)*base.side,(y+0.5)*base.side,base.side*3/4, base.side*3/4)
    
def drawFlag(tile):
    global base
    x = tile.x
    y = tile.y
    fill(100)
    stroke(0)
    rect(x,y,base.side,base.side)
    stroke(255,0,0)
    line(x+base.side/2, y+base.side/5, x+base.side/2, y+base.side*3/5)
    
    
def find_mines(tile):
    mines = 0
    for adj in tile.adjTiles:
        if adj.mine:
            mines += 1
    tile.adjMines = mines

class Square():
    def __init__(self,x,y):
        self.flagged = False
        self.mine = False
        self.revealed = False
        self.adjMines = 0
        self.adjTiles = []
        self.x = x
        self.y = y

        
class MenuVar():
    def __init__(self):
        self.row_minus = {"x1":40,"y1":110,"x2":70,"y2":145}
        self.row_plus = {"x1":80,"y1":110,"x2":110,"y2":145}
        self.col_minus = {"x1":160,"y1":110,"x2":190,"y2":145}
        self.col_plus = {"x1":200,"y1":110,"x2":230,"y2":145}
        self.mine_minus = {"x1":280,"y1":110,"x2":310,"y2":145}
        self.mine_plus = {"x1":320,"y1":115,"x2":350,"y2":145}
        self.begin = {"x1":70,"y1":180,"x2":300,"y2":230}   
        
class Base():
    def __init__(self):
        self.mines = 10
        self.row = 20
        self.col = 20
        self.side = 20
        
        
