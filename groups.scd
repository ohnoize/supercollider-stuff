(
SynthDef.new(\blip, {
	arg out, fund=100, dens=2, decay=0.2;
	var freq, trig, sig;
	freq = LFNoise0.kr(dens).exprange(fund, fund * 4).round(fund);
	sig = VarSaw.ar(freq) * 0.25;
	trig = Dust.kr(dens);
	sig = sig * EnvGen.kr(Env.perc(0.01, decay), trig);
	sig = Pan2.ar(sig, LFNoise1.kr(10));
	Out.ar(out, sig);
}).add;
)


(
SynthDef.new(\reverb, {
	arg in, out=0;
	var sig;
	sig = In.ar(in, 2);
	sig = FreeVerb.ar(sig, 0.5, 0.8, 0.2);
	Out.ar(out, sig);
}).add;
)

8.do{
	Synth.new(
		\blip,
		[
			\out, ~reverbBus2
		], ~sourceGrp
	);
}

~sourceGrp = Group.new;

~sourceGrp.set(\decay, 0.1);
~sourceGrp.set(\dens, 10);
~sourceGrp.freeAll;



(
x = Synth.new(\blip, [\out, ~reverbBus2], ~sourceGrp);
y = Synth.new(\reverb, [\in, ~reverbBus2], ~fxGrp);
)
x.set(\fund, 100);
x.set(\dens, 1);

x.free;
y.free;

s.freeAll;

x = Synth.before(y, \blip, [\out, ~reverbBus2]);

~sourceGrp = Group.new;
~fxGrp = Group.after(~sourceGrp);







