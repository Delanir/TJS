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

-(Stimulus*) generateColdStimulusWithValue: (double) value;
-(Stimulus*) generateFireStimulusWithValue: (double) value;
-(Stimulus*) generateDamageStimulusWithValue: (double) value;
-(Stimulus*) generatePushBackStimulusWithValue: (double) value;

@end
