// fragment shader

#version 150

uniform vec2 windowDimensions;

uniform sampler2DRect grabberTex;
uniform sampler2DRect audioTex;

uniform float audioAmp;
uniform float screenAmp;

in vec2 audio_st;
in vec2 grabber_st;

out vec4 outputColor;

void main()
{

    vec4 audio = texture(audioTex, audio_st);
    vec4 grabber = texture(grabberTex, grabber_st) * screenAmp;

    vec3 audioRGB = (audio.rgb * audioAmp);
    vec3 grabberRGB = mix(grabber.rgb, 1.0 - grabber.rgb, abs(audioRGB));

    // some weird way on how blend negative audio samples in some more interessting
    // way with the screen grab texture.
    
    if(audioRGB.r < 0.0) {
        grabberRGB = grabberRGB * 0.25 + grabber.rgb * 0.75;
    }
    
    outputColor = vec4(grabberRGB, 1.0);
}