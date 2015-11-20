int offline_colour = 0;

import processing.serial.*; 
import ddf.minim.*;

Minim minim;
AudioPlayer player1;
AudioPlayer player2;
int d1, d2, val;
Serial mega;
int t=1;
float pty;
int a_prev_x = 0;
float a_prev_y = 0;
int b_prev_x = 0;
float b_prev_y = 0;
int c_prev_x = 0;
float c_prev_y = 0;
int d_prev_x = 0;
float d_prev_y = 0;
boolean lsa, rsa, lmc, rmc;
int a_val=0;
int b_val=0;
int c_val=0;
int d_val=0;


//int inbyte;
void setup()
{
  size(1800, 900);
  print(Serial.list());
  mega = new Serial(this, Serial.list()[0], 4800);
  grid();
  flusher();
  flusher();
  flusher();
  flusher();
  flush2();
  minim = new Minim(this);
  player1 = minim.loadFile("alarm1.mp3");
  //  player1.play(); //Spring
  player2 = minim.loadFile("alarm2.mp3");
  //  player2.play(); //Siren
}


void draw()
{
  if (t==0)
  {
    grid();
    t=1;
    a_prev_x = 0;
    a_prev_y = 0;
    b_prev_x = 0;
    b_prev_y = 0;
    c_prev_x = 0;
    c_prev_y = 0;
    d_prev_x = 0;
    d_prev_y = 0;
  }
  
  get_a();
  //  print(" a=");
  //  print(val);
  //  print(" ");
  get_b();
  //  print(" b=");
  //  print(val);
  //  print(" ");
  get_c();
  //  print(" c=");
  //  print(val);
  //  print(" ");
  get_d();
  //  print(" d=");
  //  print(val);
  //  print(" ");
  sound_handler();
  t++;
  if (t>900)
  {
    t=0;
    grid ();
  }
}



void grid()
{
  background(0); 
  stroke(255);
  line(900, 0, 900, 900); // Divider
  line(0, 450, 1800, 450); // Divider
  stroke(255, 255, 0);
  line(0, 225, 1800, 225); // Divider
  line(0, 675, 1800, 675); // Divider
  textSize(26);
  fill(238, 130, 10);
  text("LEFT ENGINE SPEED", 310, 435);
  text("LEFT ENGINE POWER", 310, 885);
  text("RIGHT ENGINE SPEED", 1210, 435);
  text("RIGHT ENGINE POWER", 1210, 885);
}


void disp ()
{
  print ("d1="); 
  print (d1);
  print (" "); 
  print ("d2="); 
  print (d2); 
  print (" ");
  print ("Val=");
  print (val); 
  print (" ");
}



void mousePressed() {
  print("X= ");
  print (mouseX);
  print(" ");
  print("Y= ");
  print (mouseY);
  print(" ");
}

void get_a()
{
  // Getting A
  mega.write("a");
  while (mega.available () < 0);
  d1 = mega.read();
  while (mega.available () < 0);
  d2 = mega.read();

  d1 = d1-48;
  d2 = d2-48;




  val = d1 * 10 + d2;
  //  disp();
print("  A=");
print (val);
print(" ");
if (val > 0)
{
  a_val = val;
}

  pty = map(a_val, 0, 100, 0, 450);
  if ( val < 25) // Left Engine Stall
  {
    lsa = true;
    // player1.loop();
    stroke(255, 0, 0);
    noFill();
    rect(680, 400, 190, 45, 7);
    fill(255, 0, 0);
    textSize(26);
    text("STALL ALERT", 700, 435);
  } else
  {
    lsa = false;
    //  player1.pause();
    stroke(0, offline_colour, 0);
    noFill();
    rect(680, 400, 190, 45, 7);
    fill(0, offline_colour, 0);
    textSize(26);
    text("STALL ALERT", 700, 435);
    stroke(0, 255, 0);
  }


  // DRAWING !!
  //print(" A=");
  //print(val);
  //print(" ");

  // point(t, pty);
  line (a_prev_x, a_prev_y, t, pty);
  a_prev_x = t;
  a_prev_y = pty;
}

