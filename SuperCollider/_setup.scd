(
// set your multichannel device here ...
var deviceName = "UltraLite-Patrick";
// var deviceName = "BlackHole 16ch";
s.options.outDevice = deviceName;
s.options.inDevice = deviceName;
s.options.sampleRate = 48000;
s.options.numOutputBusChannels = 16;
s.options.numInputBusChannels = 8;
)

s.reboot;


// Delay of 8-Channel Audio
(
var delayFunc = {
	var delayTime = 0.09;
	{
		var sig = SoundIn.ar([0, 1, 2, 3, 4, 5, 6, 7]) * Line.ar(0, 1, 3);
		sig = DelayC.ar(sig, delayTime, delayTime);
		Out.ar(8, sig);
	}.play;
};
delayFunc.value;
CmdPeriod.add(delayFunc);
)

// Test Audio (and Delay)
(
(
Ndef(\test).quant = 1;
Ndef(\test).fadeTime = 1;
Ndef(\test, {
	var sig = 7.collect {|i|
		var chan = WhiteNoise.ar() * Lag2.ar(LFPulse.ar(0.25, (7-i) * (1/7), 0.01), 0.001);
		chan;
	};
	sig;
}).play;
)
)

Ndef(\test).clear

s.meter


// I used a Motu Ultralite as audio interface, sending 7 channels to the
// audio interface, the audio interface interlan mixing DSP then did a
// downmix to Stereo. Unfortunately there was a lot lof delay with the visuals,
// so I sent the audio back to SuperCollider to delay it a bit in order to line
// up with the visuals. Below is the Synth that just delays the signal by some time.

// What is missing here is to also to the down-mixing to Stereo in SuperCollider
// (using Splay). I leave this here as an exercise but in case somebody struggles
// with this get in touch!

// Delay of Stereo Mix
(
/*
var delayFunc = {
	var delayTime = 0.125;
	{
		var sig = SoundIn.ar([8, 9]) * Line.ar(0, 1, 3);
		sig = DelayC.ar(sig, delayTime, delayTime);
		Out.ar(8, sig);
	}.play;
};
delayFunc.value;
CmdPeriod.add(delayFunc);
*/
)



().play

s.meter