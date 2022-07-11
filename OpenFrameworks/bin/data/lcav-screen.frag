// fragment shader

#version 150

uniform vec2 windowDimensions;
uniform vec2 audioDimensions;
uniform vec2 grabberDimensions;

uniform sampler2DRect grabberTex;
uniform sampler2DRect audioTex;

uniform float audioAmp;
uniform float screenAmp;

in vec2 st;

out vec4 outputColor;

void main()
{
    vec2 grabber_st = st;

    grabber_st.y = 1.0 - grabber_st.y;

    vec4 audio = texture(audioTex, st * audioDimensions);
    vec4 grabber = texture(grabberTex, grabber_st * vec2(grabberDimensions.x, audioDimensions.y)) * screenAmp;

    vec3 audioRGB = (audio.rgb * audioAmp);
    vec3 grabberRGB = mix(grabber.rgb, 1.0 - grabber.rgb, abs(audioRGB));

    // some weird way on how blend negative audio samples in some more interessting
    // way with the screen grab texture.
    
    if(audioRGB.r < 0.0) {
        grabberRGB = grabberRGB * 0.25 + grabber.rgb * 0.75;
    }
    outputColor = vec4(grabberRGB, 1.0);
}