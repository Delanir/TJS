//
//  StimulusFactory.h
//  L'Archer
//
//  Created by jp on 13/04/13.
//
//

#import <Foundation/Foundation.h>
#import "Stimulus.h"

@interface StimulusFactory : NSObject
{
    
}

+(StimulusFactory*)shared;

-(Stimulus*) generateColdStimulusWithValue: (double) value andDuration: (double) duration;
-(Stimulus*) generateFireStimulusWithValue: (double) value andDuration: (double) duration;
-(Stimulus*) generateDamageStimulusWithValue: (double) value;
-(Stimulus*) generatePushBackStimulusWithValue: (double) value;

@end
