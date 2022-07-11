# AV Live Coding performance as it was performed in Barcelona on July 9th.

Code dump (with few comments) for my live coding performance in Barcelona, July 9th.

## Basic Concept

7 audio channels (but you could change the number) are live codded with SuperCollider and the samples of each channel is interpretated as brightness by a GLSL shader. Every channel is displayed as a vertical bar next to each other. The audio channels are again combined to a stereo signal.

The most interessting thing about this setup is that if you align audio synthesis with the buffer size of audio samples that is displayed you can create either static or slowly moving visuals (or you don't care about it and just do what looks great).

## OSC Control

You can send 2 OSC messages to the visuals application (by default listening on port 57140):

### /audio f

Set a float (generally between 0 and 1) on how bright the audio data should be displayed. I actually use often values larger than 1 to make the audio look brighter than it actually is (because I don't want to destroy peoples ears all the time).

### /screen f

Set a float (generally between 0 and 1) on how bright screen should be displayed.

## Get it running

I used a MOTU interface both for sending audio back to OpenFrameworks as well as doing the down-mix to Stereo. If no external audio interface with mixing/routing capabilities is available you could also do this with Jack/SuperCollider/etc. 

In the end the most important thing is that you can receive the audio in OpenFrameworks and that you somehow also manage to play out the audio to speakers in some sensible way.

SuperCollider Code should be clear. Some of the experiments in *old_stuff.scd* might need [CNToolsSC3](https://github.com/cappelnord/CNToolsSC3) and the Feedback Quark as extensions. But this is not needed for basic operations.

For the OpenFrameworks code: This is based on of_v0.11.2 - create a new project with ofxOsc as extension and see that both the .cpp and .h files as well as the shaders (in bin/data/) are copied to the right place.

Many readers of the document will figure this out easily by themselves. If you have issues just drop me a message!

## Future Work

I  want to explore this performance further and might clean up code to be able for others to use it more easily. Until then; Enjoy reading the code and possibly play with it yourself! If things are unclear let me know!