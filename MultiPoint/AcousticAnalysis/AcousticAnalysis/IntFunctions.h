//
//  IntFunctions.h
//  AudioAnalysis
//
//  Created by Matthew Zimmerman on 6/27/12.
//  Copyright (c) 2012 Drexel University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntFunctions : NSObject


+(int) range:(int*)array arraySize:(int)arrSize;

+(int) max:(int*)array arraySize:(int)arrSize;

+(int) min:(int*)array arraySize:(int)arrSize;

+(void) abs:(int*)array arraySize:(int)arrSize;


@end
