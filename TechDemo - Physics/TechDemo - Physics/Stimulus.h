//
//  Stimulus.h
//  L'Archer
//
//  Created by João Amaral on 13/4/13.
//
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "Constants.h"

@interface Stimulus : NSObject
{
    stimulusType type;
    double value;
    double duration;
}

@property (nonatomic) stimulusType type;
@property (nonatomic) double value, duration;

-(id) initWithStimulusType: (stimulusType) stimulus andValue: (double) val;
-(id) initWithStimulusType: (stimulusType) stimulus value: (double) val andDuration:(double) dur;

@end
