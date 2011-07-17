#include <NewSoftSerial.h>

NewSoftSerial softPort(6,7);

const char noDataAmt = 20;
const char reprintsAmt = 10;

unsigned char bufferArray[286];
unsigned char newlines = 0;
unsigned char i = 0;
unsigned char n;
unsigned char noData = noDataAmt;
unsigned char starcnt=0;
unsigned char reprints=0;
void setup()
{
  softPort.begin(57600); 
  Serial.begin(57600);
  Serial.println("Hello, WSB GPS Repeater Booted.");
  softPort.println("Hello, WSB GPS Repeater Booted.");

}



void loop()
{

  if(Serial.available())
  { 
    i = 0;
    starcnt = 0;
    while(starcnt<3){
      while(Serial.available())
      {
        bufferArray[i]=Serial.read();

        if (bufferArray[i-3]=='*') 
        {
          starcnt++;
        }
        i++;
      }
    }
    
  }

  for (reprints=0;reprints<reprintsAmt;reprints++) {
    for (n=0;n<i-1;n++)
    {
      softPort.print(bufferArray[n]);
    }
    delay(50);
  }

}






