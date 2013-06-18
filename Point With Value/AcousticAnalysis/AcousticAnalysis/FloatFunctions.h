//
//  FloatFunctions.h
//  AudioGenerator
//
//  Created by Matthew Zimmerman on 6/23/12.
//  Copyright (c) 2012 Drexel University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FloatFunctions : NSObject

//+(void) sort:(float*)array numElements:(int)size;

+(float) max:(float*)array numElements:(int)size;

+(float) min:(float*)array numElements:(int)size;

+(void) round:(float*)array numElements:(int)size;

+(void) floor:(float*)array numElements:(int)size;

+(void) ceil:(float*)array numElements:(int)size;

+(float) range:(float*)array numElements:(int)size;

+(float) abs:(float)value;

+(void) normalize:(float*)array numElements:(int)size;

+(void)averageChunks:(float*)arr arraySize:(int)arrSize numChunks:(int)size output:(float*)averages;

@end
