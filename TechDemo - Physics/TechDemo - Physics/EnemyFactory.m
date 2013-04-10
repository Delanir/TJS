//
//  EnemyFactory.m
//  TechDemo - Physics
//
//  Created by jp on 03/04/13.
//
//

#import "EnemyFactory.h"

@implementation EnemyFactory

static EnemyFactory* _sharedSingleton = nil;

+(EnemyFactory*)shared
{
	@synchronized([EnemyFactory class])
	{
		if (!_sharedSingleton)
			[[self alloc] init];
        
		return _sharedSingleton;
	}
    
	return nil;
}

+(id)alloc
{
	@synchronized([EnemyFactory class])
	{
		NSAssert(_sharedSingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedSingleton = [super alloc];
		return _sharedSingleton;
	}
    
	return nil;
}

-(id)init {
	self = [super init];
	if (self != nil) {
		// initialize stuff here
    
    }
	return self;
}



-(Peasant*)generatePeasant
{
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    Peasant *peasant = [[Peasant alloc] initWithSprite:@"walk01.png" andWindowSize:winSize];
    
    [peasant autorelease];
    
    return peasant;
        
}

-(void)dealloc
{
    [super dealloc];
}

@end