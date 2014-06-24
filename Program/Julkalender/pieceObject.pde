

class pieceObject{
  PImage pic;
  float xpos = 0;
  float ypos = 0;
  
  pieceObject(PImage picture){
    this.pic = picture;
    if(window == 3) pic.resize(int(pic.width/1.25), 0);
    else if(window == 5) pic.resize(int(pic.width/4.8), 0);
    if(mouseX >= 0 && mouseX <= 1280 && mouseY >= 0 && mouseY <= 720){
      this.xpos = mouseX-(pic.width/2);
      this.ypos = mouseY-(pic.height/2);
    }
  }
  void draw(){
    noStroke();
    image(pic, xpos, ypos);
  }
  void update(){
    xpos = mouseX-(pic.width/2);
    ypos = mouseY-(pic.height/2);
  }
  boolean within(){
    if(mouseX >= xpos && mouseX <= (xpos + pic.width) && mouseY >= ypos && mouseY <= (ypos + pic.height)) return true;
    return false;
  }
}
