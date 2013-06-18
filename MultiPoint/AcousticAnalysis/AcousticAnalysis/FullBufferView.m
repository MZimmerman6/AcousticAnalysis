//
//  SpectrumView.m
//  CannonDriver
//
//  Created by Matthew Zimmerman on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FullBufferView.h"
#import "MathFunctions.h"

@implementation FullBufferView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        indexValues = (float*)calloc(self.frame.size.width, sizeof(float));
        pointValues = (float*)calloc(self.frame.size.width, sizeof(float));
        numPoints = self.frame.size.width;
    }
    return self;
}



-(void) plotBuffer:(float *)buffer arraySize:(int)size scaleFactor:(float)factor {
    
    numPoints = size;
    [MatlabFunctions linspace:0 max:numPoints numElements:self.frame.size.width array:indexValues];
    
    for (int i = 1;i<self.frame.size.width;i++) {
        float sum =0;
        float count = 0;
        for (int j=(int)roundf(indexValues[i-1]);i<roundf(indexValues[i]);i++) {
            count+=1;
            sum += buffer[j];
        }
        float RMSE = sqrtf(pow(sum/count,2));
        pointValues[i] = RMSE;
    }
    
    //    [MatlabFunctions linspace:0 max:(int)roundf(size/2.0) numElements:self.frame.size.width array:indexValues];
//    for (int i = 0;i<numPoints;i++) {
//        pointValues[i] = array[i];
//    }
//    //    [FloatFunctions normalize:pointValues numElements:numPoints];
//    
//    
    for (int i = 0;i<numPoints;i++) {
        pointValues[i] /= factor;
        pointValues[i] = -pointValues[i]*self.frame.size.height+self.frame.size.height;
        if (pointValues[i] < 0) {
            pointValues[i] = 0;
        }
    }
    
    
    [self setNeedsDisplay];
}

-(void) drawRect:(CGRect)rect {
    //    NSLog(@"drawing");
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGPoint prevPoint = CGPointMake(0, self.frame.size.height);
    for (int i = 0;i<numPoints;i++) {
        CGContextMoveToPoint(context,prevPoint.x,prevPoint.y);
        CGContextAddLineToPoint(context,indexValues[i],pointValues[i]);
        prevPoint = CGPointMake(indexValues[i], pointValues[i]);
        CGContextStrokePath(context);
    }
    CGContextMoveToPoint(context,prevPoint.x,prevPoint.y);
    CGContextAddLineToPoint(context,self.frame.size.width ,self.frame.size.height);
    CGContextStrokePath(context);
}




@end
