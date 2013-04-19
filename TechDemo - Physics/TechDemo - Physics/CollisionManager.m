//
//  CollisionManager.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "CollisionManager.h"
#import "ResourceManager.h"

// Sound interface
#import "SimpleAudioEngine.h"

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
        _targets = [[CCArray alloc] init];
        _projectiles = [[CCArray alloc] init];
        _walls = [[CCArray alloc] init];
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

// SO DEPRECATED
- (void)updateSimpleCollisions:(ccTime)dt
{
    
    CCArray *projectilesToDelete = [[CCArray alloc] init];
    for (Projectile* projectile in _projectiles)
    {
        KKPixelMaskSprite * projectileSprite = [projectile sprite];
        CGRect projectileRect = CGRectMake(
                                           projectileSprite.position.x - (projectileSprite.contentSize.width/2),
                                           projectileSprite.position.y - (projectileSprite.contentSize.height/2),
                                           projectileSprite.contentSize.width,
                                           projectileSprite.contentSize.height);
        
        CCArray *targetsToDelete = [[CCArray alloc] init];
        for (Enemy *target in _targets)
        {
            KKPixelMaskSprite *targetSprite = [target sprite];
            CGRect targetRect = CGRectMake(
                                           targetSprite.position.x - (targetSprite.contentSize.width/2),
                                           targetSprite.position.y - (targetSprite.contentSize.height/2),
                                           targetSprite.contentSize.width,
                                           targetSprite.contentSize.height);
            
            if (CGRectIntersectsRect(projectileRect, targetRect)) 
                [targetsToDelete addObject:target];
            
        }
        
        for (Enemy *target in targetsToDelete)
        {
            [[SimpleAudioEngine sharedEngine] playEffect:@"hit.mp3"];
#warning por no config.plist
            [target destroySprite];
            [_targets removeObject:target];
        }
        
        if (targetsToDelete.count > 0)
            [projectilesToDelete addObject:projectile];
        
        [targetsToDelete release];
    }
    for (Projectile *projectile in projectilesToDelete)
    {
        [projectile destroySprite];
        [_projectiles removeObject:projectile];
    }
    [projectilesToDelete release];
}

-(void)updatePixelPerfectCollisions:(ccTime)dt
{
    
    CCArray *projectilesToDelete = [[CCArray alloc] init];
    for (Projectile* projectile in _projectiles)
    {
        KKPixelMaskSprite * projectileSprite = [projectile sprite];
        
        CCArray *targetsToDelete = [[CCArray alloc] init];
        for (Enemy *target in _targets)
        {
            KKPixelMaskSprite *targetSprite = [target sprite];
            if ([targetSprite pixelMaskContainsPoint:[projectileSprite position]])
            {
                [targetsToDelete addObject:target];
                break;              // Cada flecha só mata um
            }
        }
        
        for (Enemy *target in targetsToDelete)
        {
            [[SimpleAudioEngine sharedEngine] playEffect:@"hit.mp3"];
#warning por no config.plist
            [_targets removeObject:target];
            [target die];
        }
        
        if (targetsToDelete.count > 0)
            [projectilesToDelete addObject:projectile];
            
        [targetsToDelete release];
    }
    for (Projectile *projectile in projectilesToDelete)
    {
        [_projectiles removeObject:projectile];
        [projectile destroy];
        [[ResourceManager shared] increaseEnemyHitCount];
    }
    [projectilesToDelete release];
}

-(void)updateWallsAndEnemies:(ccTime)dt
{
    for (KKPixelMaskSprite* wall in _walls)
        for (Enemy *target in _targets)
            if ([wall pixelMaskContainsPoint:[[target sprite] position]])
                [target attack];
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


-(void)addToWalls: (CCSprite*) wall
{
    [_walls addObject:wall];
}

-(void)removeFromWalls: (CCSprite*) wall
{
    [_walls removeObject:wall];
}


@end