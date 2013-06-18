//
//  SpectrumView.h
//  CannonDriver
//
//  Created by Matthew Zimmerman on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpectrumView : UIView {
    
    float *pointValues;
    float *indexValues;
    int numPoints;
    float scaleFactor;
    
}

-(void) plotValues:(float *)array arraySize:(int)size scaleFactor:(float)factor;

-(float*) getSpectrumValues;

-(float) getScaleFactor;

-(float) getValueAtIndex:(int)index;

@end
