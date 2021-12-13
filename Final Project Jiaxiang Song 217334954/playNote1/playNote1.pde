
// import everything necessary to make sound.
import ddf.minim.*;
import ddf.minim.ugens.*;

// create all of the variables that will need to be accessed in
// more than one methods (setup(), draw(), stop()).
Minim minim;
AudioOutput out;

Oscil      wave;
Frequency  currentFreq;


Midi2Hz midi;

HScrollbar hs1, hs2;

final float[] frequencies = {
  523.25, // C 
  554.37, // C sharp
  587.33, // D
  622.25, // D sharp
  659.26, // E
  698.46, // F
  739.99, // F sharp
  783.99, // G
  830.61, // G sharp
  880.00, // A
  932.33, // A sharp
  987.77, // B
};
final float[] notes= {
   50,52,54,55,57,59,61

};
float gain1=1.7;
float gain2;
//background
PImage back;
float angle=60;
void setup()
{

  size(1920, 1080,P3D);
   back = loadImage("b.jpg");

  minim = new Minim(this);
  out   = minim.getLineOut();

  currentFreq = Frequency.ofPitch( "A4" );
  wave = new Oscil( 300, 0.6f, Waves.SINE );
  midi = new Midi2Hz( 50 );
  midi.patch( wave.frequency );
  wave.patch( out );

   hs1 = new HScrollbar(width-400, height/4, 400, 20, 20);
   hs2 = new HScrollbar(width-400, height/2, 400, 20, 20);
  
}


void draw()
{

  background(0);
  image(back,0,0);

  
  text( "Current Frequency in Hertz: " + currentFreq.asHz(), 5, 15 );
  text( "Current Frequency as MIDI note: " + currentFreq.asMidiNote(), 5, 30 );
  
   //get poc of scrollbar
  float Pos1 = hs1.getPos();
  float Pos2 = hs2.getPos();
  gain1= map( hs1.getPos(), width-400, width, 1, 1.7);
  gain2= map( hs2.getPos(), width-400, width, -64, 6);
  //println(gain2);
  out.setGain(gain2);
  // draw the waveforms
  for( int i = 0; i < out.bufferSize() - 1; i++ )
  {
    // find the x position of each buffer value
    float x1  =  map( i, 0, out.bufferSize(), 0, width );
    float x2  =  map( i+1, 0, out.bufferSize(), 0, width );
    // draw a line from one buffer position to the next for both channels
    line( x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
    line( x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
  }  
  
 
  //show scrollbar
  hs1.update();
  hs2.update();
  hs1.display();
  hs2.display();
  
  showBox();
}

void keyPressed()
{
 if ( key == 'z' ) {midi.setMidiNoteIn( gain1*notes[0] );angle=gain1*notes[0];}
  if ( key == 'x' ) {midi.setMidiNoteIn( gain1*notes[1] );angle=gain1*notes[1];}
  if ( key == 'c' ){ midi.setMidiNoteIn( gain1*notes[2] );angle=gain1*notes[2];}
  if ( key == 'v' ) {midi.setMidiNoteIn(gain1* notes[3] );angle=gain1*notes[3];}
  if ( key == 'b' ){ midi.setMidiNoteIn( gain1*notes[4] );angle=gain1*notes[4];}
  if ( key == 'n' ){ midi.setMidiNoteIn( gain1*notes[5] );angle=gain1*notes[5];}
  if ( key == 'm' ) {midi.setMidiNoteIn( gain1*notes[6] );angle=gain1*notes[6];}
 

 println(angle);
}
//void keyPressed() {
//  int selector = piano.indexOf(key);
//  if ((selector != -1) && (activeKeys[selector] == false)) {
//    waves[selector].patch(out);
//    activeKeys[selector] = true;
//  }
//}

//void keyReleased() {
//  int selector = piano.indexOf(key);
//  if (selector != -1) {
//    activeKeys[selector] = false;
//    waves[selector].unpatch(out);
//  }
//}

void showBox(){
translate(width/2, height/2);
rotateY(frameCount*PI/angle/2);
rotateX(frameCount*PI/angle/2);
fill(255, 0, 0);
strokeWeight(2);
stroke(0,255,0);
box(200, 200, 200);

}
