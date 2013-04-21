//
//  StimulusFactory.m
//  L'Archer
//
//  Created by jp on 13/04/13.
//
//

#import "StimulusFactory.h"

@implementation StimulusFactory

static StimulusFactory* _sharedSingleton = nil;

+(StimulusFactory*)shared
{
	@synchronized([StimulusFactory class])
	{
		if (!_sharedSingleton)
			[[self alloc] init];
        
		return _sharedSingleton;
	}
    
	return nil;
}

+(id)alloc
{
	@synchronized([StimulusFactory class])
	{
		NSAssert(_sharedSingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedSingleton = [super alloc];
		return _sharedSingleton;
	}
    
	return nil;
}

-(id)init
{
	self = [super init];
	if (self != nil) {
		// initialize stuff here
        
    }
	return self;
}


-(Stimulus*) generateColdStimulusWithValue: (double) value
{
    Stimulus * coldStimulus = [[Stimulus alloc] initWithStimulusType:slow andValue:value];
    [coldStimulus autorelease];
    return coldStimulus;
}

-(Stimulus*) generateFireStimulusWithValue: (double) value
{
    Stimulus * fireStimulus = [[Stimulus alloc] initWithStimulusType:dot andValue:value];
    [fireStimulus autorelease];
    return fireStimulus;
}

-(Stimulus*) generateDamageStimulusWithValue: (double) value
{
    Stimulus * damageStimulus = [[Stimulus alloc] initWithStimulusType:damage andValue:value];
    [damageStimulus autorelease];
    return damageStimulus;
}

-(Stimulus*) generatePushBackStimulusWithValue: (double) value
{
    Stimulus * pushBackStimulus = [[Stimulus alloc] initWithStimulusType:pushBack andValue:value];
    [pushBackStimulus autorelease];
    return pushBackStimulus;
}



-(void)dealloc
{
    [_sharedSingleton release];
    [super dealloc];
}

@end