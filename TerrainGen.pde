int w = 3800;
int h = 3000;
int cols, rows;
int scl = 40;
int greenlvl = 150;
int terrainType = 2;

double colorScl = 3;

float[][] terrain;
float fly;

color c[][];

float plains(float xoff, float yoff){
  return map(noise(xoff,yoff), 0, 2, -10, 50);
}

float hilly(float xoff, float yoff){
  return map(noise(xoff,yoff), 0, 2.5, -10, 200);
}

float mountains(float xoff, float yoff){
  return map(noise(xoff,yoff), -0.05, 1.2, -100, 255);
}

void setup(){
  size(900,600,P3D);
  cols = w/scl;
  rows = h/scl;
  terrain = new float[cols][rows];  
  c = new color[cols][rows];
}

void draw(){
  fly -= 0.02;
  
  float yoff = fly;
  for(int y = 0; y < rows; y++){
    float xoff = 0;
    for(int x = 0; x < cols; x++){
      switch (terrainType){
      case 0:
        terrain[x][y] = plains(xoff,yoff);
        break;
        
      case 1:
        terrain[x][y] = hilly(xoff,yoff);
        break;
        
      case 2:
        terrain[x][y] = mountains(xoff,yoff);
        break;      
      }
      
      if (terrain[x][y] > 20){
       if (terrain[x][y] < 255)
         c[x][y] = color((int)((terrain[x][y])*colorScl),greenlvl,0);

       else
         c[x][y] = color(0,greenlvl,255);
      }
  
      else if (terrain[x][y] <= -20)
        if (abs(terrain[x][y]) < 255)
         c[x][y] = color(0,greenlvl,(int)((abs(terrain[x][y]))*colorScl));

       else
         c[x][y] = color(255,greenlvl,0);

       else
         c[x][y] = color(0,greenlvl,0);
        
      xoff += 0.1;
    }
    
    yoff += 0.1;
  }
  
  background(0);
  noFill();
  
  translate(width/2, height/2+200);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  
  for(int y = 0; y < rows-1; y++){
    beginShape(TRIANGLE_STRIP);
    for(int x = 0; x < cols; x++){
      stroke(c[x][y]);
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
}