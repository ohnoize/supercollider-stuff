s.reboot;
s.plotTree;

(

(SynthDef.new(\echo, {
	arg feedback = 1, in = 0, out=3;
	var sig, sig2, local;
	sig = SoundIn.ar(in);

	local = LocalIn.ar(2)+sig.dup;

	5.do{local = AllpassN.ar(local, 1, Rand(0.001, 1), 5)};

	LocalOut.ar(local*0);

	Out.ar(out, sig+local);

}).add;
);

(SynthDef.new(\reverb, {
	arg feedback = 0.5, in=0, out=3;
	var sig, sig2, local;
	sig = SoundIn.ar(in);
	local = LocalIn.ar(2)+sig.dup;

	15.do{local = AllpassN.ar(local, 0.06, Rand(0.001, 0.06), 3)};

	LocalOut.ar(local*feedback);

	Out.ar(out, sig+local);

}).add;
);

(
SynthDef.new(\pitchgrain, {
	arg in=0, out=3;
	var sig, sig2;
	sig = SoundIn.ar(in);
	sig = PitchShift.ar(
		sig,
		5,
		1,
		LFNoise1.kr.range(0.01,5),
		LFNoise1.kr.range(0.01,5)
	);
	sig = Pan2.ar(sig, LFNoise1.kr(2).range(-1, 1));
	sig = sig * 2;
	Out.ar(out, sig);
}).add;
);

(
SynthDef.new(\pitchshift, {
	arg in=0, out=3, rate=0.5;
	var sig, sig2;
	sig = SoundIn.ar(in);
	sig = PitchShift.ar(
		sig,
		0.1,
		rate,
		0,
		0.004
	);
	sig = Splay.ar(sig);
	Out.ar(out, sig);
}).add;
);

(
SynthDef.new(\audioThru, {
	arg out=3, amp=1, in=0;
	var sig, sig2;
	sig = SoundIn.ar(in);
	sig = sig*amp;
	sig = Splay.ar(sig);
	Out.ar(out, sig);
}).add;
);

(
SynthDef.new(\bitcrush, {
	arg out=3, amp=1, in=0, rate=10000, bits=16;
	var sig;
	sig = SoundIn.ar(in);
	sig = Decimator.ar(sig, rate, bits, 0.5);
	sig = Splay.ar(sig);
	Out.ar(out, sig);
}).add;
);
)

Synth.new(\pitchshift, [\rate, 2]);