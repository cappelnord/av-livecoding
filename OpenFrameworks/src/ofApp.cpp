#include "ofApp.h"


//--------------------------------------------------------------
void ofApp::setup(){
    
    ofSetVerticalSync(true);
    
    ofSoundStreamSettings soundStreamSettings;
    
    soundStream.printDeviceList();
    
    // Select which audio device you want to use.
    
    // string deviceName = "Existential Audio Inc.: BlackHole 16ch";
    string deviceName = "MOTU, Inc: UltraLite-Patrick";
    
    vector<ofSoundDevice> devices = soundStream.getMatchingDevices(deviceName);
    
    soundStreamSettings.setInDevice(devices[0]);
    soundStreamSettings.numInputChannels = audioNumChannels;
    soundStreamSettings.numOutputChannels = 0;
    soundStreamSettings.numBuffers = 1;
    soundStreamSettings.bufferSize = audioBufferSize;
    soundStreamSettings.sampleRate = audioSamplerate;
    soundStreamSettings.setInListener(this);
    soundStream.setup(soundStreamSettings);
    
    
    string videoDeviceName = "OBS Virtual Camera";
    vector<ofVideoDevice> videoDevices = grabber.listDevices();
            
    for(vector<ofVideoDevice>::iterator it = videoDevices.begin(); it != videoDevices.end(); ++it) {
        if(it->deviceName == videoDeviceName) {
            grabber.setDeviceID(it->id);
            break;
        }
    }
    
    // I use a OBS Virtual camera here to record my screen and pass
    // to this OpenFrameworks app. I was sad, that this was not possible
    // with Syphon (on Mac) at the moment!

    grabber.initGrabber(videoGrabberWidth, videoGrabberHeight);
    shader.load("lcav-screen");
    
    // plane.set(ofGetWidth(), audioBufferSize);
    plane.set(ofGetWidth(), ofGetHeight());

    
    plane.setPosition({ofGetWidth()/2, ofGetHeight()/2, 0.0f});
    
    audioPixels.allocate(audioNumChannels, audioBufferSize, OF_IMAGE_GRAYSCALE);
    
    audioTexture.setTextureMinMagFilter(GL_NEAREST, GL_NEAREST);
    
    receiver.setup(oscPortNumber);
    
}

void ofApp::receiveOSC() {
    while (receiver.hasWaitingMessages()) {
        ofxOscMessage m;
        receiver.getNextMessage(&m);
        
        if (m.getAddress() == "/audio") {
            audioAmplification = m.getArgAsFloat(0);
        }
        
        if (m.getAddress() == "/screen") {
            screenAmplification = m.getArgAsFloat(0);
        }
    }
}

//--------------------------------------------------------------
void ofApp::update(){
    receiveOSC();
    
    grabber.update();
    
    mutex.lock();
    audioTexture.loadData(audioPixels);
    mutex.unlock();
    
    // Uncommenting this is nice when you want to deal with the shader:
    // It will recompile the shader on every frame. This is of course also
    // very wasteful! Better would be to check if the shader has actually
    // changed but as I don't do this (at the moment) while performing
    // I opted in for this simole version.
    
    // shader.load("lcav-screen");

}

//--------------------------------------------------------------
void ofApp::draw(){
    ofBackground(0, 0, 0);
    ofSetColor(255);
    shader.begin();
    
    shader.setUniformTexture("audioTex", audioTexture, 0);
    shader.setUniformTexture("grabberTex",  grabber.getTexture(), 1);

    shader.setUniform2f("windowDimensions", ofGetWidth(), ofGetHeight());
    shader.setUniform2f("grabberDimensions", videoGrabberWidth, videoGrabberHeight);
    shader.setUniform2f("audioDimensions", audioNumChannels, audioBufferSize);
    
    shader.setUniform1f("audioAmp", audioAmplification);
    shader.setUniform1f("screenAmp", screenAmplification);

    plane.draw();
    shader.end();
}

void ofApp::audioIn (ofSoundBuffer &buffer){
    vector<float> rawBuffer = buffer.getBuffer();
    
    mutex.lock();
    audioPixels.setFromExternalPixels(rawBuffer.data(), audioNumChannels, audioBufferSize, 1);
    mutex.unlock();
}

// From here on only OpenFramework Stubs

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}
