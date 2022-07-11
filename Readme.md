# AV Live Coding performance as it was performed in Barcelona on July 9th.

Code dump (with few comments) for my live coding performance in Barcelona, July 9th.

## Basic Concept

7 audio channels (but you could change the number) are live codded with SuperCollider and the samples of each channel is interpretated as brightness by a GLSL shader. Every channel is displayed as a vertical bar next to each other. The audio channels are again combined to a stereo signal.

## Get it running

I used a MOTU interface both for sending audio back to OpenFrameworks as well as doing the down-mix to Stereo. If no external audio interface with mixing/routing capabilities is available you could also do this with Jack/SuperCollider/etc. 

In the end the most important thing is that you can receive the audio in OpenFrameworks and that you somehow also manage to play out the audio in some sensible way.

SuperCollider Code is not so controversial and should be clear. Some of the experiments in old_stuff.scd might need [CNToolsSC3](https://github.com/cappelnord/CNToolsSC3) and the Feedback Quark as extensions. But not needed for basic operations.

For the OpenFrameworks code: This is based on of_v0.11.2 - create a new project with ofxOsc as extension and see that shaders (in bin/data/) are copied to the right place.

Many readers of the document will figure it out. If you have issues hust drop me a message!

## Future Work

I will want to explore this performance further and might clean up code to be able for others to use it more easily. Until then; Enjoy reading the code and if things are unclear let me know!