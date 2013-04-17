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
    Peasant *peasant = [[Peasant alloc] initWithSprite:@"p_walk01.png" andWindowSize:winSize];
    
    [peasant autorelease];
    
    return peasant;
        
}

-(FaerieDragon*)generateFaerieDragon
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    FaerieDragon *faerieDragon = [[FaerieDragon alloc] initWithSprite:@"fd_fly01.png" andWindowSize:winSize];
    
    [faerieDragon autorelease];
    
    return faerieDragon;
    
}

-(Zealot*)generateZealot
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    Zealot *zealot = [[Zealot alloc] initWithSprite:@"z_walk01.png" andWindowSize:winSize];
    
    [zealot autorelease];
    
    return zealot;
    
}

-(void)dealloc
{
    [_sharedSingleton release];
    [super dealloc];
}

@end