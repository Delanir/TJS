//
//  GameState.m
//  L'Archer
//
//  Created by jp on 22/04/13.
//
//

#import "GameState.h"

@implementation GameState

static GameState* _sharedSingleton = nil;

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
	if (self != nil) {
		NSLog(@"Game State initialized");
    }
	return self;
}


-(void)dealloc
{
    [_sharedSingleton release];
    [super dealloc];
}

@end
