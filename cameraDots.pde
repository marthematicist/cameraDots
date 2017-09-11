PImage img;
// Step 1. Import the video library.
import processing.video.*;

//Step 2. Declare a capture object.
Capture video;

// Step 5. Read from the camera when a new image is available!
void captureEvent(Capture video) 
{
  video.read();
}
void setup() {
  size( 800 , 600 );
  img = loadImage( "IMG_0359.JPG");
  // Step 3. Initialize Capture object.
  video = new Capture(this, 320, 240);
  colorMode(HSB,1);
  // Step 4. Start the capturing process.
  video.start();
  background(0,0,0);
}

float avgBri = 1;
float rollAmt = 0.001;

void draw() {
  float thres = 0.45;
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
        float s = saturation(c);
        fill(h,1,b,alpha1); 
      }
      else { fill(0,0,0,alpha2); }
      ellipse(xd,yd,diam,diam);
    }
  }
  println(avgBri);
}