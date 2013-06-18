//
//  MatlabFunctions.m
//  AudioGenerator
//
//  Created by Matthew Zimmerman on 6/23/12.
//  Copyright (c) 2012 Drexel University. All rights reserved.
//

#import "MatlabFunctions.h"

@implementation MatlabFunctions

+(void) linspace:(float)minVal max:(float)maxVal numElements:(int)size array:(float*)array {
    
    float step = (maxVal-minVal)/(size-1);
    array[0] = minVal;
    int i;
    for (i = 1;i<size-1;i++) {
        array[i] = array[i-1]+step;
    }
    array[size-1] = maxVal;
}

+(void) logspace:(float)minVal max:(float)maxVal numElements:(int)size array:(float *)array {
    
    float min = log10f(minVal);
    float max = log10f(maxVal);
    [self linspace:min max:max numElements:size array:array];
    for (int i = 0;i<size;i++) {
        array[i] = powf(10,array[i]);
    }
}

@end
