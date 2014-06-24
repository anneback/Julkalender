import tuio.*;

SurfaceObjectList objectList;
TuioClient client;

PImage snowscape;
PImage christmas_song;
PImage piano;

int window; 
// 0: val av lucka
// 1: spela noter
// 2: spela jullåtar
// 3: snöman pussel med mus
// 4: snöman pussel med fiducials
// 5: stort pussel med mus
// 6: stort pussel med fiducials
// 7: snölandskap

int w1X, w1Y;
int wSize;
color wColor, wHighlightColor, wCurrentColor;
boolean w1Over = false;

int w2X, w2Y;
boolean w2Over = false;
int w3X, w3Y;
boolean w3Over = false;
int w4X, w4Y;
boolean w4Over = false;
int w5X, w5Y;
boolean w5Over = false;
int w6X, w6Y;
boolean w6Over = false;
int w7X, w7Y;
boolean w7Over = false;
int backX, backY;
boolean backOver = false;

//pussel mus

pieceObject piece00;
pieceObject piece01;
pieceObject piece02;
pieceObject piece03;
pieceObject piece10;
pieceObject piece11;
pieceObject piece12;
pieceObject piece13;
pieceObject piece20;
pieceObject piece21;
pieceObject piece22;
pieceObject piece23;

boolean bp00 = false;
boolean bp01 = false;
boolean bp02 = false;
boolean bp03 = false;
boolean bp10 = false;
boolean bp11 = false;
boolean bp12 = false;
boolean bp13 = false;
boolean bp20 = false;
boolean bp21 = false;
boolean bp22 = false;
boolean bp23 = false;

int draged = -1;
//end

//julmusik
float[] frequencys;
float frequencyMin;
float frequencyMax;
float[] volumes;
float volumeMin;
float volumeMax;
boolean soundOn;
// end julmusik

boolean snowing = false;
float[] xCoords = new float[500];
float[] yCoords = new float[500];
float[] xMove = new float[500];
float[] yMove = new float[500];


UDPOutput clientParameters = new UDPOutput("127.0.0.1", 3001, 3003);
UDPOutput clientSoundOnOff = new UDPOutput("127.0.0.1", 3002, 3004);

Integer currentfid = 0;

void setup()
{
  textFont(createFont("Sans", 12));

  size(1280,720);
  
  clearVariables();
  
  window = 0;
  snowscape = loadImage("snowscape.jpg");
  snowscape.resize(1280,720);
  wColor = color(0);
  wHighlightColor = color(255);
  
  w1X = 224+64;
  w1Y = 155+64;
  wSize = 128;
  
  w2X = 576+64;
  w2Y = 155+64;
  
  w3X = 928+64;
  w3Y = 155+64;
  
  w4X = 153+64;
  w4Y = 437+64;
  
  w5X = 435+64;
  w5Y = 437+64;
  
  w6X = 716+64;
  w6Y = 437+64;
  
  w7X = 997+64;
  w7Y = 437+64;
  
  backX = 1152+64;
  backY = 592+64;

  smooth();
  for (int i = 0; i < 500; i++) {
    xCoords[i] = random(width);
    yCoords[i] = random(height);
    yMove[i] = random(2, 5);
  }
  rectMode(CENTER);
  textAlign(CENTER);
  noStroke();
  fill(0);
  redraw();
  objectList = new SurfaceObjectList();
  client  = new TuioClient(this);
  
  //*******PIANO*********
  piano=loadImage("piano.jpg");
  piano.resize(1280,720);
  //********Julmusik**********
  christmas_song=loadImage("christmas_song.jpg");
  christmas_song.resize(1280,720);
  //FREQUENCY
  frequencyMin = 30;
  frequencyMax = 880;
  //[0] = freq7, [1] = freq8, [2] = freq9
  frequencys = new float[3];
  // Frequency to start is 80
  for(int f = 0; f<frequencys.length ; f++) {
    frequencys[f] = 80;
  }
  
  //VOLUMES
  volumeMin = 0;
  volumeMax = 1;
  volumes = new float[3];
  for(int v = 0; v<volumes.length ; v++) {
    volumes[v] = 0.0;
  }
  soundOn= false;
}

