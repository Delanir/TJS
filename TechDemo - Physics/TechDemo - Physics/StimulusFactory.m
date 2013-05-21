//
//  StimulusFactory.m
//  L'Archer
//
//  Created by jp on 13/04/13.
//
//

#import "StimulusFactory.h"
#import "ResourceManager.h"
#import "Registry.h"

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
	if (self != nil)
    {
#ifdef kDebugMode
        [[Registry shared] addToCreatedEntities:self];
#endif
    }
	return self;
}


-(Stimulus*) generateColdStimulusWithValue: (double) value andDuration: (double) duration
{
    Stimulus * coldStimulus = [[Stimulus alloc] initWithStimulusType:kSlowStimulus value:value andDuration:duration];
    [coldStimulus autorelease];
    return coldStimulus;
}

-(Stimulus*) generateFireStimulusWithValue: (double) value andDuration: (double) duration;
{
    Stimulus * fireStimulus = [[Stimulus alloc] initWithStimulusType:kDOTStimulus value:value andDuration:duration];
    [fireStimulus autorelease];
    return fireStimulus;
}

-(Stimulus*) generateDamageStimulusWithValue: (double) value
{
    Stimulus * damageStimulus = [[Stimulus alloc] initWithStimulusType:kDamageStimulus andValue:value];
    [damageStimulus autorelease];
    return damageStimulus;
}

-(Stimulus*) generatePushBackStimulusWithValue: (double) value
{
    Stimulus * pushBackStimulus = [[Stimulus alloc] initWithStimulusType:KPushBackStimulus andValue:value];
    [[ResourceManager shared] spendMana:2.0];
    [pushBackStimulus autorelease];
    return pushBackStimulus;
}



-(void)dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [_sharedSingleton release];
    [super dealloc];
}

@end