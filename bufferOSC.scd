(
		OSCdef.new(\togglerecord1, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {Synth.new(\recordnewbuf, [\bufnum, 0])});
	},
	'1/push1'
);
		OSCdef.new(\togglerecord2, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {Synth.new(\recordnewbuf, [\bufnum, 1])});
	},
	'1/push11'
);
		OSCdef.new(\togglerecord3, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {Synth.new(\recordnewbuf, [\bufnum, 2])});
	},
	'1/push20'
);
			OSCdef.new(\toggleplay11, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {z = Synth.new(\playback)});
	},
	'1/push19'
);
			OSCdef.new(\toggleplay12, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {x = Synth.new(\bufrd_noise, [\buf, 0, \start, 0, \end, ~b1.numFrames - 1, \freq, 1])});
	},
	'1/push21'
);
			OSCdef.new(\toggleplay13, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {y = Synth.new(\bufrd_noise, [\buf, 0, \start, 0, \end, ~b1.numFrames - 1, \freq, 1])});
	},
	'1/push17'
);
			OSCdef.new(\togglestop11, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {z.free});
	},
	'1/push16'
);
			OSCdef.new(\togglestop12, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {x.free});
	},
	'1/push15'
);
			OSCdef.new(\togglestop13, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {y.free});
	},
	'1/push14'
);
		OSCdef.new(\fader11, {
	arg msg;
	z.set(\rate, msg[1].linlin(0,1,0.1,3));
		},
	'/1/fader10'
);
			OSCdef.new(\fader12, {
	arg msg;
	msg[1].postln;
	x.set(\freq, msg[1].linlin(0,1,0.001,2))
	},
	'1/fader9'
);
			OSCdef.new(\fader13, {
	arg msg;
	msg[1].postln;
	y.set(\freq, msg[1].linlin(0,1,0.001,5))
	},
	'1/fader8'
);

			OSCdef.new(\toggleplay21, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {v = Synth.new(\playback, [\bufnum, 1])});
	},
	'1/push13'
);
			OSCdef.new(\toggleplay22, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {u = Synth.new(\bufrd_noise, [\buf, 1, \start, 0, \end, ~b1.numFrames - 1, \freq, 1])});
	},
	'1/push12'
);
			OSCdef.new(\toggleplay23, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {~ab = Synth.new(\bufrd_noise, [\buf, 1, \start, 0, \end, ~b1.numFrames - 1, \freq, 1])});
	},
	'1/push18'
);
			OSCdef.new(\togglestop21, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {v.free});
	},
	'1/push10'
);
			OSCdef.new(\togglestop22, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {u.free});
	},
	'1/push9'
);
			OSCdef.new(\togglestop23, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {~ab.free});
	},
	'1/push8'
);
		OSCdef.new(\fader21, {
	arg msg;
	v.set(\rate, msg[1].linlin(0,1,0.1,3));
		},
	'/1/fader7'
);
			OSCdef.new(\fader22, {
	arg msg;
	msg[1].postln;
	u.set(\freq, msg[1].linlin(0,1,0.001,2))
	},
	'1/fader6'
);
			OSCdef.new(\fader23, {
	arg msg;
	msg[1].postln;
	~ab.set(\freq, msg[1].linlin(0,1,0.001,5))
	},
	'1/fader5'
);

			OSCdef.new(\toggleplay31, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {~vv = Synth.new(\playback, [\bufnum, 2])});
	},
	'1/push7'
);
			OSCdef.new(\toggleplay32, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {~uu = Synth.new(\bufrd_noise, [\buf, 2, \start, 0, \end, ~b1.numFrames - 1, \freq, 1])});
	},
	'1/push6'
);
			OSCdef.new(\toggleplay33, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {~abb = Synth.new(\bufrd_noise, [\buf, 2, \start, 0, \end, ~b1.numFrames - 1, \freq, 1])});
	},
	'1/push5'
);
			OSCdef.new(\togglestop31, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {~vv.free});
	},
	'1/push4'
);
			OSCdef.new(\togglestop32, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {~uu.free});
	},
	'1/push3'
);
			OSCdef.new(\togglestop33, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {~abb.free});
	},
	'1/push2'
);
		OSCdef.new(\fader31, {
	arg msg;
	~vv.set(\rate, msg[1].linlin(0,1,0.1,3));
		},
	'/1/fader4'
);
			OSCdef.new(\fader32, {
	arg msg;
	msg[1].postln;
	~uu.set(\freq, msg[1].linlin(0,1,0.001,2));
	},
	'1/fader3'
);
			OSCdef.new(\fader33, {
	arg msg;
	msg[1].postln;
	~abb.set(\freq, msg[1].linlin(0,1,0.001,5));
	},
	'1/fader2'
);
		OSCdef.new(\delaytoggle, {
	arg msg;
	if (msg[1] == 1, {~delays = Synth.before(~master, \delay)}, {~delays.free});
	},
	'/1/toggle1'
);
			OSCdef.new(\delayfader1, {
	arg msg;
	msg[1].postln;
			~delays.set(\dtime, msg[1].linexp(0,1,0.01,5));
	},
	'1/fader11'
);
			OSCdef.new(\delayfader2, {
	arg msg;
	msg[1].postln;
				~delays.set(\fback, msg[1].linexp(0,1,0.01,16));
	},
	'1/fader12'
);
		OSCdef.new(\disttoggle, {
	arg msg;
	if (msg[1] == 1, {~xxy = Synth.before(~master, \dist, [\rate, 1000, \bits, 12])}, {~xxy.free});
	},
	'/1/toggle2'
);
			OSCdef.new(\distfader1, {
	arg msg;
	msg[1].postln;
					~xxy.set(\rate, msg[1].linlin(0,1,10,1000));
	},
	'1/fader13'
);
			OSCdef.new(\distfader2, {
	arg msg;
	msg[1].postln;
					~xxy.set(\bits, msg[1].linlin(0,1,0.16,16));
	},
	'1/fader14'
);
		OSCdef.new(\toggleaudio, {
	arg msg;
	msg[1].postln;
	if (msg[1] == 1, {~audioIn = Synth.new(\audioIn)}, {~audioIn.free});
	},
	'/1/toggle3'
);
		OSCdef.new(\stopall, {
	arg msg;
	msg[1].postln;
			if (msg[1] == 1, {s.freeAll}, {~master = Synth.new(\masterfader)});
	},
	'/1/push22'
);
		OSCdef.new(\masterfader, {
	arg msg;
	msg[1].postln;
			~master.set(\amp, msg[1].linexp(0,1,0.001,1.00));
	},
	'/1/fader17'
		);


	)