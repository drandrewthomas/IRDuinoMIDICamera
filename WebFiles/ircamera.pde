"use strict";

var amg=new AMG8833Lib();
int ch,v1,v2,ambient;
int cpixels[]=new int[64];
boolean shownumbers=true;
boolean cameraforward=true;
boolean dodownload=false;
int smin,smax,downloads=1;

void setup()
{
  int c;
  var canvas=document.getElementById("pjscanvas");
  size(480,320,P2D);
  amg.begin();
  for(c=0;c<64;c++) cpixels[c]=0;
  background(255,255,255);
}

void draw()
{
  int mnum;
  midiMessage mm;
  while(amg.available()>0)
  {
    mm=amg.read();
    ch=mm.channel;
    v1=mm.val1;
    v2=mm.val2;
    if(ch==14)
    {
      mnum=v2;
      if(mnum==0) ambient=v1;
      else
      {
        if(mnum==99)
        {
          drawpixels();
          if(dodownload==true) downloadimage();
        }
        else if(mnum>=1 && mnum<=64) cpixels[mnum-1]=v1;
      }
    }
  }
}

void calcminmax()
{
  int c,mn,mx;
  mn=999;
  mx=-999;
  for(c=0;c<64;c++)
  {
    if(cpixels[c]>mx) mx=cpixels[c];
    if(cpixels[c]<mn) mn=cpixels[c];
  }
  smin=0;
  if(mx<=80) smax=80;
  if(mx<=60) smax=60;
  if(mx<=40) smax=40;
}

void drawscale()
{
  int c,r,g,b;
  noStroke();
  fill(0,0,0);
  textSize(25);
  textAlign(CENTER,CENTER);
  text(smax+" C",355,20);
  text(smin+" C",355,305);
  textSize(20);
  text("Ambient:",430,175);
  text(ambient+" C",430,205);
  for(c=0;c<240;c++)
  {
    r=map(c,0,239,0,255);
    g=0;
    b=map(c,0,239,255,0);
    stroke(r,g,b);
    line(348,282-c,362,282-c);
  }
}

void drawbuttons()
{
  stroke(0,0,255);
  strokeWeight(3);
  noFill();
  rect(385,60,90,30,8);
  rect(385,105,90,30,8);
  rect(385,240,90,30,8);
  fill(0,0,255);
  textSize(15);
  if(shownumbers==true)   text("Numbers",430,75);
  else                    text("Colours",430,75);
  if(cameraforward==true) text("Forward",430,120);
  else                    text("Selfie",430,120);
  text("Save",430,255);
}

void mouseReleased()
{
  if(mouseX>=385 && mouseX<=475 && mouseY>=60 && mouseY<=90)
  {
    if(shownumbers==true) shownumbers=false;
    else                  shownumbers=true;
  }
  if(mouseX>=385 && mouseX<=475 && mouseY>=105 && mouseY<=135)
  {
    if(cameraforward==true) cameraforward=false;
    else                    cameraforward=true;
  }
  if(mouseX>=385 && mouseX<=475 && mouseY>=255 && mouseY<=285)
  {
    dodownload=true;
  }
}

void drawpixels()
{
  int r,g,b,x,y,ind;
  calcminmax();
  background(255,255,255);
  for(x=0;x<8;x++)
  {
    for(y=0;y<8;y++)
    {
      if(cameraforward==true) ind=((7-y)*8)+(7-x);
      else ind=((7-y)*8)+x;
      r=map(constrain(cpixels[ind],smin,smax),smin,smax,0,255);
      g=0;
      b=map(constrain(cpixels[ind],smin,smax),smax,smin,0,255);
      stroke(150,150,150);
      strokeWeight(1);
      fill(r,g,b);
      rect(x*40,y*40,40,40);
      if(shownumbers==true)
      {
        noStroke();
        fill(0,0,0);
        textSize(15);
        textAlign(CENTER,CENTER);
        text(cpixels[ind],(x*40)+20,(y*40)+20);
      }
    }
  }
  drawscale();
  drawbuttons();
}

void downloadimage()
{
  dodownload=false;
  var pic=document.getElementById('pjscanvas').toDataURL('image/jpeg');
  var dl=document.createElement('a');
  dl.href=pic;
  dl.download="ircamera_"+downloads+".jpg";
  document.body.appendChild(dl);
  dl.click();
  downloads++;
}
