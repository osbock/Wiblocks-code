// Game of Life for Wiblocks LED charlieplexed 
// display.
//   Kevin Osborn -- http://baldwisdom.com
//   released into the public domain

extern "C" 
{
#include <avr/IO.H>
#include <PICO1TR.h>
#include <PICO1TR_LED_S.h>
}

#define ROWS 10
#define COLS 10
#define FRAMEBYTES 13
#define DBUG(s,x) Serial.print(s);Serial.println(x);
//ok, this is flexible up to a point. The representation of the life
//board is a bitmap made up of unsigned ints.
// Three generations so we can see if we are repeating
uint8_t Gameboards[3][FRAMEBYTES];
void setup() { 
  Serial.begin(19200);
  randomSeed(analogRead(0));
  led_init(50); // 100uS on-time (min)
  clearGeneration(0);
  clearGeneration(1);
  clearGeneration(2);
  randomizeGeneration(0);
}
int currentgen =0;
long lastupdate=0;
#define GENTIME 300
long gencount =0;
#define RESETGENS 50
void loop() {
  led_output_frame(Gameboards[currentgen]);
  long currenttime = millis();
  
  if((currenttime-lastupdate)>GENTIME){
    if (gencount++ >RESETGENS) // next rev, we'll compare to two generations ago to see if we are static
      randomizeGeneration(currentgen);
    currentgen=(currentgen+1)%3;
    clearGeneration(currentgen);// clear the working space
    updateBoards();
    lastupdate = currenttime;
  }
 
}

void updateBoards()
{
  for (int i =0; i < COLS; i++)
    for (int j=0; j < ROWS; j++)
      updateCell(i,j,currentgen);
} 

void updateCell(int i,int j, int gen){
  int neighbors =0;
  int last = (gen-1)< 0?2:gen-1; 
  
 
  neighbors = testCell(i,j-1,last); //north

  neighbors += testCell(i+1,j-1,last); //northeast

  neighbors += testCell(i+1,j,last); //east

  neighbors += testCell(i+1,j+1,last); //southeast
 
  neighbors += testCell(i, j+1,last); //south

  neighbors += testCell(i-1,j+1,last); //southwest

  neighbors += testCell(i-1,j,last); //west

  neighbors += testCell(i-1,j-1,last); //northweast

  
  //rules: if the curent cell is live
  if (bitread(i,j,last)){
    if (neighbors >=2 && neighbors <=3) // has 2 or 3 neighbors
    bitwrite(i,j,1,gen); //let it live 
  }
  else //Cell is dead
    if (neighbors == 3) //some kind of midwife?
      bitwrite(i,j,1,gen);
}

int testCell(int i, int j, int gen){
  if ((i<0) || (i >= COLS)) return 0; //off the edge. could handle wrap here
  if ((j<0) || (j >= ROWS)) return 0;
  return (int) bitread(i,j,gen);
}
void clearGeneration(int i){
  for (int j=0;j <FRAMEBYTES; j++)
      Gameboards[i][j]=0;
}
void randomizeGeneration(int gen){
    for (int i = 0; i < 13;i++)
    Gameboards[gen][i]=random(255);
}
void bitwrite(int x,int y,uint8_t val,int gen)
{
  // 0,0 is in the upper left
  //determine what bit in the whole stream
  int bitnum = y*COLS+x;

  int bitbyte = bitnum/8;
  int posbyte = 8-(bitnum %8);

  if (val ==0)
     Gameboards[gen][bitbyte]= Gameboards[gen][bitbyte] & ~(1<<(posbyte-1));
  else
    Gameboards[gen][bitbyte]= Gameboards[gen][bitbyte] |(1<<(posbyte-1));
}
uint8_t bitread(int x,int y,int gen)
{
  // 0,0 is in the upper left
  //determine what bit in the whole stream

  int bitnum = y*COLS+x;

  int bitbyte = bitnum/8;
  int posbyte = 8-(bitnum %8);
  return ((Gameboards[gen][bitbyte] & (1<<(posbyte-1)))==0?0:1);
}

