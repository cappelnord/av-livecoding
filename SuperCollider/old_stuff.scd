// These are just some old tests .. feel free to explore them (or not)
// Some of them might already be broken ...

Ndef(\imp_test, {RLPF.ar(LFSaw.ar(~r * [4, 3, 5, 2, 1.5] * 0.25  + [0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4]
	* XLine.kr(1, 5, 60)),XLine.kr(~r, ~r*20, 10), 0.15)} * 0.2).play

Ndef(\imp_test).fadeTime = 10

Ndef(\imp_test).clear
(
Ndef(\bars).quant = 4;
Ndef(\bars, {
	var sig = 7.collect {
		Impulse.ar(~r * [1, 2, 3, 4].choose + Line.kr(0, [0, -8, 8, -4, 4].choose * 4, 1), 0, 0.03);
	};

	sig = RLPF.ar(sig, SinOsc.kr(0.1 + {0.5.rand}!7).range(50, 500), 0.4);

	sig = FbC({|fb| PitchShift.ar(fb, 0.2, 1.5) + sig * 0.6}, 0.25, ~l * 8);

	sig * 0.5
}).play;
Ndef(\bars).fadeTime=8;
)

Ndef(\bars).play

Ndef(\bars).clear
NdefMixer()
(
Ndef(\bla, {
	var sig = 7.collect {
		var rfreq = LFNoise2.kr(0.1).range(-2, 2) * LFNoise2.kr(0.2).range(0, 1) * 20;
		var rphase = LFNoise2.kr(0.2).range(0, 2pi) * LFNoise2.kr(0.2).range(0, 1);
		SinOsc.ar(100 + rfreq, rphase) * 0.1;
	};
	sig;
}).play;
)

Ndef(\bla).fadeTime = 4;
Ndef(\bla).quant = 2


(
Ndef(\bla2, {
	var sig = 7.collect {
		var rfreq = LFNoise2.kr(0.1).range(-2, 2) * LFNoise2.kr(0.2).range(0, 1) * 2;
		var rphase = LFNoise2.kr(0.2).range(0, 2pi) * LFNoise2.kr(0.2).range(0, 1);
		SinOsc.ar(150 + rfreq, rphase) * 0.1;
	};
	sig;
}).play;
)

Ndef(\bla2).fadeTime = 4;
Ndef(\bla2).quant = 2


(
Ndef(\bla3, {
	var sig = 7.collect {
		var rfreq = LFNoise2.kr(0.1).range(-2, 2) * LFNoise2.kr(0.2).range(0, 1) * 2;
		var rphase = LFNoise2.kr(0.2).range(0, 2pi) * LFNoise2.kr(0.2).range(0, 1) * 0;
		SinOsc.ar(100 + rfreq, rphase) * 0.05;
	};
	sig;
}).play;
)

Ndef(\bla3).fadeTime = 4;
Ndef(\bla3).quant = 2


(
Tdef(\ok, {
	inf. do {
		var baseRatio = 1 + 4.0.rand;
		"classic".postln;
		Ndef(\classic, {
			var sig = 7.collect {
				var freq = ExpRand(50, 100) * Line.kr(1, 5, 60) * baseRatio;
				var qfreq = (freq / ~r).ceil * ~r + Rand(-4.0, 4.1);
				SinOsc.ar(qfreq * SinOsc.ar(~r * Rand(1, 10)).range(0, 1000)) * 0.2
			};

				sig = sig + (LFNoise0.ar(~r*0.125 * {[1, 2, 3, 4].choose}!7) * 0.8);


			sig = FbC({|fb| PitchShift.ar(sig + fb * 0.8, 0.1, LFNoise2.kr(0.1).range(1.8, 2.2))}, 2, 2, 7) + sig;


				sig = sig * (sig > 0.9);

			sig = LPF.ar(sig, 200);

			sig * 0.5;
		}).play;
			40.wait;
	};
}).play;
Ndef(\classic).fadeTime = 4;
)

Tdef(\ok).clear
Ndef(\classic).clear

(
Ndef(\imp, {
	var sig = 7.collect {
		Impulse.ar(~r * [1, 2, 3, 4, 5, 20, 20].choose + Rand(-0.4, 0.04) * XLine.ar(1, 0.1, 30)) * 1;
	};

	sig = Decay.ar(sig, 0.001);

	sig = sig + (LFNoise0.ar(~r*100 * {[1, 2, 3, 4].choose}!7) * 0.8);

	sig = sig * (sig > 0.9);


	sig = FbC({|fb| sig + fb  * 0.1}, 1, 0.125 * ~r, 7) + sig * 0.5;

			sig = LPF.ar(sig, 200);

	sig;
}).play;
Ndef(\imp).quant = 4;
Ndef(\imp).fadeTime = 4
)

Ndef(\imp).clear


( //@ sd #0#
SynthDef(\pling, {|out=0, freq=440, amp=0.1, pan=0|

	var sig = SinOsc.ar(freq  + Rand(-1.0, 1.0) + (SinOsc.ar(freq*8) * Line.ar(freq*0.025, 2, 0.015)));
	var env = EnvGen.ar(Env.perc(0.0002, 2.5, 1, -4), doneAction:2);
	sig = Pan2.ar(sig, pan) * env;
	sig = sig * SinOsc.ar(Rand(0.01, 20), phase: Rand(0, 2pi)).range(0.5, 1);



	OffsetOut.ar(out, sig * amp);
}).add;
)

