Slider slider;
boolean pressed;
int pixelSize = 6;
boolean red;
boolean green;
boolean blue;

void setup(){
  fullScreen();
  //size(1920, 1080);
  //size(500, 500);
  red = true;
  slider = new Slider(width/2, height - 50, 20, 400);
  noStroke();
}

void draw(){
 for(int i = 0; i < height; i += pixelSize){
   for(int j = 0; j < width; j += pixelSize){
     if(red){
     fill(map(slider.knob.x, slider.x - slider.width/2, slider.x + slider.width/2, 0, 255), map(i, 0, height, 0, 255), map(j, 0, width, 0 ,255));
     }else if(green){
       fill(map(i, 0, height, 0, 255), map(slider.knob.x, slider.x - slider.width/2, slider.x + slider.width/2, 0, 255), map(j, 0, width, 0 ,255));
     }else if(blue){
     fill(map(i, 0, height, 0, 255), map(j, 0, width, 0 ,255), map(slider.knob.x, slider.x - slider.width/2, slider.x + slider.width/2, 0, 255));
     }else{
      System.out.println("ERROR, No Slider Color Selected"); 
     }
     square(j, i, pixelSize);
   }
 }
 if(pressed){
   if(mouseX > slider.knob.x + 5 || mouseX < slider.knob.x - 5){
     if(mouseX > slider.x + slider.width/2){
       slider.knob.x = slider.x + slider.width/2;
     }else if(mouseX < slider.x - slider.width/2){
       slider.knob.x = slider.x - slider.width/2;
     }else{
       slider.knob.x = mouseX;
     }
   }
 }
 slider.display();
 push();
 //Draw the red selection square
 noStroke();
 if(red){
   stroke(0);
   strokeWeight(4);
 }
 fill(255, 0, 0);
 rect(0, height - 32, 30, 30);
 //Draw the green selection square
 noStroke();
 if(green){
   stroke(0);
   strokeWeight(4);
 }
 fill(0, 255, 0);
 rect(32, height - 32, 30, 30);
 //Draw the blue selection square
 noStroke();
 if(blue){
   stroke(0);
   strokeWeight(4);
 }
 fill(0, 0, 255);
 rect(64, height - 32, 30, 30);
 pop();
}

class Slider{
  int x;
  int y;
  //Distance from top to bottom
  //0 is center
  int height;
  //Distance from left side to right side
  //0 is center
  int width;
  int r, g, b;
  //Size of the slider's knob
  int knobRadius;
  //Position between [-width/2, width/2]
  //0 is the center
  int knobPos = 0;
  Knob knob;
  
 Slider(){
   this(0, 0, 0, 0, 0);
 }
  Slider(int x, int y){
   this(x, y, 10, 50, 0);
 }
  Slider(int x, int y, int height, int width){
   this(x, y, height, width, (int)(height * 1.5));
 }
 
  Slider(int x, int y, int height, int width, int knobRadius){
    this.x = x;
    this.y = y;
    this.height = height;
    this.width = width;
    this.knobRadius = knobRadius;
    this.knob = new Knob(knobPos + this.x, this.y, knobRadius);
    this.r = 255;
  }
  
  void display(){
    push();
    fill(r, g, b);
    strokeWeight(1);
    stroke(0);
    rect(this.x - this.width/2, this.y - this.height/2, this.width, this.height, 10);
    this.knob.display();
    pop();
  }
  
}

class Knob{
  int x;
  int y;
  int radius;
  int r, g, b;
  Knob(){
    this(0, 0, 0);
  }
  Knob(int x, int y){
    this(x, y, 0);
  }
  Knob(int x, int y, int radius){
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.r = 80;
    this.g = 80; 
    this.b = 80;
  }
  void display(){
    push();
    fill(r, g, b);
    stroke(3);
    ellipse(this.x, this.y, this.radius, this.radius);
    pop();
  }
  boolean isHovered(){
    return dist(mouseX, mouseY, this.x, this.y) < this.radius/2;
  }
  
}

void mousePressed(){
  //Check if the mouse is on the slider knob
  if(slider.knob.isHovered()){
    pressed = true;
  }
  if(mouseY > height - 32){
    //Check if the mouse clicked on red
    if(mouseX <= 32){
      red = true;
      green = false;
      blue = false;
      slider.r = 255;
      slider.g = 0;
      slider.b = 0;
      
    }
    //Check if the mouse clicked on green
    else if(mouseX <= 64){
      red = false;
      green = true;
      blue = false;
      slider.r = 0;
      slider.g = 255;
      slider.b = 0;
    }
    //Check if the mouse clicked on blue
    else if(mouseX <= 96){
      red = false;
      green = false;
      blue = true;
      slider.r = 0;
      slider.g = 0;
      slider.b = 255;
    }
  }
}
void mouseReleased(){
  pressed = false;
}
