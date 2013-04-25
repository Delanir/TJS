//
//  GameState.m
//  L'Archer
//
//  Created by jp on 22/04/13.
//
//

#import "GameState.h"

#warning Era tótil nice se esta classe salvasse cenas em sitios

@implementation GameState

static GameState* _sharedSingleton = nil;

@synthesize starStates;

+(GameState*)shared
{
	@synchronized([GameState class])
	{
		if (!_sharedSingleton)
			[[self alloc] init];
		return _sharedSingleton;
	}
    
	return nil;
}

+(id)alloc
{
	@synchronized([GameState class])
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
        starStates = [[CCArray alloc] init];
        for (int i = 0; i < 10; i++)
            [starStates addObject: [NSNumber numberWithInt:0]];
    }
	return self;
}


-(void)dealloc
{
    [starStates release];
    [_sharedSingleton release];
    [super dealloc];
}

@end
