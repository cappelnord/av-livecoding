// vertex shader

#version 150

// these are for the programmable pipeline system and are passed in
// by default from OpenFrameworks
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 textureMatrix;
uniform mat4 modelViewProjectionMatrix; 

uniform vec2 audioDimensions;
uniform vec2 grabberDimensions;


in vec4 position;
in vec4 color;
in vec4 normal;
in vec2 texcoord;
// this is the end of the default functionality

// this is something we're creating for this shader
out vec2 audio_st;
out vec2 grabber_st;

void main(){
    audio_st = texcoord * audioDimensions;
    grabber_st = vec2(texcoord.x, 1.0 - texcoord.y) * grabberDimensions;

    gl_Position = modelViewProjectionMatrix * position;
}