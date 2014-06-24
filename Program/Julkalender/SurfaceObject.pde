

class SurfaceObject extends TuiObject
{
  int deg1;
  int deg2;
  int fid;
  String fig;
  color c;
  float s;
  
  
  //Puzzle 
  PImage p00;
  PImage p01;
  PImage p02;
  PImage p03;
  PImage p10;
  PImage p11;
  PImage p12;
  PImage p13;
  PImage p20;
  PImage p21;
  PImage p22;
  PImage p23;
  //--P
  
  //Musik
  PImage note;
  PImage letitsnow;
  PImage feliz;
  PImage jingle;
  //end musik

  SurfaceObject(int s_id,int f_id, String fig, color c, float s) 
  {
    super(s_id, f_id);
    this.fid=f_id;
    this.fig=fig;
    this.c=c;
    this.s=100;
    deg1=0;
    
	
	if(window == 1) {
		note = loadImage("note.png");
		note.resize(75,0);
	}

	if(window == 2) {
		jingle = loadImage("jinglebells.jpg");
		letitsnow = loadImage("letitsnow.png");
		feliz = loadImage("feliznavidad.png");
	}
	
    //Puzzle snowman
    if(window == 4){
      p00 = loadImage("SPiece_00.png");
      p01 = loadImage("SPiece_01.png");
      p02 = loadImage("SPiece_02.png");
      p10 = loadImage("SPiece_10.png");
      p11 = loadImage("SPiece_11.png");
      p12 = loadImage("SPiece_12.png");
      
      p00.resize(int(p00.width/1.25) , 0); 
      p01.resize(int(p01.width/1.25) , 0);
      p02.resize(int(p02.width/1.25) , 0);
      p10.resize(int(p10.width/1.25) , 0);
      p11.resize(int(p11.width/1.25) , 0);
      p12.resize(int(p12.width/1.25) , 0);
    }
    else if(window == 6){
      p00 = loadImage("Piece_00.png");
      p01 = loadImage("Piece_01.png");
      p02 = loadImage("Piece_02.png");
      p03 = loadImage("Piece_03.png");
      p10 = loadImage("Piece_10.png");
      p11 = loadImage("Piece_11.png");
      p12 = loadImage("Piece_12.png");
      p13 = loadImage("Piece_13.png");
      p20 = loadImage("Piece_20.png");
      p21 = loadImage("Piece_21.png");
      p22 = loadImage("Piece_22.png");
      p23 = loadImage("Piece_23.png");

      p00.resize(int(p00.width/4.8) , 0); 
      p01.resize(int(p01.width/4.8) , 0);
      p02.resize(int(p02.width/4.8) , 0);
      p03.resize(int(p03.width/4.8) , 0);
      p10.resize(int(p10.width/4.8) , 0);
      p11.resize(int(p11.width/4.8) , 0);
      p12.resize(int(p12.width/4.8) , 0);
      p13.resize(int(p13.width/4.8) , 0);
      p20.resize(int(p20.width/4.8) , 0);
      p21.resize(int(p21.width/4.8) , 0);
      p22.resize(int(p22.width/4.8) , 0);
      p23.resize(int(p23.width/4.8) , 0);
    }
    //--P
    if(window == 7){
      p00 = loadImage("santa.png");
      p00.resize(int(p00.width/5) , 0);
      p01 = loadImage("Snowman.png");
      p01.resize(int(p01.width/5) , 0);
      p02 = loadImage("rudolf.png");
      p02.resize(int(p02.width/2) , 0);
    }
  }

  void update(int x, int y, float a) 
  {
    super.update(x, y, a);
    deg2 = (int)(angle*180/PI);
    if(deg2 > deg1){
      s++;
    }
    if(deg2 < deg1){
      s--;
    }
  }

  void draw() 
  {
    PImage pic = null; //puzzle
    
    noStroke();   

    pushMatrix();
    translate(xpos, ypos);
    rotate(angle);
    
    //Puzzle
	if(window == 1) {
		if(fid == 0){
			image(note, 0-(note.width/2), 0-(note.height/2));
		} else
		if(fid == 1){
			image(note, 0-(note.width/2), 0-(note.height/2));
		} else
		if(fid == 2){
			image(note, 0-(note.width/2), 0-(note.height/2));
		} else
		if(fid == 3){
			image(note, 0-(note.width/2), 0-(note.height/2));
		} else
		if(fid == 4){
			image(note, 0-(note.width/2), 0-(note.height/2));
		} else
		if(fid == 5){
			image(note, 0-(note.width/2), 0-(note.height/2));
		} else
		if(fid == 6){
			image(note, 0-(note.width/2), 0-(note.height/2));
		}
	}
	
	if(window == 2) {
		if(fid == 7) {
			image(jingle, 0-(jingle.width/2), 0-(jingle.height/2));
		} else
		if(fid == 8) {
			image(letitsnow, 0-(letitsnow.width/2), 0-(letitsnow.height/2));
		} else
		if(fid == 9) {
			image(feliz, 0-(feliz.width/2), 0-(feliz.height/2));
		}
	}
	
    if(window == 4){
        if(fid == 0){
         pic = p00;
        }
        else if(fid == 1){
         pic = p01;
        }
        else if(fid == 2){
         pic = p02;
        }
        else if(fid == 3){
         pic = p10;
        }
        else if(fid == 4){
         pic = p11;
        }
        else if(fid == 5){
         pic = p12;
        }
        if(fid <= 5)
        image(pic, 0-(pic.width/2), 0-(pic.height/2));
    }else if (window == 6){
      if(fid == 0){
       pic = p00;
      }
      else if(fid == 1){
       pic = p01;
      }
      else if(fid == 2){
       pic = p02;
      }
      else if(fid == 3){
       pic = p03;
      }
      else if(fid == 4){
       pic = p10;
      }
      else if(fid == 5){
       pic = p11;
      }
      else if(fid == 6){
       pic = p12;
      }
      else if(fid == 7){
       pic = p13;
      }
      else if(fid == 8){
       pic = p20;
      }
      else if(fid == 9){
       pic = p21;
      }
      else if(fid == 10){
       pic = p22;
      }
      else if(fid == 11){
       pic = p23;
      }
      if(fid <= 11)
      image(pic, 0-(pic.width/2), 0-(pic.height/2));
    }else if (window == 7){
      if(fid == 0){
        pic = p00;
      }else if(fid == 1){
        pic = p01;
      }else if(fid == 2){
        pic = p02;
      }
      if(fid <= 2)
      image(pic, 0-(pic.width/2), 0-(pic.height/2));
    }
    
    popMatrix();
    fill(100);
    
    
    deg1 = deg2;
  }
  
  
}
