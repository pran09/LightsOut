//
//  LinearLightsOut.h
//  LightsOut
//
//  Created by Praneet Chakraborty on 4/2/18.
//  Copyright © 2018 Praneet CSSE484. All rights reserved.
//

#import <Foundation/Foundation.h>
#define MAX_NUM_LIGHTS 100

@interface LinearLightsOut : NSObject {
    BOOL lightStates[MAX_NUM_LIGHTS];
}

@property (nonatomic) NSInteger movesTaken;
@property (nonatomic) BOOL solved;

- (id) initWithNumLights:(NSInteger) numLights;
- (BOOL) pressedLightAtIndex:(NSInteger) lightIndex; //yes if game is won
- (void) flipLights:(NSInteger) index;
- (BOOL) getLightStates:(NSInteger) index;

@end
