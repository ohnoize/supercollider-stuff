s.boot;
s.nodeTree;

(
SynthDef.new(\bussi, {
	arg out=0;
	var sig;
	sig = SinOsc.ar(220);
	Out.ar(out, sig);
}).add;
)

(
SynthDef.new(\dist, {
	arg out=0, in=0, rate=44100, bits=24;
	var sig;
	sig = In.ar(in, 1);
	sig = Decimator.ar(sig, MouseX.kr(10, 1000), bits);
	sig = Splay.ar(sig);
	sig = sig * 0.1;
	Out.ar(out, sig);
}).add;
)

y = Synth(\bussi, [\out, 6]);
a = Synth.after(y, \dist, [\out, 0, \in, 6, \rate]);

a.set(\rate, 5000, \bits, 5);


(
SynthDef("help-PinkNoise", { arg out=0;
    Out.ar(out, PinkNoise.ar(0.1))
}).send(s);
)

(
SynthDef("help-In", { arg out=0, in=0;
    var input;
        input = In.ar(in, 1);
        Out.ar(out, input);

}).send(s);
)

x = Synth("help-PinkNoise", [\out, 3]);
Synth.after(x, "help-In", [\out, 0, \in, 3]);
