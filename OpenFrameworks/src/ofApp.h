#pragma once

#include "ofMain.h"
#include "ofxOsc.h"
#include <mutex>


class ofApp : public ofBaseApp{
    
    static const int videoGrabberWidth = 1920;
    static const int videoGrabberHeight = 1080;
    
    static const int audioNumChannels = 7;
    static const int audioBufferSize = 1024;
    static const int audioSamplerate = 48000;
    static const int audioArraySize = audioNumChannels * audioBufferSize;
    
    static const int oscPortNumber = 57140;
    
    ofVideoGrabber grabber;
    ofShader shader;
    ofPlanePrimitive plane;
    ofFloatPixels audioPixels;
    ofTexture audioTexture;
    ofSoundStream soundStream;
    
    ofxOscReceiver receiver;
    
    std::mutex mutex;


    
    float audioArray[audioArraySize];
    
    float audioAmplification = 2.0;
    float screenAmplification = 1.0;
    
    private:
        void receiveOSC();


	public:
    
		void setup();
		void update();
		void draw();

        void audioIn (ofSoundBuffer &buffer);

		void keyPressed(int key);
		void keyReleased(int key);
		void mouseMoved(int x, int y );
		void mouseDragged(int x, int y, int button);
		void mousePressed(int x, int y, int button);
		void mouseReleased(int x, int y, int button);
		void mouseEntered(int x, int y);
		void mouseExited(int x, int y);
		void windowResized(int w, int h);
		void dragEvent(ofDragInfo dragInfo);
		void gotMessage(ofMessage msg);
    
};
