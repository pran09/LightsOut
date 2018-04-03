//
//  LinearLightsOut.m
//  LightsOut
//
//  Created by Praneet Chakraborty on 4/2/18.
//  Copyright © 2018 Praneet CSSE484. All rights reserved.
//

#import "LinearLightsOut.h"

@implementation LinearLightsOut

- (id) initWithNumLights:(NSInteger) numLights {
    self = [super init];
    self.movesTaken = 0;
    self.solved = false;
    int i;
    for(i = 0; i < numLights; i++) {
        NSInteger rand = (NSInteger)(arc4random_uniform(2));
        if(rand == 0){
            lightStates[i] = false;
            continue;
        }
        lightStates[i] = true;
    }
    return self;
}

- (BOOL) pressedLightAtIndex:(NSInteger) lightIndex {
    if (!_solved) {
        _movesTaken++;
        if (lightStates[lightIndex]) {
            lightStates[lightIndex] = false;
            [self flipLights:lightIndex];
        }
        else {
            lightStates[lightIndex] = true;
            [self flipLights:lightIndex];
        }
        int i;
        for(i = 0; i < 13; i++) {
            if (lightStates[i]) {
                return false;
            }
        }
        _solved = true;
        return true;
    }
    return true;
}

- (void) flipLights:(NSInteger) index {
    if(index == 0) { //flips second light if first light is flipped
        if(lightStates[1]) {
            lightStates[1] = false;
        }
        else {
            lightStates[1] = true;
        }
    }
    else if(index == 12) { //flips second to last light if last light is flipped
        if(lightStates[11]) {
            lightStates[11] = false;
        }
        else {
            lightStates[11] = true;
        }
    }
    else { //if any middle light is selected
        if(lightStates[index+1]) { //takes care of one directly after
            lightStates[index+1] = false;
        }
        else {
            lightStates[index+1] = true;
        }
        
        if(lightStates[index-1]) { //takes care of one directly before
            lightStates[index-1] = false;
        }
        else {
            lightStates[index-1] = true;
        }
    }
}

- (BOOL) getLightStates:(NSInteger) index {
	return lightStates[index];
}

@end
