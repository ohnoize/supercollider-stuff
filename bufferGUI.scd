(

(
w = Window.new("Buffer Rec/Playback", Rect(1, 400, 500, 400)).front;
	b = Button(w, Rect(20, 20, 80, 20))
		.states_([["Record"]])
		.action_({Synth.new(\recordnewbuf)});

~bufrecordhold = Button(w, Rect(20, 40, 80, 20))
        .states_([
            ["Record"],
            ["Stop"]

        ])

        .action_({ arg butt;
	            if (butt.value == 1, {(
		~b1.free;
		~b1 = Buffer.alloc(s,44100*5,1, bufnum:0);
		~recbuf0 = Synth.new(\recordnewbuf, [\bufnum, 0]))},
		{~recbuf0.free});
        });


	c = Button(w, Rect(100, 20, 80, 20))
		.states_([["Play"]])
		.action_({z = Synth.head(~bufferFXgroup, \playback)});
	d = Button(w, Rect(180, 20, 80, 20))
		.states_([["Stop"]])
		.action_({z.free});
	e = Button(w, Rect(100, 40, 80, 20))
		.states_([["Play"]])
		.action_({x = Synth.head(~bufferFXgroup, \bufrd_noise, [\buf, 0, \start, 0, \end, ~b1.numFrames - 1, \freq, 1])});
	f = Button(w, Rect(180, 40, 80, 20))
		.states_([["Stop"]])
		.action_({x.free});
	h = Button(w, Rect(100, 60, 80, 20))
		.states_([["Play"]])
		.action_({y = Synth.head(~bufferFXgroup, \bufrd_noise, [\buf, 0, \start, 0, \end, ~b1.numFrames - 1, \freq, 1])});
	i = Button(w, Rect(180, 60, 80, 20))
		.states_([["Stop"]])
		.action_({y.free});
	a = Slider(w, Rect(260, 20, 100, 20))
		.value_(0.5).step_(0.01)
		.action_({z.set(\rate, 0.01 + a.value * 2)});
	g = Slider(w, Rect(260, 40, 100, 20))
		.value_(0.5)
		.step_(0.01)
		.action_({x.set(\freq, 0.01 + g.value * 2)});
	j = Slider(w, Rect(260, 60, 100, 20))
		.value_(0.5).step_(0.01)
		.action_({y.set(\freq, 0.01 + j.value * 5)});
   ~grainbutton1 = Button(w, Rect(360, 20, 100, 60))
        .states_([
            ["Granulate"],
            ["Stop"]

        ])
        .action_({ arg butt;
	            if (butt.value == 1, {~grain1 = Synth.head(~bufferFXgroup, \graintest, [\bufnum, 0])},
		{~grain1.free});
        });
	k = Button(w, Rect(20, 80, 80, 20))
		.states_([["Record"]])
		.action_({Synth.new(\recordnewbuf, [\bufnum, 1])});
	l = Button(w, Rect(100, 80, 80, 20))
		.states_([["Play"]])
		.action_({v = Synth.head(~bufferFXgroup, \playback, [\bufnum, 1])});
	m = Button(w, Rect(180, 80, 80, 20))
		.states_([["Stop"]])
		.action_({v.free});
	n = Button(w, Rect(100, 100, 80, 20))
		.states_([["Play"]])
		.action_({u = Synth.head(~bufferFXgroup, \bufrd_noise, [\buf, 1, \start, 0, \end, ~b2.numFrames - 1, \freq, 1])});
	o = Button(w, Rect(180, 100, 80, 20))
		.states_([["Stop"]])
		.action_({u.free});
	p = Button(w, Rect(100, 120, 80, 20))
		.states_([["Play"]])
		.action_({~ab = Synth.head(~bufferFXgroup, \bufrd_noise, [\buf, 1, \start, 0, \end, ~b2.numFrames - 1, \freq, 1])});
	q = Button(w, Rect(180, 120, 80, 20))
		.states_([["Stop"]])
		.action_({~ab.free});
	r = Slider(w, Rect(260, 80, 100, 20))
		.value_(0.5)
		.step_(0.01)
		.action_({v.set(\rate, 0.01 + r.value * 2)});
	~aa = Slider(w, Rect(260, 100, 100, 20))
		.value_(0.5)
		.step_(0.01)
		.action_({u.set(\freq, 0.01 + ~aa.value * 2)});
	t = Slider(w, Rect(260, 120, 100, 20))
		.value_(0.5)
		.step_(0.01)
		.action_({~ab.set(\freq, 0.01 + t.value * 5)});
 ~grainbutton2 = Button(w, Rect(360, 80, 100, 60))
        .states_([
            ["Granulate"],
            ["Stop"]

        ])
        .action_({ arg butt;
	            if (butt.value == 1, {~grain2 = Synth.head(~bufferFXgroup, \graintest, [\bufnum, 1])},
		{~grain2.free});
        });
	~kk = Button(w, Rect(20, 140, 80, 20))
		.states_([["Record"]])
		.action_({Synth.new(\recordnewbuf, [\bufnum, 2])});
	~ll = Button(w, Rect(100, 140, 80, 20))
		.states_([["Play"]])
		.action_({~vv = Synth.head(~bufferFXgroup, \playback, [\bufnum, 2])});
	~mm = Button(w, Rect(180, 140, 80, 20))
		.states_([["Stop"]])
		.action_({~vv.free});
	~nn = Button(w, Rect(100, 160, 80, 20))
		.states_([["Play"]])
		.action_({~uu = Synth.head(~bufferFXgroup, \bufrd_noise, [\buf, 2, \start, 0, \end, ~b3.numFrames - 1, \freq, 1])});
	~oo = Button(w, Rect(180, 160, 80, 20))
		.states_([["Stop"]])
		.action_({~uu.free});
	~pp = Button(w, Rect(100, 180, 80, 20))
		.states_([["Play"]])
		.action_({~abb = Synth.head(~bufferFXgroup, \bufrd_noise, [\buf, 2, \start, 0, \end, ~b3.numFrames - 1, \freq, 1])});
	~qq = Button(w, Rect(180, 180, 80, 20))
		.states_([["Stop"]])
		.action_({~abb.free});
	~rr = Slider(w, Rect(260, 140, 100, 20))
		.value_(0.5)
		.step_(0.01)
		.action_({~vv.set(\rate, 0.01 + ~rr.value * 2)});
	~aaa = Slider(w, Rect(260, 160, 100, 20))
		.value_(0.5)
		.step_(0.01)
		.action_({~uu.set(\freq, 0.01 + ~aaa.value * 2)});
	~tt = Slider(w, Rect(260, 180, 100, 20))
		.value_(0.5)
		.step_(0.01)
		.action_({~abb.set(\freq, 0.01 + ~tt.value * 5)});
~grainbutton3 = Button(w, Rect(360, 140, 100, 60))
        .states_([
            ["Granulate"],
            ["Stop"]

        ])
        .action_({ arg butt;
	            if (butt.value == 1, {~grain3 = Synth.head(~bufferFXgroup, \graintest, [\bufnum, 2])},
		{~grain3.free});
        });
	~xxx = Button(w, Rect(20, 200, 80, 20))
		.states_([["BitCrush"]])
		.action_({~xxy = Synth.tail(~bufferFXgroup, \dist, [\rate, 1000, \bits, 12])});
	~off = Button(w, Rect(100, 200, 60, 20))
		.states_([["Off"]])
		.action_({~xxy.free});
	~xxz = Slider(w, Rect(260, 200, 100, 20))
		.value_(0.5)
		.step_(0.01)
		.action_({~xxy.set(\rate, 0.01 + ~xxz.value * 1000)});
	~xxxx = Slider(w, Rect(160, 200, 100, 20))
		.value_(1.0)
		.step_(0.01)
		.action_({~xxy.set(\bits, 0.01 + ~xxxx.value * 16)});
	~delayon = Button(w, Rect(20, 220, 80, 20))
		.states_([["Delay"]])
		.action_({~delays = Synth.tail(~bufferFXgroup, \delay)});
	~delayoff = Button(w, Rect(100, 220, 60, 20))
		.states_([["Off"]])
		.action_({~delays.free});
	~dtime = Slider(w, Rect(260, 220, 100, 20))
		.value_(0.5)
		.step_(0.01)
		.action_({~delays.set(\dtime, 0.01 + ~dtime.value * 5)});
	~dfback = Slider(w, Rect(160, 220, 100, 20))
		.value_(1.0)
		.step_(0.01)
		.action_({~delays.set(\fback, 0.01 + ~dfback.value * 16)});
	~audioOn = Button(w, Rect(20, 300, 80, 20))
		.states_([["AudioThru"]])
		.action_({~audioIn = Synth.new(\audioIn)});
	~audioOff = Button(w, Rect(20, 320, 80, 20))
		.states_([["AudioOff"]])
		.action_({~audioIn.free});


	~ac = Button(w, Rect(180, 300, 80, 20))
		.states_([["STOP ALL"]])
		.mouseDownAction_({~bufferFXgroup.freeAll})
        .action_({~buffermaster = Synth.tail(~bufferFXgroup, \bufmaster)});

~bufmasterslider = Slider(w, Rect(20, 340, 400, 20))
.value_(1)
.action_({~buffermaster.set(\amp, ~bufmasterslider.value)});


w.front;
	);


(
w = Window.new("Live FX", Rect(500, 500, 400, 400));

b = Button(w, Rect(20, 20, 340, 30))
        .states_([
            ["Echo OFF"],
            ["Echo ON"]

        ])
        .action_({ arg butt;
	            if (butt.value == 1, {~echo1 = Synth.head(~liveFXgroup, \echo)},
		{~echo1.free});
        });
c = Button(w, Rect(20, 60, 340, 30))
        .states_([
            ["Reverb OFF"],
            ["Reverb ON"]

        ])
        .action_({ arg butt;
	            if (butt.value == 1, {~reverb1 = Synth.head(~liveFXgroup, \reverb)},
		{~reverb1.free});
        });
d = Button(w, Rect(20, 100, 340, 30))
        .states_([
            ["Grains OFF"],
            ["Grains ON"]

        ])
        .action_({ arg butt;
	            if (butt.value == 1, {~grain1 = Synth.head(~liveFXgroup, \pitchgrain)},
		{~grain1.free});
        });
e = Button(w, Rect(20, 140, 340, 30))
        .states_([
            ["PitchShift OFF"],
            ["PitchShift ON"]

        ])
        .action_({ arg butt;
	            if (butt.value == 1, {~shift1 = Synth.head(~liveFXgroup, \pitchshift)},
		{~shift1.free});
        });
f = Button(w, Rect(20, 180, 340, 30))
        .states_([
            ["AudioThru OFF"],
            ["AudioThru ON"]

        ])
        .action_({ arg butt;
	            if (butt.value == 1, {~audio1 = Synth.head(~liveFXgroup, \audioThru)},
		{~audio1.free});
        });
w.front;
);
s.meter;
s.plotTree;

(w = Window.new("Master Fader", Rect(1200, 1, 100, 800)).front;
~masterslider = Slider(w, Rect(10, 10, 80, 700))
.value_(1)
	.action_({~master.set(\amp, ~masterslider.value)});

);

)




