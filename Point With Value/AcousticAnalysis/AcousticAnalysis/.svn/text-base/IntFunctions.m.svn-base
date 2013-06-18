//
//  IntFunctions.m
//  AudioAnalysis
//
//  Created by Matthew Zimmerman on 6/27/12.
//  Copyright (c) 2012 Drexel University. All rights reserved.
//

#import "IntFunctions.h"

@implementation IntFunctions

+(int) max:(int *)array arraySize:(int)arrSize {
    if (arrSize>0) {
        int max = array[0];
        for (int i = 1;i<arrSize;i++) {
            if (array[i]>max){
                max = array[i];
            }
        }
        return max;
    }
    return 0;
}

+(int) min:(int *)array arraySize:(int)arrSize {
    int min = array[0];
    for (int i = 1;i<arrSize;i++) {
        if (array[i]<min){
            min = array[i];
        }
    }
    return min;
}

+(int) range:(int *)array arraySize:(int)arrSize {
    int min = [self min:array arraySize:arrSize];
    int max = [self max:array arraySize:arrSize];
    return max-min;
}

+(void) abs:(int *)array arraySize:(int)arrSize {
    for (int i = 0; i<arrSize; i++) {
        array[i] = abs(array[i]);
    }
}




@end
