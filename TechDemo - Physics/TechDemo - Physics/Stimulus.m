//
//  Stimulus.m
//  L'Archer
//
//  Created by João Amaral on 13/4/13.
//
//

#import "Stimulus.h"

@implementation Stimulus

@synthesize type, value;

-(id) initWithStimulusType: (stimulusType) stimulus andValue: (double) val
{
    if(self = [super init])
    {
        [self setType:stimulus];
        [self setValue:val];
    }
    return self;
}

@end
