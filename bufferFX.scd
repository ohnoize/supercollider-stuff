Buffer.freeAll;

s.boot;
s.reboot;
s.meter;
s.tree;
s.plotTree;

s.quit;

(
~b1.free;
~b1 = Buffer.alloc(s,44100*5,1, bufnum:0);
)




Buffer.freeAll;
~liveFXgroup.freeAll;

(

~mastergroup = Group.new(s);
~bufferFXgroup = Group.new(s);
~liveFXgroup = Group.new(s);

~master = Synth.head(~mastergroup, \masterfader);
~buffermaster = Synth.tail(~bufferFXgroup, \bufmaster);

)

~mastergroup.freeAll;



(
(
~b1 = Buffer.alloc(s,44100*5,1, bufnum:0);
~b2 = Buffer.alloc(s,44100*5,1, bufnum:1);
~b3 = Buffer.alloc(s,44100*5,1, bufnum:2);





(
SynthDef.new(\audioIn, {
	arg out=3;
	var sig, sig2;
	sig = AudioIn.ar(1);
	sig2 = AudioIn.ar(2);
	sig = sig + sig2;
	sig = Splay.ar(sig);
	Out.ar(out, sig);
}).add;
);


//Record to buffers

(
SynthDef(\recordnewbuf,{arg in=1, bufnum = 0; var inp, inp2;
	inp = AudioIn.ar(1);
	inp2 = AudioIn.ar(2);
	inp = inp + inp2;
	RecordBuf.ar(inp, bufnum);
	Line.kr(30,30,5,doneAction:2);
}).send(s);
);


//Playback synth with speed control

(
SynthDef.new(\playback, {
	arg rate = 1, bufnum=0, out=5;
	var sig, del;
	sig = PlayBuf.ar(1, bufnum, rate, loop:1, doneAction:2);
	del = CombC.ar(sig, 2, 1);
	del = del * 0.2;
	sig = sig + del;
	sig = Splay.ar(sig);
	Out.ar(out, sig);
}).add;
);



//Playback synth with pointer

(
SynthDef.new(\bufrd_noise, {
	arg amp = 1, out = 5, buf, start, end, rate = 1, freq = 1;
	var sig, ptr;
	ptr = LFDNoise1.ar(freq).range(start, end);
	sig = BufRd.ar(1, buf, ptr);
	sig = sig * amp;
	sig = Splay.ar(sig);
	Out.ar(out, sig);
}).add;
);

(
SynthDef.new(\dist, {
	arg out=5, in=5, rate=44100, bits=24;
	var sig;
	sig = In.ar(in, 2);
	sig = Decimator.ar(sig, rate, bits);
	sig = Splay.ar(sig);
	Out.ar(out, sig);
}).add;
);

(
SynthDef.new(\delay, {
	arg out=5, in=5, dtime=0.2, fback=2;
	var sig;
	sig = In.ar(in, 2);
	sig = AllpassC.ar(sig, 5, dtime, fback);
	sig = Splay.ar(sig);
	Out.ar(out, sig);
}).add;
);

(
SynthDef.new(\graintest, {
	arg trig=5, dur=5, rate=1, interp=4, pos=0, bufnum=0;
	var sig, pan;
	rate = LFNoise1.kr.range(0.01,5);
	pos = LFNoise2.kr(0.1).range(0,1);
	sig = GrainBuf.ar(1, Impulse.kr(trig), dur, bufnum, rate, pos, interp);
	sig = Splay.ar(sig);
	Out.ar(5, sig);
}).add;
);

SynthDef.new(\bufmaster, {
	arg out=3, in=5, amp=1;
	var sig;
	sig = In.ar(in, 2);
	sig = sig * amp;
	sig = Splay.ar(sig);
	Out.ar(out, sig);
}).add;
);



(
SynthDef.new(\masterfader, {
	arg out=0, in=3, amp=1;
	var sig;
	sig = In.ar(in, 2);
	sig = sig * amp;
	Out.ar(0, sig);
}).add;
);

//SET UP THE MASTER FADER!!




)



~grain = Synth.new(\graintest, [\bufnum, 2]);
~grain.set(\trig, 5, \dur, 5, \interp, 4);
~grain.free;

~b1.query;