void draw()
{
  background(255);
  if(window == 0){
    textSize(120);
    image(snowscape, 0, 0);
    
    update(mouseX,mouseY);
    stroke(255);
    
    if(w1Over==true){
      fill(wHighlightColor,100);
      rect(w1X,w1Y,wSize,wSize);
    }else {
      fill(wColor,100);
      rect(w1X,w1Y,wSize,wSize);
    }
    fill(255, 200);
    text("1", w1X, w1Y+50);
    
    if(w2Over==true){
      fill(wHighlightColor,100);
      rect(w2X,w2Y,wSize,wSize);
    }else {
      fill(wColor,100);
      rect(w2X,w2Y,wSize,wSize);
    }
    fill(255, 200);
    text("2", w2X, w2Y+50);
    
    if(w3Over==true){
      fill(wHighlightColor,100);
      rect(w3X,w3Y,wSize,wSize);
    }else {
      fill(wColor,100);
      rect(w3X,w3Y,wSize,wSize);
    }
    fill(255, 200);
    text("3", w3X, w3Y+50);
    
    if(w4Over==true){
      fill(wHighlightColor,100);
      rect(w4X,w4Y,wSize,wSize);
    }else {
      fill(wColor,100);
      rect(w4X,w4Y,wSize,wSize);
    }
    fill(255, 200);
    text("4", w4X, w4Y+50);
    
    if(w5Over==true){
      fill(wHighlightColor,100);
      rect(w5X,w5Y,wSize,wSize);
    }else {
      fill(wColor,100);
      rect(w5X,w5Y,wSize,wSize);
    }
    fill(255, 200);
    text("5", w5X, w5Y+50);
    
    if(w6Over==true){
      fill(wHighlightColor,100);
      rect(w6X,w6Y,wSize,wSize);
    }else {
      fill(wColor,100);
      rect(w6X,w6Y,wSize,wSize);
    }
    fill(255, 200);
    text("6", w6X, w6Y+50);
    
    if(w7Over==true){
      fill(wHighlightColor,100);
      rect(w7X,w7Y,wSize,wSize);
    }else {
      fill(wColor,100);
      rect(w7X,w7Y,wSize,wSize);
    }
    fill(255, 200);
    text("7", w7X, w7Y+50);
  }else if (window == 1){
    image(piano,0,0);
    objectList.draw();
    //TODO lägg till grafik för notspelaren
  }else if (window == 2){
    image(christmas_song,0,0);
    objectList.draw();
    //TODO lägg till grafik för julmusikspelaren
  }else if (window == 3){
    if(bp02) {
      piece02.draw();
    }
    if(bp01) {
      piece01.draw();
    }
    if(bp00) {
      piece00.draw();
    }
    if(bp12) {
      piece12.draw();
    }
    if(bp11) {
      piece11.draw();
    }
    if(bp10) {
      piece10.draw();
    }
  }else if (window == 4){
    objectList.draw();
  }else if (window == 5){
    if(bp03) {
      piece03.draw();
    }
    if(bp02) {
      piece02.draw();
    }
    if(bp01) {
      piece01.draw();
    }
    if(bp00) {
      piece00.draw();
    }
    if(bp13) {
      piece13.draw();
    }
    if(bp12) {
      piece12.draw();
    }
    if(bp11) {
      piece11.draw();
    }
    if(bp10) {
      piece10.draw();
    }
    if(bp23) {
      piece23.draw();
    }
    if(bp22) {
      piece22.draw();
    }
    if(bp21) {
      piece21.draw();
    }
    if(bp20) {
      piece20.draw();
    }
  }else if (window == 6){
    objectList.draw();
  }else if (window == 7){
    image(snowscape, 0, 0);
    objectList.draw();
    if(snowing == true){
      fill(255);
      for (int i = 0; i < 500; i++) {
        ellipse(xCoords[i], yCoords[i], 5, 5);
        xCoords[i] +=xMove[i];
        yCoords[i] +=yMove[i];
     
        //make it wiggle!!
        xCoords[i] += random(-5, 1);
     
        if (yCoords[i] > height) {
          yCoords[i] = 0;
        }
        if (xCoords[i] < 0) {
          xCoords[i] = width;
        }
      }

    }
  }
  if(window != 0){
    update(mouseX,mouseY);
    stroke(255);
    if(backOver==true){
      fill(wHighlightColor,100);
      rect(backX,backY+70,wSize,wSize);
    }else {
      fill(wColor,100);
      rect(backX,backY+70,wSize,wSize);
    }
    textSize(20); 
    fill(255, 200);
    text("Menu", backX, backY+50);
  }
    
}

