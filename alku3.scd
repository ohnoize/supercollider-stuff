~b1 = Buffer.read(s, "/Users/ollihirvonen/Music/bryars.wav");
~b1.play;

s.boot;

~b1.numFrames;
~bi.numChannels;

~b1.duration;
~b1.sampleRate;

~b1.query;

~b2 = Buffer.read(s, "/Users/ollihirvonen/Documents/MSM/Electronic Music/Sounds/Close/STE-003.wav");

~b2.query;

~b1.play;
~b2.play;

~derek = Array.new;
~folder = PathName.new("/Users/ollihirvonen/Music/Electronic Music/Derek/");

(
~folder.entries.do({
	arg path;
	~derek = ~derek.add(Buffer.read(s, path.fullPath));
})
)
(
~derek.at(1).play;
~derek.at(2).play;
~derek.at(3).play;
~derek.at(4).play;
~derek.at(5).play;
~derek.at(6).play;
~derek.at(7).play;
~derek.at(8).play;
~derek.at(9).play;
)

~derek[1].query;


(
SynthDef.new(\playBuf_test, {
	arg amp = 1, out = 0, buf, da=2, rate=1, loop=0, t_trig, start=0;
	var sig;
	sig = PlayBuf.ar(1, buf, rate, t_trig, start, loop:loop, doneAction:0);
	sig = sig * amp;
	Out.ar(0, sig);
}).add;
)

Synth.new(\playBuf_test, [\buf, ~b1.bufnum, \rate, -1, \start, ~b1.numFrames - 2]);

s.plotTree;

g = Group.new;

(
x = Synth.new(\playBuf_test, [\buf, ~derek[5].bufnum, \rate, 5.midiratio, \loop, 1], g);
y = Synth.new(\playBuf_test, [\buf, ~derek[6].bufnum, \rate, 1, \loop, 1], g);
z = Synth.new(\playBuf_test, [\buf, ~derek[7].bufnum, \rate, -5.midiratio, \loop, 1], g);
k = Synth.new(\playBuf_test, [\buf, ~derek[9].bufnum, \rate, -7.midiratio, \loop, 1], g);
)

g.set(\rate, 0.5);
x.set(\buf, ~derek[1, 2].bufnum);
x.set(\rate, exprand(1, 12).midiratio);
y.set(\rate, exprand(1, 12).midiratio);
z.set(\rate, exprand(1, 12).midiratio);
k.set(\rate, exprand(1, 12).midiratio);

x.free;
y.free;
z.free;
k.free;

s.reboot;

(
SynthDef.new(\bufrd_noise, {
	arg amp = 1, out = 0, buf, start, end, rate = 1, freq = 1;
	var sig, ptr;
	ptr = LFDNoise1.ar(freq).range(start, end);
	sig = BufRd.ar(2, buf, ptr);
	sig = sig * amp;
	Out.ar(0, sig);
}).add;
)

x = Synth.new(\bufrd_noise, [\buf, ~b2, \start, 0, \end, ~b2.numFrames - 1, \freq, 1]);

y = Synth.new(\bufrd_noise, [\buf, ~b1, \start, 0, \end, ~b1.numFrames - 1, \freq, 1]);

x.set(\freq, 1);
y.set(\freq, 0.05);

x.set(\start, ~b1.numFrames/2, \end, ~b1.numFrames - 1);
x.set(\start, 200, \end, 30000);
x.set(\rate, 1);
x.free;
y.free;

x = Synth.new(\bufrd_noise, [\buf, b, \start, 0, \end, ~b2.numFrames - 1, \freq, 20]);
y = Synth.new(\bufrd_noise, [\buf, ~b1, \start, 0, \end, ~b1.numFrames - 1, \freq, 10]);

x.set(\freq, 10);
y.set(\freq, 10);


RecordBuf

BufWr

(
SynthDef.new(\input, {
	arg out=0, in=0;
	var input;
	input = In.ar(in, 1);
	Out.ar(out, input);
}).add;
)

x = Synth.new(\input);
s.meter;
s.boot;

Buffer.freeAll;

(
SynthDef.new(\input,
	{
		arg out = 0;
		var sig;
		sig = AudioIn.ar(1);
		sig = Splay.ar(sig);
		Out.ar(out, sig);
}).play;
)

~b0 = Buffer.alloc(s, 44100 * 10, 1);

s.boot;
(
SynthDef(\record, {
	arg out = 0, bufnum = 0;
	var sig, sig1;
	sig = SoundIn.ar(0);
	sig1 = CombC.ar(sig, 2, LFNoise1.kr(0.5, 0.99, 1));
	sig = sig + sig1 * 0.5;
	sig = Splay.ar(sig);
	Out.ar(0, sig);
}).add;
)

Synth.new(\record);

~soi.play;

~something.query;


~b0.query;

~b0.play;

In

a = {SinOsc.ar(LFNoise0.kr(5, 500, 600))}.play;
b = {CombC.ar(a, 2, LFNoise1.kr(0.5, 0.99, 1))}.play;


({
a=SinOsc.ar(LFNoise0.kr(5, 500, 600));
b=CombC.ar(a,2,1);
FreeVerb.ar(a+b)!2;
}.play;
)

Server.default.makeGui
Server.default.makeGui;

s.boot;
b= {Buffer.alloc(s, 44100 * 4.0, 1)}.dup(10); //create 10 buffers in an array

(
SynthDef(\help_RecordBuf, { | inbus, bufnum = 0, trigger = 0|
        inbus= SoundIn.ar;	//temp testing - remove later
        RecordBuf.ar(inbus, bufnum, run: trigger, trigger: trigger, loop: 0, doneAction: 2);
}).add;
)
(
SynthDef(\playback, { | bufnum = 0, trigger = 0, atk= 0.01, rel= 0.1|
        var env= EnvGen.ar(Env.linen(atk, BufDur.ir(bufnum)-atk-rel, rel), doneAction:2);
        var src= PlayBuf.ar(1, bufnum);
        Out.ar(0, Pan2.ar(src*env));
}).add;
)

Synth.new(\playback);

Buffer.freeAll;

b = Buffer.alloc(s,44100*30,1);
c = Buffer.alloc(s,44100,1);
d = Buffer.alloc(s,44100*30,1);

(
SynthDef(\recordnewbuf,{arg in=1, bufnum = 0; var inp, inp2;
	inp = AudioIn.ar(2);
	RecordBuf.ar(inp, bufnum);
	Line.kr(30,30,10,doneAction:2);
}).send(s);
)

Synth.new(\recordnewbuf);

(
SynthDef.new(\playback, {
	arg sig, del;
	sig = PlayBuf.ar(1, 0);
	del = CombC.ar(sig, 2, 1);
	sig = sig + del;
	sig = Splay.ar(sig);
	Out.ar(0, sig);
}).add;
)

Synth.new(\playback);


b.play;
b.free;




