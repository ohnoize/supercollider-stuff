s.reboot;

(
OSCdef.new(
	\toggle,
	{
		arg msg, time, addr, port;
		x.set(\gate, msg[1]);
	},
	'/main/toggle1'
);



OSCdef.new(
	\fader1,
	{
		arg msg, time, addr, port;
		x.set(\freq, msg[1].linexp(0,1,20,500))
	},
	'/main/fader1'
);



OSCdef.new(
	\fader3,
	{
		arg msg, time, addr, port;
		x.set(\nharm, msg[1].linlin(0,1,1,50))

	},
	'/main/fader3'
);



OSCdef.new(
	\fader4,
	{
		arg msg, time, addr, port;
		x.set(\amp, msg[1].linexp(0,1,0.001,1))
	},
	'/main/fader4'
);


OSCdef.new(
	\rotary1,
	{
		arg msg, time, addr, port;
		x.set(\pan, msg[1].linlin(0,1,-1,1));
	},
	'/main/rotary1'
);



OSCdef.new(
	\rotary2,
	{
		arg msg, time, addr, port;
		x.set(\detune, msg[1].linexp(0,1,0.01,12))
	},
	'/main/rotary2'
);
)


(
{Blip.ar(
		20 *
		LFNoise1.kr(0.2!16).bipolar(0.2.neg, 0.2).midiratio,
	12);
}.play;
)

(
SynthDef.new(\tone, {
	arg freq=40, nharm=12, detune=0.2, gate=0, pan=0, amp=1, out=0;
	var sig, env;
	env=EnvGen.kr(Env.adsr(0.05,0.1,0.5,3), gate);
	sig = Blip.ar(
		freq *
		LFNoise1.kr(0.2!16).bipolar(detune.neg,detune).midiratio,
		nharm
	);
	sig = sig * LFNoise1.kr(0.5!16).exprange(0.1,1);
	sig = Splay.ar(sig);
	sig = Balance2.ar(sig[0], sig[1], pan);
	sig = sig * env * amp;
	Out.ar(out, sig);
}).add;
)

x = Synth.new(\tone);

x.set(\detune, 12);



