void update(int x, int y){
  if(overRect(w1X, w1Y, wSize, wSize)){
    w1Over = true;
  }else w1Over = false;
  
  if(overRect(w2X, w2Y, wSize, wSize)){
    w2Over = true;
  }else w2Over = false;
  
  if(overRect(w3X, w3Y, wSize, wSize)){
    w3Over = true;
  }else w3Over = false;
  
  if(overRect(w4X, w4Y, wSize, wSize)){
    w4Over = true;
  }else w4Over = false;
  
  if(overRect(w5X, w5Y, wSize, wSize)){
    w5Over = true;
  }else w5Over = false;
  
  if(overRect(w6X, w6Y, wSize, wSize)){
    w6Over = true;
  }else w6Over = false;
  if(overRect(w7X, w7Y, wSize, wSize)){
    w7Over = true;
  }else w7Over = false;
  if(overRect(backX, (backY+70), wSize, wSize)){
    backOver = true;
  }else backOver = false;
}

boolean overRect(int x, int y, int width, int height)  {
  if ((mouseX+64) >= x && (mouseX+64) <= x+width && 
      (mouseY+64) >= y && (mouseY+64) <= y+height) {
    return true;
  } else {
    return false;
  }
}

void mouseClicked(){
  if(w1Over == true){
     window = 1;
  }
  if(w2Over == true){
     window = 2;
     clientParameters.send(currentfid+" "+frequencys[0]+" "+frequencys[1]+" "+frequencys[2]+" "+volumes[0]+" "+volumes[1]+" "+volumes[2]+" "+window+"\n");
  }
  if(w3Over == true){
     window = 3;
  }
  if(w4Over == true){
     window = 4;
  }
  if(w5Over == true){
     window = 5;
  }
  if(w6Over == true){
     window = 6;
  }
  if(w7Over == true){
     window = 7;
  }
  if(backOver == true){
     window = 0;
     
     //Mute sound when you go back to menu
     volumes[0]=0.0;
     volumes[1]=0.0;
     volumes[2]=0.0;
     sendParameters();
     
     clearVariables();
  }
}
void mouseReleased(){
 if(window == 3) draged = -1; 
 else if(window == 5) draged = -1;
}

void mouseDragged(){
  if(window == 3){  
    if(mouseX >= 0 && mouseX <= 1280 && mouseY >= 0 && mouseY <= 720){
      if(bp00 && piece00.within() && mousePressed && (draged == -1 || draged == 0)){
        draged = 0;
        piece00.update();
      }
      else if(bp01 && piece01.within() && mousePressed && (draged == -1 || draged == 1)){
        draged = 1;
        piece01.update();
      }
      else if(bp02 && piece02.within() && mousePressed && (draged == -1 || draged == 2)){
        draged = 2;
        piece02.update();
      }
      else if(bp10 && piece10.within() && mousePressed && (draged == -1 || draged == 4)){
        draged = 4;
        piece10.update();
      }
      else if(bp11 && piece11.within() && mousePressed && (draged == -1 || draged == 5)){
        draged = 5;
        piece11.update();
      }
      else if(bp12 && piece12.within() && mousePressed && (draged == -1 || draged == 6)){
        draged = 6;
        piece12.update();
      }
      refresh();
    }
  }else if (window ==5){
    if(mouseX >= 0 && mouseX <= 1280 && mouseY >= 0 && mouseY <= 720){
      if(bp00 && piece00.within() && mousePressed && (draged == -1 || draged == 0)){
        draged = 0;
        piece00.update();
      }
      else if(bp01 && piece01.within() && mousePressed && (draged == -1 || draged == 1)){
        draged = 1;
        piece01.update();
      }
      else if(bp02 && piece02.within() && mousePressed && (draged == -1 || draged == 2)){
        draged = 2;
        piece02.update();
      }
      else if(bp03 && piece03.within() && mousePressed && (draged == -1 || draged == 3)){
        draged = 3;
        piece03.update();
      }
      else if(bp10 && piece10.within() && mousePressed && (draged == -1 || draged == 4)){
        draged = 4;
        piece10.update();
      }
      else if(bp11 && piece11.within() && mousePressed && (draged == -1 || draged == 5)){
        draged = 5;
        piece11.update();
      }
      else if(bp12 && piece12.within() && mousePressed && (draged == -1 || draged == 6)){
        draged = 6;
        piece12.update();
      }
      else if(bp13 && piece13.within() && mousePressed && (draged == -1 || draged == 7)){
        draged = 7;
        piece13.update();
      }
      else if(bp20 && piece20.within() && mousePressed && (draged == -1 || draged == 8)){
        draged = 8;
        piece20.update();
      }
      else if(bp21 && piece21.within() && mousePressed && (draged == -1 || draged == 9)){
        draged = 9;
        piece21.update();
      }
      else if(bp22 && piece22.within() && mousePressed && (draged == -1 || draged == 10)){
        draged = 10;
        piece22.update();
      }
      else if(bp23 && piece23.within() && mousePressed && (draged == -1 || draged == 11)){
        draged = 11;
        piece23.update();
      }
      refresh();
    }
  }
}

