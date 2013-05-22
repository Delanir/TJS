//
//  Stimulus.m
//  L'Archer
//
//  Created by João Amaral on 13/4/13.
//
//

#import "Stimulus.h"
#import "Registry.h"

@implementation Stimulus

@synthesize type, value, duration;

-(id) initWithStimulusType: (stimulusType) stimulus andValue: (double) val
{
    if(self = [super init])
    {
#ifdef kDebugMode
        [[Registry shared] addToCreatedEntities:self];
#endif
        [self setType:stimulus];
        [self setValue:val];
    }
    return self;
}

-(id) initWithStimulusType:(stimulusType)stimulus value:(double)val andDuration:(double)dur
{
    if(self = [super init])
    {
#ifdef kDebugMode
        [[Registry shared] addToCreatedEntities:self];
#endif
        [self setType:stimulus];
        [self setValue:val];
        [self setDuration:dur];
    }
    return self;
}

-(void) dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [super dealloc];
}


@end
