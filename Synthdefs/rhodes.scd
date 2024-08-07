(

SynthDef(\rhodes, {|out, sustain=1, pan, accelerate, freq |
  var sig, in, n = 6, max = 0.05, min = 0.01, delay, pitch, detune, hammer, amp, env;
  amp = 0.9;
	freq = freq.cpsmidi;
	hammer = Decay2.ar(Impulse.ar(0.001), 0.0001, 0.01, LFNoise2.ar([200,1800].asSpec.map(amp), 0.20));
	sig = Mix.ar(Array.fill(3, { arg i;
		detune = #[-0.03, 0, 0.04].at(i);
			delay = (1/(freq + detune).midicps);
			CombL.ar(hammer, delay, delay, 100 * amp)
		}) );

	// sig = HPF.ar(sig,0);
    env = EnvGen.ar(Env.perc(0.02, sustain, amp * 2.5, -1), doneAction:2);
    OffsetOut.ar(out, DirtPan.ar(sig, ~dirt.numChannels, pan, env));
}).add;

)
