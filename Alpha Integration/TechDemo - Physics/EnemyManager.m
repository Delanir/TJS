//
//  EnemyManager.m
//  Alpha Integration
//
//  Created by MiniclipMacBook on 4/7/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "EnemyManager.h"



@implementation EnemyManager

static EnemyManager* _sharedSingleton = nil;

+(EnemyManager*)shared
{
	@synchronized([EnemyManager class])
	{
		if (!_sharedSingleton)
			[[self alloc] init];
        
		return _sharedSingleton;
	}
    
	return nil;
}

+(id)alloc
{
	@synchronized([EnemyManager class])
	{
		NSAssert(_sharedSingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedSingleton = [super alloc];
		return _sharedSingleton;
	}
    
	return nil;
}

-(void)addToEnemies: (Enemy*) target
{
    [_enemies addObject:target];
    
}



-(void)removeEnemy: (Enemy*) target
{
    [_enemies removeObject:target];
}


- (id) init
{
    if ((self = [super init])) {
        _enemies = [[NSMutableArray alloc] init];
    }
    return self;
}
    


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    [_enemies release];
    _enemies = nil;
    
    [super dealloc];
}
    

@end

