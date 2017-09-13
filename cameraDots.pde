PImage img;
import processing.video.*;
Capture video;
void captureEvent(Capture video) 
{
  video.read();
}
void setup() {
  size( 800 , 600 );
  video = new Capture(this, 320, 240);
  colorMode(HSB,1);
  video.start();
  background(0,0,0);
}

float avgBri = 1;
float rollAmt = 0.001;

void draw() {
  loadPixels();
  noStroke();
  float alpha1 = 0.6;
  float alpha2 = 0.1;
  float conv = float(width)/float(video.width);
  float yOffset = float(video.height)*conv - float(height);
  for( int i = 0 ; i < 2000 ; i++ ) {
    int x = floor(random(video.width));
    int y = floor(random(video.height));
    int ind = x + y*video.width;
    color c = video.pixels[ind];
    float xs = float(x)*conv;
    float ys = float(y)*conv;
    
    float diam = random(1,20);
    float xd = width-xs;
    float yd = ys-0.5*yOffset;
    if( xd>=0 && xd<=width && yd>=0 && yd<=height ) {
      float b = brightness(c);
      avgBri = b*rollAmt + avgBri*(1-rollAmt);
      if( b > avgBri ) { 
        float h = hue(c);
        fill(h,1,1,alpha1); 
      }
      else { fill(0,0,0,alpha2); }
      ellipse(xd,yd,diam,diam);
    }
  }
  if(frameCount%100 == 0) { println(avgBri); }
}