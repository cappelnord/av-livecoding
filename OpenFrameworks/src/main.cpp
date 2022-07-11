#include "ofMain.h"
#include "ofApp.h"

//========================================================================
int main( ){
    
    ofGLFWWindowSettings settings;
    settings.setGLVersion(3, 2); //we define the OpenGL version we want to use
    settings.setSize(1920, 1080);
    // settings.windowMode = OF_WINDOW;
    settings.windowMode = OF_FULLSCREEN;
    
    // show on extended monitor
    settings.monitor = 1;

    ofCreateWindow(settings);

	ofRunApp(new ofApp());
    
    

}
