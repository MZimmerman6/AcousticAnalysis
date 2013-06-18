//
//  MatlabFunctions.h
//  AudioGenerator
//
//  Created by Matthew Zimmerman on 6/23/12.
//  Copyright (c) 2012 Drexel University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatlabFunctions : NSObject 


+(void) linspace:(float)minVal max:(float)maxVal numElements:(int)size array:(float*)array;

+(void) logspace:(float)minVal max:(float)maxVal numElements:(int)size array:(float*)array;

@end