// called after each message bundle
void refresh() { 
  redraw(); 
}
// called when an object is added to the scene
void addTuiObject(Integer s_id, Integer f_id) {
  currentfid = f_id;
  if(window == 1) {
    setVolume(0.4);
    objectList.activate(s_id,f_id);
  }else if(window == 2) {
    setVolume(0.4); //VOLUME is 0.4
    setFrequency(80);
    objectList.activate(s_id,f_id);
  } else if(window == 3){
    if(f_id == 0 && bp00 == false ){
      piece00 = new pieceObject(loadImage("SPiece_00.png"));
      bp00 = true;
    }
    if(f_id == 1 && bp01 == false ){
      piece01 = new pieceObject(loadImage("SPiece_01.png"));
      bp01 = true;
    }
    if(f_id == 2 && bp02 == false ){
      piece02 = new pieceObject(loadImage("SPiece_02.png"));
      bp02 = true;
    }
    if(f_id == 3 && bp10 == false ){
      piece10 = new pieceObject(loadImage("SPiece_10.png"));
      bp10 = true;
    }
    if(f_id == 4 && bp11 == false ){
      piece11 = new pieceObject(loadImage("SPiece_11.png"));
      bp11 = true;
    }
    if(f_id == 5 && bp12 == false ){
      piece12 = new pieceObject(loadImage("SPiece_12.png"));
      bp12 = true;
    }
    objectList.activate(s_id,f_id);
    currentfid = 0;
  }else if (window == 4){
    objectList.activate(s_id,f_id);
  }else if (window == 5){
    if(f_id == 0 && bp00 == false ){
      piece00 = new pieceObject(loadImage("Piece_00.png"));
      bp00 = true;
    }
    if(f_id == 1 && bp01 == false ){
      piece01 = new pieceObject(loadImage("Piece_01.png"));
      bp01 = true;
    }
    if(f_id == 2 && bp02 == false ){
      piece02 = new pieceObject(loadImage("Piece_02.png"));
      bp02 = true;
    }
    if(f_id == 3 && bp03 == false ){
      piece03 = new pieceObject(loadImage("Piece_03.png"));
      bp03 = true;
    }
    if(f_id == 4 && bp10 == false ){
      piece10 = new pieceObject(loadImage("Piece_10.png"));
      bp10 = true;
    }
    if(f_id == 5 && bp11 == false ){
      piece11 = new pieceObject(loadImage("Piece_11.png"));
      bp11 = true;
    }
    if(f_id == 6 && bp12 == false ){
      piece12 = new pieceObject(loadImage("Piece_12.png"));
      bp12 = true;
    }
    if(f_id == 7 && bp13 == false ){
      piece13 = new pieceObject(loadImage("Piece_13.png"));
      bp13 = true;
    }
    if(f_id == 8 && bp20 == false ){
      piece20 = new pieceObject(loadImage("Piece_20.png"));
      bp20 = true;
    }
    if(f_id == 9 && bp21 == false ){
      piece21 = new pieceObject(loadImage("Piece_21.png"));
      bp21 = true;
    }
    if(f_id == 10 && bp22 == false ){
      piece22 = new pieceObject(loadImage("Piece_22.png"));
      bp22 = true;
    }
    if(f_id == 11 && bp23 == false ){
      piece23 = new pieceObject(loadImage("Piece_23.png"));
      bp23 = true;
    }
    objectList.activate(s_id,f_id);
    currentfid = 0;
  }else if(window == 6){
    objectList.activate(s_id,f_id);
  }else if(window == 7){
    if(f_id == 3) {
      snowing = true;
    }else{
      objectList.activate(s_id,f_id);
    }
  }
    
}

