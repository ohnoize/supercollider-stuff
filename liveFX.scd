s.reboot;
s.plotTree;

(

(SynthDef.new(\echo, {
	arg feedback = 1;
	var sig, sig2, local;
	sig = SoundIn.ar(0);
	sig2 = SoundIn.ar(1);
	sig = sig + sig2;
	local = LocalIn.ar(2)+sig.dup;

	5.do{local = AllpassN.ar(local, 1, Rand(0.001, 1), 5)};

	LocalOut.ar(local*0);

	Out.ar(3, sig+local);

}).add;
);

(SynthDef.new(\reverb, {
	arg feedback = 0.5;
	var sig, sig2, local;
	sig = SoundIn.ar(0);
	sig2 = SoundIn.ar(1);
	sig = sig + sig2;
	local = LocalIn.ar(2)+sig.dup;

	15.do{local = AllpassN.ar(local, 0.06, Rand(0.001, 0.06), 3)};

	LocalOut.ar(local*feedback);

	Out.ar(3, sig+local);

}).add;
);

(
SynthDef.new(\pitchgrain, {
	arg in=0, out;
	var sig, sig2;
	sig = SoundIn.ar(0);
	sig2 = SoundIn.ar(1);
	sig = sig + sig2;
	sig = PitchShift.ar(
		sig,
		5,
		1,
		LFNoise1.kr.range(0.01,5),
		LFNoise1.kr.range(0.01,5)
	);
	sig = Pan2.ar(sig, LFNoise1.kr(2).range(-1, 1));
	Out.ar(3, sig);
}).add;
);

(
SynthDef.new(\pitchshift, {
	arg in=0, out, rate=0.5;
	var sig, sig2;
	sig = SoundIn.ar(0);
	sig2 = SoundIn.ar(1);
	sig = sig + sig2;
	sig = PitchShift.ar(
		sig,
		0.1,
		rate,
		0,
		0.004
	);
	sig = Splay.ar(sig);
	Out.ar(3, sig);
}).add;
);

(
SynthDef.new(\audioThru, {
	arg out=3, amp=1;
	var sig, sig2;
	sig = SoundIn.ar(0);
	sig2 = SoundIn.ar(1);
	sig = sig + sig2;
	sig = sig*amp;
	sig = Splay.ar(sig);
	Out.ar(out, sig);
}).add;
);


)

Synth.new(\pitchshift, [\rate, 2]);