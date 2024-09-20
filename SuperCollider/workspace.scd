(
// mostly state for the screenFade and audioFade functions to work.
var audioAmp = 2;
var screenAmp = 1;
var audioFadeFork = nil;
var screenFadeFork = nil;

// FPS for screenFade/audioFade (see below);
var fps = 60;

// OSC to Visualizer application
var net = NetAddr("127.0.0.1", 57140);


// Sample Rate
~sr = 48000;

// Buffer Size
~bs = 1024;

// Frequency of one audio buffer.
~r = ~sr/~bs;

// Wavelength of one buffer
~l = 1/~r;

// A tempo that I chose so that quantizing events (more or less) align with audio buffers
~t = ~r / 20;

TempoClock.default.tempo = ~t;


// A function to convert a midi note value roughlty to a just-intonation frequeny
// based on the base frequency of an audio buffer.

~just = {|note|
	var ratios = [1, 10/9, 9/8, 6/5, 5/4, 4/3, 45/32, 3/2, 25/16, 5/3, 9/5, 15/8];
	var octave, baseRatio, ratio;

	note.isCollection.if({
		note.collect(~just);
	}, {
		note.isRest.if({Rest()}, {
			note.isNil.if({nil}, {
				octave = (note / 12).floor;
				baseRatio = 2.pow(octave - 2);
				ratio = baseRatio * ratios[note % 12];
				ratio * ~r;
			});
		});
	});
};

// functions to linearly fade the audio brightness and the screen brightness
// in the visualizer app.

~audioFade = {|target, time|
	var steps = time * fps;
	var start = audioAmp;
	audioFadeFork.stop;
	audioFadeFork = {
		steps.do {|i|
			var norm = (i+1) / steps;
			audioAmp = norm.linlin(0, 1, start, target);
			net.sendMsg("/audio", audioAmp);
			(1/fps).wait;
		};
	}.fork;
};

~screenFade = {|target, time|
	var steps = time * fps;
	var start = screenAmp;
	screenFadeFork.stop;
	screenFadeFork = {
		steps.do {|i|
			var norm = (i+1) / steps;
			screenAmp = norm.linlin(0, 1, start, target);
			net.sendMsg("/screen", screenAmp);
			(1/fps).wait;
		};
	}.fork;
};
)

// dim the screen a bit
~screenFade.value(0.75, 6);

// push the audio brightness A LOT
~audioFade.value(2, 10);

(
Ndef(\bar).quant = 1;
Ndef(\bar).fadeTime = 8;
Ndef(\bar, {
	var sig = 7.collect {|i|
		var chan = LFPulse.ar(~r , 0.5, 0.2);
		chan;
	};
	sig;
});
)

(
Ndef(\mix).quant = 1;
Ndef(\mix).fadeTime = 8;
Ndef(\mix, {
	var bar = Ndef(\bar).ar(7);

	var sig = bar;

	sig = LPF.ar(sig, 200) * DC.kr(0.5);

	LeakDC.ar(sig);
}).play;
)