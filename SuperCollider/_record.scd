// recording 7 channel audio + stereo audio (both fed back from audio interface)
(
var datetime = {
	var date = Date.localtime;
	(date.dayStamp ++ "-" ++ date.hourStamp.replace($:, $-).split($.)[0])
};
var basePath = thisProcess.platform.recordingsDir +/+ datetime.value;
var stereoBus = s.options.numOutputBusChannels + 8;
var sevenBus = s.options.numOutputBusChannels;
// prepare
~recordStereo = Recorder(s);
~recordSeven = Recorder(s);

~recordStereo.record(basePath ++ "-stereo.wav", stereoBus, 2);
~recordSeven.record(basePath ++ "-seven.wav", sevenBus, 7);
)

// stop the recording
(
~recordStereo.stopRecording;
~recordSeven.stopRecording;
)