(
Pdef(\test, Pbind(
	\dur, [0.5, 1, 0.5, 1.5, 0.25]!!inf * 1.5,
	\instrument, [\pling, \pling, \pling]!!inf,
	\freq, Pseq([-12,24,0, [12, -24, 0, 12, 29], 0] + 48, inf).collect(~just),
	\strum, 0.125,
	\out, Prand((0..6), inf),
	\amp, [0.2, 0.2]
)).play;
)

(
Pdef(\test2, Pbind(
	\dur, [0.25, 0.5, 0.125]!!inf * 2.25,
	\instrument, [\pling, \pling, \pling]!!inf,
	\freq, Pseq([0,0,0, 12, -12] + 60, inf).collect(~just),
	\strum, 0.25,
	\out, Prand((0..6), inf),
	\amp, 0.025
)).play;
)

(
Pdef(\test3, Pbind(
	\dur, [1, 1, 1.5]!!inf * 0.75 * 0.125,
	\instrument, [\pling, \pling, \pling]!!inf,
	\freq, Pseq([0,7,7,1, 2,3,4,12, 24, [0, 7], 0, 0] + 72, inf).collect(~just),
	\strum, 0.25,
	\out, Prand((0..6), inf),
	\amp, 0.05
)).play
)


( //@ sd glitch
SynthDef(\glitch, {|out=0, freq=440, amp=0.1, pan=0, len=1|

	var sig = SinOsc.ar(freq * (SinOsc.ar(XLine.ar(4, 1, 0.01) * freq) * Line.ar(800, 0, 0.2)), phase: 0.5pi);
	var env = EnvGen.ar(Env.perc(0.000001, 0.05 * len, 1, 100), doneAction:2);
	sig = sig * env;

	OffsetOut.ar(out, sig * amp);
}).add;
)


( //@ sd glitch
SynthDef(\ns, {|out=0, freq=440, amp=0.1, pan=0, len=1|

	var sig = WhiteNoise.ar;
	var env = EnvGen.ar(Env.perc(0.0001, 0.01 * len, 1, 100), doneAction:2);
	sig = sig * env;

	OffsetOut.ar(out, sig * amp);
}).add;
)




(
Pdef(\gl, Pbind(
	\instrument, \glitch,
	\dur, [3, 2, 2, 2, 1]!!inf / 2,
	\freq, [2, 4, 4, 4, 6]!!inf * ~r * 0.25,
	\len, 16,
	\out, Prand((0..6), inf),
	\amp, 0.5
)).play;
)


(
Pdef(\gli, Pbind(
	\instrument, \glitch,
	\dur, [1, 1, 1, 1]!!inf / 8,
	\freq, [1, 1, 4, 16]!!inf * ~r * 32,
	\len, [0.1, 0.1, 2]!!inf,
	\out, Prand((0..6), inf),
	\amp, [1, 1, 0, 1, 0]!!inf * 0.2
)).play;
)

(
Pdef(\gl2, Pbind(
	\instrument, \glitch,
	\dur, [1, 1, 1, 2]!!inf / 8,
	\freq, [1, 1, [1, 2, 4, 8]!!inf]!*inf * ~r * 32,
	\len, [0.1, 0.1, 2, 4]!!inf,
	\out, Prand((0..6), inf),
	\amp, [1, 1, 0, 1, 0, 1, 0.125]!!inf * 0.2
)).play;
)

Ndef(\mix, {
	Pdef(
});

Pdef(\gl1).quant = 4
Pdef(\gl).quant = 4

~just.value(50)

(
SynthDef(\bleep, {|out=0, amp=0.1, freq=440, len=0.1|
	var sig = SinOsc.ar(freq + Rand(-4, 4) + (SinOsc.ar(freq  * 4 * XLine.ar(2, 1, 0.18)) * Line.kr(1000, 2, 0.02)), 0.5pi);
	var env = EnvGen.ar(Env([0, 1, 1, 0], [0.01, len * 0.01, 0.04]), doneAction:2);

	Out.ar(out, sig * amp * env);
}).add;
)

(
Pdef(\bleep, Pbind(
	\instrument, \bleep,
	\freq, [1, 1, 2, 3]!!inf * ~r,
	\len, [10, 5]!!inf * 4,
	\dur, [1/8, 1/2, 1/8]!!inf,
	\out, (0..6)!!inf
)).play;
)

(
Pdef(\bleep2, Pbind(
	\instrument, \bleep,
	\freq, [10, 10, 20, 40]!!inf * ~r,
	\len, [10, 5, 5, 9, 20]!!inf,
	\dur, 1/4,
	\out, (0..6)!!inf
)).play;
)

(
Pdef(\bleep3, Pbind(
	\instrument, \bleep,
	\freq, [10, 10, 20, 40]!!inf * ~r * 4,
	\len, [10, 5, 5, 9, 200]!!inf * 0.1,
	\dur, 1/16,
	\amp, [1, 1, 0]!!inf * 0.1,
	\out, [0, 2, 4, 1]!!inf
)).play;
)

s.scope



