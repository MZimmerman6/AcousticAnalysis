//
//  ViewController.m
//  AcousticAnalysis
//
//  Created by Matthew Zimmerman on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "RangeSlider.h"
#define kFFTSize 1024
#define kFFTScaleFactor 150

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    numSecondsInBuffer = 5;
    fullWaveform = (float*)calloc(kInputSampleRate*numSecondsInBuffer, sizeof(float));
    audioBuffer = (float*)calloc(kInputNumSamples, sizeof(float));
    [audioDraw setDrawEnabled:NO];
    isRunning = NO;
    
    audioIn = [[AudioInput alloc] initWithDelegate:self];
    graphWidth = (int)audioDraw.frame.size.width;
    graphHeight = (int)audioDraw.frame.size.height;
    
    fftBuffer = (float*)calloc(kInputNumSamples*2, sizeof(float));
    fftPhase = (float*)calloc(kFFTSize, sizeof(float));
    fftMag = (float*)calloc(kFFTSize, sizeof(float));
    plottingBuffer = (float*)calloc(graphWidth, sizeof(float));
    
    fft = [[SimpleFFT alloc] init];
    [fft fftSetSize:kFFTSize];
    fullAudioIndices = (float*)calloc(fullAudioDraw.frame.size.width, sizeof(float));
    [MatlabFunctions linspace:0 max:kInputSampleRate*numSecondsInBuffer numElements:fullAudioDraw.frame.size.width array:fullAudioIndices];

    [fullAudioDraw setDrawEnabled:NO];
    fullAudioDrawBuffer = (float*)calloc(fullAudioDraw.frame.size.width, sizeof(float));
    
    for (int i = 0;i<fullAudioDraw.frame.size.width;i++) {
        fullAudioDrawBuffer[i] = fullAudioDraw.frame.size.height/2;
    }
//    fullWaveDrawBuffer = (float*)calloc(fullAudioDraw.frame.size.width, sizeof(float));s
    fullNumDrawAudioSamples = (int)ceil((kInputNumSamples/(kInputSampleRate*numSecondsInBuffer))*fullAudioDraw.frame.size.width);
    fullAudioDrawBufferIndices = (float*)calloc(fullNumDrawAudioSamples, sizeof(float));
    [MatlabFunctions linspace:0 max:fullAudioDraw.frame.size.width numElements:fullNumDrawAudioSamples array:fullAudioDrawBufferIndices];
    
	// Do any additional setup after loading the view, typically from a nib.
    [self drawFullWave];
    [self drawFFT];
    [self drawAudioWave];
    
    CGAffineTransform move = CGAffineTransformMakeTranslation(23, 500);
    windowSlider = [[RangeSlider alloc] initWithFrame:CGRectMake(0, 100, 720, 200)];
    [windowSlider setMaximumValue:kInputSampleRate*numSecondsInBuffer];
    [windowSlider setMinimumValue:0];
    [windowSlider setSelectedMaximumValue:kInputSampleRate*numSecondsInBuffer/2+20*kInputNumSamples];
    [windowSlider setSelectedMinimumValue:kInputSampleRate*numSecondsInBuffer/2];
    [windowSlider setMinimumRange:5*kInputNumSamples];
    windowSlider.transform = move;
    [windowSlider addTarget:self action:@selector(valueChangedForDoubleSlider:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:windowSlider];
    
    
    float frameWidth = (windowSlider.selectedMinimumValue/(kInputSampleRate*numSecondsInBuffer))*fullAudioDraw.frame.size.width;
    leftBox = [[UIView alloc] initWithFrame:CGRectMake(34, 655, frameWidth, 86)];
    leftBox.backgroundColor = [UIColor lightGrayColor];
    leftBox.alpha = 0.6;
    [self.view addSubview:leftBox];
    
    
    float rightStart = (windowSlider.selectedMaximumValue/(kInputSampleRate*numSecondsInBuffer))*fullAudioDraw.frame.size.width+fullAudioDraw.frame.origin.x;
    rightBox = [[UIView alloc] initWithFrame:CGRectMake(rightStart, 655, fullAudioDraw.frame.size.width-rightStart+fullAudioDraw.frame.origin.x, 86)];
    [rightBox setBackgroundColor:[UIColor lightGrayColor]];
    [rightBox setAlpha:0.6];
    [self.view addSubview:rightBox];
    
    windowSamples = (float*)calloc(kInputNumSamples*5, sizeof(float));
    [spectrumDraw setBackgroundColor:[UIColor clearColor]];
    [audioDraw setBackgroundColor:[UIColor clearColor]];
    [fullAudioDraw setBackgroundColor:[UIColor clearColor]];
    
    
    numberSamples = kInputNumSamples;
    CGAffineTransform rotate = CGAffineTransformMakeRotation(-M_PI/4.0);
    for (int i = 1;i<=9;i++) {
        UILabel *graphFreqLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*70+38, 135, 40,30)];
        graphFreqLabel.text = [NSString stringWithFormat:@"%.3f",(i/10.0)*(20*numberSamples/kInputSampleRate)];
        graphFreqLabel.textColor = [UIColor grayColor];
        graphFreqLabel.alpha = 0.8;
        graphFreqLabel.backgroundColor = [UIColor clearColor];
        graphFreqLabel.tag = i+1000;
        graphFreqLabel.font = [UIFont systemFontOfSize:12.5];
        graphFreqLabel.transform = rotate;
        [self.view addSubview:graphFreqLabel];
        
    }
    
}

