//
//  FloatFunctions.m
//  AudioGenerator
//
//  Created by Matthew Zimmerman on 6/23/12.
//  Copyright (c) 2012 Drexel University. All rights reserved.
//

#import "FloatFunctions.h"

@implementation FloatFunctions

+(float) max:(float *)array numElements:(int)size {
    if (size > 0) {
        float max = array[0];
        for (int i=0;i<size;i++) {
            if (array[i]>max) {
                max = array[i];
            }
        }
        return max;
    } else {
        NSLog(@"Empty array entered, returning 0");
    }
    return 0;
}

+(float) min:(float *)array numElements:(int)size {
    if (size >0) {
    float min = array[0];
    for (int i=0;i<size;i++) {
        if (array[i]<min) {
            min = array[i];
        }
    }
    return min;
    } else {
        NSLog(@"Empty array entered, returning 0");
    }
    return 0;
}

+(void) round:(float *)array numElements:(int)size {
    for (int i = 0;i<size;i++) {
        array[i] = roundf(array[i]);
    }
}

+(void) ceil:(float *)array numElements:(int)size {
    for (int i = 0;i<size;i++) {
        array[i] = ceilf(array[i]);
    }
}

+(void) floor:(float *)array numElements:(int)size {
    for (int i = 0;i<size;i++) {
        array[i] = floorf(array[i]);
    }
}

+(float) range:(float *)array numElements:(int)size {
    if (size > 0) {
        float min = [self min:array numElements:size];
        float max = [self max:array numElements:size];
        return max-min;
    } else {
        NSLog(@"Empty array entered, returning 0");
    }
    return 0;

}

+(float) abs:(float)value {
    if (value < 0) {
        value = value*-1;
    }
    return value;
}

+(void) normalize:(float*)array numElements:(int)size {
    float max = [self max:array numElements:size];
    float min = [self min:array numElements:size];
    if (abs(min)>max) {
        max = abs(min);
    }
    for (int i = 0;i<size;i++) {
        array[i] = array[i]/max;
    }
    
}


+(void)averageChunks:(float*)arr arraySize:(int)arrSize numChunks:(int)size output:(float*)averages{
    float length = (float)arrSize/size;
    float lower = 0;
    for(int i = 0; i<size; i++){
        float sum = 0;
        for(int j=round(lower);j<round(lower+length);j++){
            sum = sum + arr[j];
        }
        
        int avg = sum/(round(lower+length)-round(lower));
        averages[i] = avg;
        lower = lower + length;
    }
}

@end
