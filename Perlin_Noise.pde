NoiseElement[] elements; 
color[] colors =  {#77c39c, #2f5e36, #55aba5, #2d7063, #3f6829, #44a872, #215964, #cdedae}; 
ColorPicker cp;
int moveScale = 50;
int N_ELEMENTS = 300; 

class NoiseElement {
  private color c;
  private PVector pos;
  float speed; 
  PShape image; 

  NoiseElement(color c, float x, float y, float speed) {
    this.c = c; 
    this.pos = new PVector(x, y);
    this.speed = speed;
    this.image = createShape(ELLIPSE, this.get_x(), this.get_y(), 2, 2); 
    this.image.setFill(this.c);
  }

  void update_pos() {
    float transform_angle = noise(this.pos.x / moveScale, this.pos.y / moveScale) * TWO_PI * moveScale; 
    this.pos.x = cos(transform_angle) * this.speed;
    this.pos.y = sin(transform_angle) * this.speed;  
    this.image.translate(this.pos.x, this.pos.y);

    //Detect if left the screen 
    if (this.get_x() > width || this.get_x() < 0 || this.get_y() > height || this.get_y() < 0 || random(1) < 0.001 ) {
      this.pos.x = random(width);
      this.pos.y = random(height);
    }


  }

  void render() {


    shape(this.image);
  }

  float get_x() {
    return this.pos.x;
  }

  float get_y() {
    return this.pos.y;
  }
}

class ColorPicker {
  color[] colors;

  ColorPicker(color[] colors) {
    this.colors = colors;
  }

  color get_color() {
    return this.colors[floor(random(this.colors.length))];
  }
}


void setup() {
  color cc = #cdedae;
  print(cc); 

  size(1000, 1000, P2D);
  background(#162a25);
  noStroke();

  elements = new NoiseElement[N_ELEMENTS]; 
  cp = new ColorPicker(colors); 


  for (int i = 0; i < N_ELEMENTS; i++) {

    float x = random(width);
    float y = random(height); 
    color c = cp.get_color(); 
    elements[i]=new NoiseElement(c, x, y, random(4));
  }
}


void draw() {
  for (int i = 0; i < N_ELEMENTS; i++) {
    NoiseElement elem = elements[i]; 
    elem.update_pos();   
    elem.render();
  }
}