-(void) updateTimeLabels {
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            if ([subView tag] > 1000 && [subView tag] < 1010) {
                UILabel *tempLabel = (UILabel*)subView;
                tempLabel.text = [NSString stringWithFormat:@"%.3f",(([subView tag]-1000)/10.0)*(numberSamples/kInputSampleRate)];
            }
        }
    }
}

-(void) valueChangedForDoubleSlider:(id)sender {
    
    float frameWidth = (windowSlider.selectedMinimumValue/(kInputSampleRate*numSecondsInBuffer))*fullAudioDraw.frame.size.width;
    leftBox.frame = CGRectMake(34, 655, frameWidth, 86);
    
    float rightStart = (windowSlider.selectedMaximumValue/(kInputSampleRate*numSecondsInBuffer))*fullAudioDraw.frame.size.width+fullAudioDraw.frame.origin.x;
    rightBox.frame = CGRectMake(rightStart, 655, fullAudioDraw.frame.size.width-rightStart+fullAudioDraw.frame.origin.x, 86);
    [leftBox setNeedsDisplay];
    [rightBox setNeedsDisplay];
    
    
    int min = (int)round([windowSlider selectedMinimumValue]);
    int max = (int)round([windowSlider selectedMaximumValue]);
    numberSamples = max-min;
    
    if (!isRunning) {
        [self updateTimeLabels];
        [self showWindowInformation];
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
            interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

-(void) processInputBuffer:(float*)buffer numSamples:(int)numSamples {
    hasSignal = NO;
    for (int i = 0;i<numSamples;i++) {
        audioBuffer[i] = buffer[i];
    }
    numBufferSamples = numSamples;
    [self performSelectorOnMainThread:@selector(updateEverything) withObject:nil waitUntilDone:NO];
}

-(void) updateEverything {
    
    [self shiftFullWave];
    int count = 0 ;
    for (int i = kInputSampleRate*numSecondsInBuffer-numBufferSamples+1;i<kInputSampleRate*numSecondsInBuffer;i++) {
        fullWaveform[i] = audioBuffer[count];
        count++;
    }
    count = 0;
    [self shiftFullDrawBuffer];
    for (int i = fullAudioDraw.frame.size.width-fullNumDrawAudioSamples;i<fullAudioDraw.frame.size.width;i++) {
        fullAudioDrawBuffer[i] = audioBuffer[(int)round(fullAudioDrawBufferIndices[count])]*fullAudioDraw.frame.size.height/2+fullAudioDraw.frame.size.height/2;
        count++;
    }
    
    [self updateDrawings];
//    [self showWindowInformation];
}

-(void) updateDrawings {
    [self drawAudioWave];
    [self drawFFT];
    [self drawFullWave];
}

-(void) drawAudioWave {
    
    float *indices = (float*)calloc(graphWidth, sizeof(float));
    [MatlabFunctions linspace:0 max:numBufferSamples numElements:graphWidth array:indices];
    for (int i = 0; i<graphWidth; i++) {
        plottingBuffer[i] = audioBuffer[(int)round(indices[i])]*graphHeight/2+graphHeight/2;
    }
    [audioDraw setWaveform:plottingBuffer arraySize:graphWidth];
    free(indices);
}

-(void) drawFFT {
    
    for (int i = 0;i<numBufferSamples;i++) {
        fftBuffer[i] = audioBuffer[i];
        fftBuffer[i+1] = audioBuffer[i+1];
    }
    
    [fft forwardWithStart:0 withBuffer:fftBuffer magnitude:fftMag phase:fftPhase useWinsow:NO];
    [spectrumDraw plotValues:fftMag arraySize:kFFTSize/8.0 scaleFactor:kFFTScaleFactor];
}

-(void) drawFullWave {
    
    [fullAudioDraw setWaveform:fullAudioDrawBuffer arraySize:fullAudioDraw.frame.size.width];  
    
}

-(void) shiftFullWave {
    for (int i = numBufferSamples;i<kInputSampleRate*numSecondsInBuffer;i++) {
        fullWaveform[i-numBufferSamples] = fullWaveform[i];
    }
}

-(void) shiftFullDrawBuffer {
    for (int i = fullNumDrawAudioSamples;i<fullAudioDraw.frame.size.width;i++) {
        fullAudioDrawBuffer[i-fullNumDrawAudioSamples] = fullAudioDrawBuffer[i];
    }
}

-(IBAction)recordPressed:(id)sender {
    numberSamples = kInputNumSamples;
    [self updateTimeLabels];
    if (!isRunning) {
        [audioIn start];
        isRunning = YES;
    }
}

-(IBAction)pausePressed:(id)sender {
    if (isRunning) {
        
        int min = (int)round([windowSlider selectedMinimumValue]);
        int max = (int)round([windowSlider selectedMaximumValue]);
        numberSamples = max-min;
        [self updateTimeLabels];
        [audioIn stop];
        isRunning = NO;
        [self showWindowInformation];
    }
}

-(void) showWindowInformation {
    
    int minIndex = (int)round([windowSlider selectedMinimumValue]);
    int maxIndex = (int)round([windowSlider selectedMaximumValue]);
    
    int numSamples = maxIndex - minIndex+1;
    free(windowSamples);
    windowSamples = (float*)calloc(numSamples, sizeof(float));
    
    int count = 0;
    for (int i = minIndex;i<maxIndex;i++) {
        windowSamples[count] = fullWaveform[i];
        count++;
    }
    float *indices = (float*)calloc(graphWidth, sizeof(float));
    [MatlabFunctions linspace:minIndex max:maxIndex numElements:graphWidth array:indices];
    
    for (int i = 0;i<graphWidth;i++) {
        plottingBuffer[i] = fullWaveform[(int)round(indices[i])]*graphHeight/2+graphHeight/2;
    }
    free(indices);
    [audioDraw setWaveform:plottingBuffer arraySize:graphWidth];
    [fft forwardWithStart:0 withBuffer:windowSamples magnitude:fftMag phase:fftPhase useWinsow:YES];
    [spectrumDraw plotValues:fftMag arraySize:kFFTSize/8.0 scaleFactor:kFFTScaleFactor];
    
}



@end
