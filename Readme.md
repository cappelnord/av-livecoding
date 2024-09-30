# Performance Setup for 46.875

The audio-visual live coding improvisation *46.875* explores SuperCollider audio synthesis to simultaneously shape both sound and visuals. Sound is synthesized and played back to the audience, while for each video frame (typically 60 frames per second), a slice of the generated audio data is uploaded as a texture to the GPU. Using a simple GLSL shader (which will not change throughout the performance), each audio sample is represented as a thin bar with brightness corresponding to its amplitude. Leveraging SuperCollider's multi-channel expansion, multiple audio channels (e.g., seven) are live-coded simultaneously, either diffused separately (one speaker per channel) or mixed down to fewer loudspeakers (e.g., stereo). The visual representations for each audio channel are arranged side by side on the screen.

The title *46.875* comes from the fundamental frequency of this piece, which is derived from the audio sample rate (48,000 Hz) divided by the texture size on the GPU (1024 pixels), which in my code is assigned to *~r* for convenience. This number is essential, as a periodic waveform with this frequency appears static in the visuals, its wavelength matching the texture size. Slight changes in frequency may have minimal impact on the sound but cause the visual representation to move, while significant changes in sound may only slightly alter the visuals. What excites me as a performer is exploring these phenomena and the inherent audio-visual coupling within this constrained performance setup. I hope it resonates with the audience as well.

## OSC Control

You can send 2 OSC messages to the visuals application (by default listening on port 57140):

### /audio f

Set a float (generally between 0 and 1) on how bright the audio data should be displayed.

### /screen f

Set a float (generally between 0 and 1) on how bright screen should be displayed.

## Get it running

I used a MOTU interface both for sending audio back to OpenFrameworks as well as doing the down-mix to Stereo. If no external audio interface with mixing/routing capabilities is available you could also do this by other means.

In the end the most important thing is that you can receive the audio in OpenFrameworks and that you somehow also manage to play out the audio to speakers in some sensible way.

For the OpenFrameworks code: This is based on of_v0.12.0 - create a new project with ofxOsc as extension and see that both the .cpp and .h files as well as the shaders (in bin/data/) are copied to the right place.