void get_b()
{
  mega.write("b");
  while (mega.available () < 0);
  d1 = mega.read();
  while (mega.available () < 0);
  d2 = mega.read();

  d1 = d1-48;
  d2 = d2-48;




  val = d1 * 10 + d2;
  if (val > 0)
{
  b_val = val;
}

  //  disp();
print("  B=");
print (val);
print(" ");


  pty = map(b_val, 0, 100, 0, 450);
  if ( val < 25) // Right Engine Stall
  {
    rsa = true;
    // player1.loop();
    stroke(255, 0, 0);
    noFill();
    rect(1600, 400, 190, 45, 7);
    fill(255, 0, 0);
    textSize(26);
    text("STALL ALERT", 1620, 430);
  } else
  {
    rsa = false;
    // player1.pause();
    stroke(0, offline_colour, 0);
    noFill();
    rect(1600, 400, 190, 45, 7);
    fill(0, offline_colour, 0);
    textSize(26);
    text("STALL ALERT", 1620, 430);
    stroke(0, 255, 0);
  }


  // DRAWING !!
  //print(" B=");
  //print(val);
  //print(" ");

  // point(t, pty);
  line (b_prev_x+900, b_prev_y, t+900, pty);
  b_prev_x = t;
  b_prev_y = pty;
}

void flusher()
{
  mega.write("a");
  while (mega.available () < 0);
  while (mega.available ()>0)
    d1 = mega.read();
  while (mega.available () < 0);
  while (mega.available ()>0)
    d2 = mega.read();
}

void get_c()
{
  mega.write("c");
  while (mega.available () < 0);
  d1 = mega.read();
  while (mega.available () < 0);
  d2 = mega.read();

  d1 = d1-48;
  d2 = d2-48;




  val = d1 * 10 + d2;
  //  disp();
  if (val > 0)
{
  c_val = val;
}

print("  C=");
print (val);
print(" ");

  pty = map(c_val, 0, 100, 0, 450);
  if (val > 75) // Left Engine Surge
  {
    lmc = true;
    //   player2.loop();
    stroke(255, 0, 0);
    noFill();
    rect(630, 850, 260, 45, 7);
    fill(255, 0, 0);
    textSize(26);
    //    text("STALL ALERT", 700, 880);
    text("MASTER CAUTION", 650, 880);
  } else
  {
    lmc = false;
    //    player2.pause();
    stroke(0, offline_colour, 0);
    noFill();
    rect(630, 850, 260, 45, 7);
    fill(0, offline_colour, 0);
    textSize(26);
    //    text("STALL ALERT", 700, 880);
    text("MASTER CAUTION", 650, 880);
    stroke(0, 255, 0);
  }


  // DRAWING !!
  //print(" B=");
  //print(val);
  //print(" ");

  // point(t, pty);
  line (c_prev_x, c_prev_y+450, t, pty+450);
  c_prev_x = t;
  c_prev_y = pty;
}



void get_d()
{
  mega.write("d");
  while (mega.available () < 0);
  d1 = mega.read();
  while (mega.available () < 0);
  d2 = mega.read();

  d1 = d1-48;
  d2 = d2-48;




  val = d1 * 10 + d2;
  //  disp();
  if (val > 0)
{
  d_val = val;
}

print("  D=");
print (val);
print(" ");


  pty = map(d_val, 0, 100, 0, 450);
  if (val > 75) // Right Engine Surge
  {
    rmc = true;
    //    player2.loop();
    stroke(255, 0, 0);
    noFill();
    rect(1540, 850, 255, 45, 7);
    fill(255, 0, 0);
    textSize(26);
    //    text("STALL ALERT", 1620, 880);
    text("MASTER CAUTION", 1560, 880);
  } else
  {
    rmc = false;
    //    player2.pause();
    stroke(0, offline_colour, 0);
    noFill();
    rect(1540, 850, 255, 45, 7);
    fill(0, offline_colour, 0);
    textSize(26);
    //    text("STALL ALERT", 1620, 880);
    text("MASTER CAUTION", 1560, 880);
    stroke(0, 255, 0);
  }


  // DRAWING !!
  //print(" B=");
  //print(val);
  //print(" ");

  // point(t, pty);
  line (d_prev_x+900, d_prev_y+450, t+900, pty+450);
  d_prev_x = t;
  d_prev_y = pty;
}


void flush2()
{
  int k;

  for (int i=0; i<1000; i++)
  {
    k =  mega.read();
    //    print(k);
  }
}



void stop()
{
  player1.close();
  player2.close();
  minim.stop();
  super.stop();
}


boolean p_lsa=false;
boolean p_rsa=false;
boolean p_lmc=false;
boolean p_rmc=false;


void sound_handler()
{
  if (p_lsa != lsa || p_rsa != rsa)
  {
    //   print("CCC");
    if (lsa || rsa)
    {
      player1.loop();
    } else
    {
      player1.pause();
    }

    p_lsa = lsa;
    p_rsa = rsa;
  }

  if (p_lmc != lmc || p_rmc != rmc)
  {
    //   print("CCC");
    if (lmc || rmc)
    {
      player2.loop();
    } else
    {
      player2.pause();
    }

    p_lmc = lmc;
    p_rmc = rmc;
  }
}

