(
// set your multichannel device here ...
var deviceName = "UltraLite-Patrick";
// var deviceName = "BlackHole 16ch";
s.options.outDevice = deviceName;
s.options.inDevice = deviceName;
s.options.sampleRate = 48000;
s.options.numOutputBusChannels = 10;
s.options.numInputBusChannels = 10;
)

s.reboot;

// I used a Motu Ultralite as audio interface, sending 7 channels to the
// audio interface, the audio interface interlan mixing DSP then did a
// downmix to Stereo. Unfortunately there was a lot lof delay with the visuals,
// so I sent the audio back to SuperCollider to delay it a bit in order to line
// up with the visuals. Below is the Synth that just delays the signal by some time.

// What is missing here is to also to the down-mixing to Stereo in SuperCollider
// (using Splay). I leave this here as an exercise but in case somebody struggles
// with this get in touch!

// Delay
(
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
)