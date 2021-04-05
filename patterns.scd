s.reboot;

Buffer.freeAll;


(
d = Dictionary.new;
d.add(\h ->
	PathName("/Users/ollihirvonen/Music/Electronic Music/Derek/Harm/").entries.collect({
		arg sf;
		Buffer.read(s, sf.fullPath);
	});
);

d.add(\p ->
	PathName("/Users/ollihirvonen/Music/Electronic Music/Derek/Perc/").entries.collect({
		arg sf;
		Buffer.read(s, sf.fullPath);
	});
);

)

d[\p].choose.play;

(
SynthDef.new(\sine, {
	arg freq=440, atk=0.005, rel=0.3, amp=1, pan=0;
	var sig, env;
	sig = SinOsc.ar(freq);
	env = EnvGen.kr(Env.new([0,1,0],[atk,rel],[1, -1]), doneAction:2);
	sig = Pan2.ar(sig, pan, amp);
	sig = sig * env;
	Out.ar(0, sig);
}).add;
)

(
SynthDef.new(\bufplay, {
	arg buf=0, rate=1, amp=1;
	var sig;
	sig = PlayBuf.ar(1, buf, BufRateScale.ir(buf) * rate, doneAction:2);
	sig = sig * amp;
	sig = Splay.ar(sig);
	Out.ar(0, sig);
}).add;
)

(
Pdef(\sinepat,
	Pbind(
		\instrument, \sine,
		\dur, Pseq([1/2], inf),
		\stretch, 2,
		\midinote, Pseq([28], inf),
		\harmonic, Pexprand(1, 20).round,
		\atk, Pwhite(3.0, 5.0),
		\rel, Pwhite(5.0, 10.0 ),
		\amp, Pkey(\harmonic).reciprocal * 0.2,
		\pan, -1.0,
	);
).play(quant:2);
)

(
Pdef(\rhythm,
	Pbind(
		\instrument, \bufplay,
		\dur, Pseq([1/16], inf),
		\stretch, 60/120 * 4,
		\buf, Pseq(
			[
				Prand(d[\p], 1),
				Prand(d[\h], 7),
				Prand(d[\p], 1),
				Prand(d[\h], 7),
			], inf
		),

		\rate, Pexprand(0.9, 1.1, inf),
		\amp, Pseq([0.8, Pexprand(0.1, 0.4, 7)], inf),
	);
).play(quant:2);
)

Pdef(\rhythm).stop;
Pdef(\sinepat).stop;



s.plotTree;

p.stop;

(
SynthDef.new(\delay, {
	arg in=3, out=0;
	var sig;
	sig = In.ar(in, 1);
	sig = sig + CombC.ar(sig, 1, 0.5, 1);
	sig = Splay.ar(sig);
	Out.ar(0, sig);
}).add;
)

Synth(\delay);

s.meter;
	