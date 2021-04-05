Buffer.freeAll;

s.reboot;
s.meter;


~b1 = Buffer.alloc(s,44100*10,1);
~b2 = Buffer.alloc(s,44100*10,1);
~b3 = Buffer.alloc(s,44100*10,1);

~b1.query;
~b2.query;
~b3.query;

//Record to buffers

(
SynthDef(\recordnewbuf,{arg in=1, bufnum = 0; var inp, inp2;
	inp = AudioIn.ar(2);
	RecordBuf.ar(inp, bufnum);
	Line.kr(30,30,10,doneAction:2);
}).send(s);
)

Synth.new(\recordnewbuf);

//Playback synth with speed control

(
SynthDef.new(\playback, {
	arg rate = 2, bufnum=0;
	var sig, del;
	sig = PlayBuf.ar(1, bufnum, rate, loop:1, doneAction:2);
	del = CombC.ar(sig, 2, 1);
	sig = sig + del;
	sig = Splay.ar(sig);
	Out.ar(0, sig);
}).add;
)

z = Synth.new(\playback, [\rate, 2]);
z.set(\rate, s.value);

//Playback synth with pointer

(
SynthDef.new(\bufrd_noise, {
	arg amp = 1, out = 0, buf, start, end, rate = 1, freq = 1;
	var sig, ptr;
	ptr = LFDNoise1.ar(freq).range(start, end);
	sig = BufRd.ar(1, buf, ptr);
	sig = sig * amp;
	sig = Splay.ar(sig);
	Out.ar(0, sig);
}).add;
)

x = Synth.new(\bufrd_noise, [\buf, 0, \start, 0, \end, b.numFrames - 1, \freq, 1]);
y = Synth.new(\bufrd_noise, [\buf, 0, \start, 0, \end, b.numFrames - 1, \freq, 1]);


x.set(\freq, 1);
y.set(\freq, 2);

(
w = Window.new("Buffer Rec/Playback").front;
b = Button(w, Rect(20, 20, 80, 20)).states_([["Record"]]).action_({Synth.new(\recordnewbuf)});
c = Button(w, Rect(100, 20, 80, 20)).states_([["Play"]]).action_({z = Synth.new(\playback)});
d = Button(w, Rect(180, 20, 80, 20)).states_([["Stop"]]).action_({z.free});
e = Button(w, Rect(100, 40, 80, 20)).states_([["Play"]]).action_({x = Synth.new(\bufrd_noise, [\buf, 0, \start, 0, \end, ~b1.numFrames - 1, \freq, 1])});
f = Button(w, Rect(180, 40, 80, 20)).states_([["Stop"]]).action_({x.free});
h = Button(w, Rect(100, 60, 80, 20)).states_([["Play"]]).action_({y = Synth.new(\bufrd_noise, [\buf, 0, \start, 0, \end, ~b1.numFrames - 1, \freq, 1])});
i = Button(w, Rect(180, 60, 80, 20)).states_([["Stop"]]).action_({y.free});
a = Slider(w, Rect(260, 20, 100, 20)).value_(0.5).step_(0.01).action_({z.set(\rate, 0.01 + a.value * 2)});
g = Slider(w, Rect(260, 40, 100, 20)).value_(0.5).step_(0.01).action_({x.set(\freq, 0.01 + g.value * 2)});
j = Slider(w, Rect(260, 60, 100, 20)).value_(0.5).step_(0.01).action_({y.set(\freq, 0.01 + j.value * 5)});

k = Button(w, Rect(20, 80, 80, 20)).states_([["Record"]]).action_({Synth.new(\recordnewbuf, [\bufnum, 1])});
l = Button(w, Rect(100, 80, 80, 20)).states_([["Play"]]).action_({v = Synth.new(\playback, [\bufnum, 1])});
m = Button(w, Rect(180, 80, 80, 20)).states_([["Stop"]]).action_({v.free});
n = Button(w, Rect(100, 100, 80, 20)).states_([["Play"]]).action_({u = Synth.new(\bufrd_noise, [\buf, 1, \start, 0, \end, ~b2.numFrames - 1, \freq, 1])});
o = Button(w, Rect(180, 100, 80, 20)).states_([["Stop"]]).action_({u.free});
p = Button(w, Rect(100, 120, 80, 20)).states_([["Play"]]).action_({~ab = Synth.new(\bufrd_noise, [\buf, 1, \start, 0, \end, ~b2.numFrames - 1, \freq, 1])});
q = Button(w, Rect(180, 120, 80, 20)).states_([["Stop"]]).action_({~ab.free});
r = Slider(w, Rect(260, 80, 100, 20)).value_(0.5).step_(0.01).action_({v.set(\rate, 0.01 + r.value * 2)});
~aa = Slider(w, Rect(260, 100, 100, 20)).value_(0.5).step_(0.01).action_({u.set(\freq, 0.01 + ~aa.value * 2)});
t = Slider(w, Rect(260, 120, 100, 20)).value_(0.5).step_(0.01).action_({~ab.set(\freq, 0.01 + t.value * 5)});

~kk = Button(w, Rect(20, 140, 80, 20)).states_([["Record"]]).action_({Synth.new(\recordnewbuf, [\bufnum, 2])});
~ll = Button(w, Rect(100, 140, 80, 20)).states_([["Play"]]).action_({~vv = Synth.new(\playback, [\bufnum, 2])});
~mm = Button(w, Rect(180, 140, 80, 20)).states_([["Stop"]]).action_({~vv.free});
~nn = Button(w, Rect(100, 160, 80, 20)).states_([["Play"]]).action_({~uu = Synth.new(\bufrd_noise, [\buf, 2, \start, 0, \end, ~b3.numFrames - 1, \freq, 1])});
~oo = Button(w, Rect(180, 160, 80, 20)).states_([["Stop"]]).action_({~uu.free});
~pp = Button(w, Rect(100, 180, 80, 20)).states_([["Play"]]).action_({~abb = Synth.new(\bufrd_noise, [\buf, 2, \start, 0, \end, ~b3.numFrames - 1, \freq, 1])});
~qq = Button(w, Rect(180, 180, 80, 20)).states_([["Stop"]]).action_({~abb.free});
~rr = Slider(w, Rect(260, 140, 100, 20)).value_(0.5).step_(0.01).action_({~vv.set(\rate, 0.01 + ~rr.value * 2)});
~aaa = Slider(w, Rect(260, 160, 100, 20)).value_(0.5).step_(0.01).action_({~uu.set(\freq, 0.01 + ~aaa.value * 2)});
~tt = Slider(w, Rect(260, 180, 100, 20)).value_(0.5).step_(0.01).action_({~abb.set(\freq, 0.01 + ~tt.value * 5)});

~ac = Button(w, Rect(180, 300, 80, 20)).states_([["STOP ALL"]]).action_({s.freeAll});
)