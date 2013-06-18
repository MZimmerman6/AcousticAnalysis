//
//  ViewController.h
//  AcousticAnalysis
//
//  Created by Matthew Zimmerman on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AudioInput.h"
#import "MathFunctions.h"
#import "DrawView.h"
#import "SpectrumView.h"
#import "AudioParameters.h"
#import "SimpleFFT.h"
#import "RangeSlider.h"


@interface ViewController : UIViewController <AudioInputDelegate> {
    
    
    AudioInput *audioIn;
    float *audioBuffer;
    int numBufferSamples;
    
    float *fftBuffer;
    float *fftPhase;
    float *fftMag;
    
    float *fullWaveform;
    float *audioWaveform;
    float *spectrumWaveform;
    
    int numSecondsInBuffer;
    
    float *plottingBuffer;
    
    IBOutlet DrawView *audioDraw;
    IBOutlet SpectrumView *spectrumDraw;
    
    int graphWidth;
    int graphHeight;
    BOOL hasSignal;
    SimpleFFT *fft;
    
    IBOutlet DrawView *fullAudioDraw;
    float *fullAudioIndices;
    float *fullAudioDrawBuffer;
    int fullNumDrawAudioSamples;
    float *fullAudioDrawBufferIndices;
    
    BOOL isRunning;
    UITableViewCell *cell;
    
    RangeSlider *windowSlider;
    
    UIView *leftBox;
    UIView *rightBox;
    int numberSamples;
    float *windowSamples;
    
}

-(void) updateEverything;

-(void) updateDrawings;

-(void) drawAudioWave;

-(void) drawFFT;

-(void) drawFullWave;

-(void) shiftFullWave;

-(IBAction)recordPressed:(id)sender;

-(IBAction)pausePressed:(id)sender;

-(void) showWindowInformation;

-(void) updateTimeLabels;

@end
