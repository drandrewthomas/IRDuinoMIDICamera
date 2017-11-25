"use strict";

var midiMessage=function(tp,tm,ch,v1,v2)
{
  this.type=tp;
  this.timer=tm;
  this.channel=ch;
  this.val1=v1;
  this.val2=v2;
};

var AMG8833Lib=function()
{
  this.buffer=[];

  this.begin=function()
  {
    if(navigator.requestMIDIAccess)
    {
  	  navigator.requestMIDIAccess({sysex: false}).then(this.success.bind(this),this.failure.bind(this));
      return true;
    }
    else return false;
  };

  this.success=function(midiAccess)
  {
    var inputs=midiAccess.inputs.values();
    for(var input=inputs.next(); input && !input.done; input=inputs.next())
    {
      input.value.onmidimessage=this.midimessage.bind(this);
    }
    midiAccess.onstatechange=this.statechanged.bind(this);
  };

  this.failure=function(event)
  {
    console.log("MIDI failed!");
    this.mlmidi=null;
  };

  this.midimessage=function(event)
  {
    var data,cmd,channel,type,val1,val2;
    data=event.data,
    cmd=data[0]>>4,
    channel=data[0] & 0xf,
    type=data[0] & 0xf0,
    val1=data[1],
    val2=data[2];
    switch(type)
    {
      case 144: this.noteon(channel,val1,val2); break;
      case 128: this.noteoff(channel,val1,val2); break;
      case 176: this.controlchange(channel,val1,val2); break;
    }
  };

  this.noteon=function(ch,nt,vel)
  {
    this.addtobuffer(0,0,ch,nt,vel);
  };

  this.noteoff=function(ch,nt,vel)
  {
    this.addtobuffer(1,0,ch,nt,vel);
  };

  this.controlchange=function(ch,id,val)
  {
    this.addtobuffer(2,0,ch,id,val);
  };

  this.statechanged=function(event)
  {
  };

  this.available=function()
  {
    return this.buffer.length;
  };

  this.addtobuffer=function(tp,tm,ch,v1,v2)
  {
    var it=new midiMessage(tp,tm,ch,v1,v2);
    this.buffer.push(it);
  };

  this.read=function()
  {
    return this.buffer.shift();
  };

};
