//
//  CollisionManager.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "CollisionManager.h"

@implementation CollisionManager

static CollisionManager* _sharedSingleton = nil;

+(CollisionManager*)shared
{
	@synchronized([CollisionManager class])
	{
		if (!_sharedSingleton)
			[[self alloc] init];
        
		return _sharedSingleton;
	}
    
	return nil;
}

+(id)alloc
{
	@synchronized([CollisionManager class])
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
        _targets = [[NSMutableArray alloc] init];
        _projectiles = [[NSMutableArray alloc] init];
	}
    
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    [_targets release];
    _targets = nil;
    [_projectiles release];
    _projectiles = nil;
    //Dealloc stuff below this line
    [_sharedSingleton release];
	[super dealloc];
}

-(void)dummyMethod
{
    return;
}


- (void)updateSimpleCollisions:(ccTime)dt {
    
    NSMutableArray *projectilesToDelete = [[NSMutableArray alloc] init];
    for (Projectile* projectile in _projectiles) {
        CCSprite * projectileSprite = [projectile sprite];
        CGRect projectileRect = CGRectMake(
                                           projectile.position.x - (projectileSprite.contentSize.width/2),
                                           projectile.position.y - (projectileSprite.contentSize.height/2),
                                           projectileSprite.contentSize.width,
                                           projectileSprite.contentSize.height);
        
        NSMutableArray *targetsToDelete = [[NSMutableArray alloc] init];
        for (Enemy *target in _targets) {
            CCSprite *targetSprite = [target sprite];
            CGRect targetRect = CGRectMake(
                                           target.position.x - (targetSprite.contentSize.width/2),
                                           target.position.y - (targetSprite.contentSize.height/2),
                                           targetSprite.contentSize.width,
                                           targetSprite.contentSize.height);
            
            if (CGRectIntersectsRect(projectileRect, targetRect)) {
                [targetsToDelete addObject:target];
            }
        }
        
        for (Enemy *target in targetsToDelete) {
            [target destroySprite];
            [_targets removeObject:target];
        }
        
        if (targetsToDelete.count > 0) {
            [projectilesToDelete addObject:projectile];
        }
        [targetsToDelete release];
    }
    for (Projectile *projectile in projectilesToDelete) {
        [projectile destroySprite];
        [_projectiles removeObject:projectile];
    }
    [projectilesToDelete release];
}

-(void)updatePixelPerfectCollisions:(ccTime)dt
{
    NSLog(@"PIXEL PERFEEEEECT");
}

-(void)addToTargets: (Enemy*) target
{
    [_targets addObject:target];
    // For debugging purposes
    // NSLog(@"Units in Targets array: %i", [_targets count]);
    
}

-(void)removeFromTargets: (Enemy*) target
{
    [_targets removeObject:target];
}

-(void)addToProjectiles: (Projectile*) projectile
{
    [_projectiles addObject:projectile];
    // For debugging purposes
    // NSLog(@"Units in Projectiles array: %i", [_projectiles count]);
}

-(void)removeFromProjectiles: (Projectile*) projectile
{
    [_projectiles removeObject:projectile];
}

@end