// called when an object is removed from the scene
void removeTuiObject(Integer s_id,Integer f_id ) {
  objectList.deactivate(s_id);
  setVolume(0.0);
  if(f_id == 3) snowing = false;

}

Float angle1=0.0;
Float xpos1=0.0;
// called when an object is moved
void updateTuiObject (Integer s_id, Integer f_id, Float xpos2, Float ypos, Float angle2) {
  objectList.update(s_id,(int)(1280 - 1280*xpos2.floatValue()),(int)(720*ypos.floatValue()),angle2.floatValue());
    if(currentfid==7) {
      if(angle2<angle1){
        setFrequency(frequencys[0] + 0.001);
      }
      if(angle2>angle1){
        setFrequency(frequencys[0] - 0.001);
      }
    angle1 = angle2;
    System.out.println("UPDATE: id: " +currentfid + " freqencys: (" + frequencys[0]+") "+"("+frequencys[1]+") "+"("+frequencys[2]+") "+" vol: "+volumes[0]+","+volumes[1]+","+volumes[2]+" window: "+window);
    } else
    if(currentfid==8) {
      if(angle2<angle1){
        setFrequency(frequencys[1] + 0.001);
      }
      if(angle2>angle1){
        setFrequency(frequencys[1] - 0.001);
      }
    angle1 = angle2;
    System.out.println("UPDATE: id: " +currentfid + " freqencys: (" + frequencys[0]+") "+"("+frequencys[1]+") "+"("+frequencys[2]+") "+" vol: "+volumes[0]+","+volumes[1]+","+volumes[2]+" window: "+window);
    } else
    if(currentfid==9) {
      if(angle2<angle1){
        setFrequency(frequencys[2] + 0.001);
      }
      if(angle2>angle1){
        setFrequency(frequencys[2] - 0.001);
      }
    System.out.println("UPDATE: id: " +currentfid + " freqencys: (" + frequencys[0]+") "+"("+frequencys[1]+") "+"("+frequencys[2]+") "+" vol: "+volumes[0]+","+volumes[1]+","+volumes[2]+" window: "+window);
    angle1 = angle2;
    }
}

void setFrequency(float value)
{
  if (window==2) {
    if(currentfid==7) {
        frequencys[0] = max(min(value, frequencyMax), frequencyMin); 
        sendParameters();  
    } else
    if(currentfid==8) {
        frequencys[1] = max(min(value, frequencyMax), frequencyMin); 
        sendParameters(); 
    } else
    if(currentfid==9) {
        frequencys[2] = max(min(value, frequencyMax), frequencyMin); 
        sendParameters(); 
    }
  }
}

void setVolume(float value)
{
  if (window==2) {
    if(currentfid==7) {
      volumes[0] = max(min(value, volumeMax), volumeMin); 
      sendParameters();
    } else  
    if(currentfid==8) {
      volumes[1] = max(min(value, volumeMax), volumeMin); 
      sendParameters();
    } else
    if(currentfid==9) {
      volumes[2] = max(min(value, volumeMax), volumeMin); 
      sendParameters();
    }  
  }
}

//Here we send data to UDP port/PURE DATA
void sendParameters()
{
  clientParameters.send(currentfid+" "+frequencys[0]+" "+frequencys[1]+" "+frequencys[2]+" "+volumes[0]+" "+volumes[1]+" "+volumes[2]+"\n");
  //System.out.println("UPDATE: id: " +currentfid + " freqencys: (" + frequencys[0]+") "+"("+frequencys[1]+") "+"("+frequencys[2]+") "+" vol: "+volumes[0]+","+volumes[1]+","+volumes[2]+" window: "+window);
}

void clearVariables(){
  bp00 = false;
  bp01 = false;
  bp02 = false;
  bp03 = false;
  bp10 = false;
  bp11 = false;
  bp12 = false;
  bp13 = false;
  bp20 = false;
  bp21 = false;
  bp22 = false;
  bp23 = false;
}

void toggleSound()
{
  soundOn = !soundOn; 
  if (soundOn)
    clientSoundOnOff.send("1\n");
  else 
    clientSoundOnOff.send("0\n"); 
}


