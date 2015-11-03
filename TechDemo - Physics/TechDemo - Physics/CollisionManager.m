//
//  CollisionManager.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "CollisionManager.h"
#import "ResourceManager.h"
#import "Config.h"
#import "Yuri.h"
#import "NSMutableArray+QueueAdditions.h"

#import "FireExplosion.h"
#import "IceExplosion.h"

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
	if (self != nil)
    {
#ifdef kDebugMode
        [[Registry shared] addToCreatedEntities:self];
#endif
        _targets = [[CCArray alloc] init];
        _projectiles = [[CCArray alloc] init];
        _walls = [[CCArray alloc] init];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [_walls release];
    _walls = nil;
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

-(void) updateCollisions:(ccTime)dt;
{
    [self updatePixelPerfectCollisions:dt];
    [self updateWallsAndEnemies:dt];
}

-(void)updatePixelPerfectCollisions:(ccTime)dt
{
    CCArray *projectilesToDelete = [[CCArray alloc] init];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    // If projectile is off the screen, destroy the bastard
    for (Projectile* projectile in _projectiles)
    {
        if([[projectile sprite] position].x > winSize.width ||
           [[projectile sprite] position].y > winSize.height ||
           [[projectile sprite] position].y < winSize.height/6)
        {
            [projectilesToDelete addObject:projectile];
            continue;
        }
        CCSprite * projectileSprite = [projectile sprite];
        
        CCArray *targetsToDelete = [[CCArray alloc] init];
        for (Enemy *target in _targets)
        {
            //Tem de de ser testado aqui porque se for em
            // baixo os estimulos podem ainda n estar processados
            if ([target isDead])
            {
                [_targets removeObject:target];
                continue;
            }
            
            KKPixelMaskSprite *targetSprite = [target sprite];
            if ([targetSprite pixelMaskContainsPoint:[projectileSprite position]])
            {
                [targetsToDelete addObject:target];
                [[ResourceManager shared] increaseEnemyHitCount];
                break;              // Cada flecha só mata um
            }
        }
        
        for (Enemy *target in targetsToDelete)
        {
            [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"HitSound"]];
            [target enqueueStimuli:(NSMutableArray*)[projectile stimuli]];
            [self handleAreaOfEffectWithStimuli: (NSMutableArray*)[projectile stimuli] andSourceEnemy: target];
        }
        
        if (targetsToDelete.count > 0)
            [projectilesToDelete addObject:projectile];
            
        [targetsToDelete release];
    }
    for (Projectile *projectile in projectilesToDelete)
    {
        [_projectiles removeObject:projectile];
        [projectile destroy];
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

-(void)clearAllEntities
{
    [_projectiles removeAllObjects];
    [_walls removeAllObjects];
    [_targets removeAllObjects];
}

-(void) handleAreaOfEffectWithStimuli: (NSMutableArray*) stimuli andSourceEnemy: (id) sourceEnemy
{
    for (int i = 0; i < [stimuli count]; i++)
    {
        Stimulus * stimulus = [stimuli objectAtIndex:i];
        Yuri * yuri = [[Registry shared] getEntityByName:@"Yuri"];
        float iceRange = [yuri iceAreaOfEffect];
        float fireRange = [yuri fireAreaOfEffect];
        
        switch ([stimulus type])
        {
            case kDOTStimulus:
                if (fireRange != kYuriNoAreaOfEffect)
                {
                    [[[FireExplosion alloc] initWithPosition:[[sourceEnemy sprite] position] andRadius: (fireRange / kYuriBaseAreaOfEffect)] release];
                    CCArray * dudesToAffect = [self findAllEnemiesInRange:[yuri fireAreaOfEffect] ofEnemy:sourceEnemy];
                    for (Enemy * enemy in dudesToAffect)
                    {
                        NSMutableArray * stimulusToAdd = [NSMutableArray arrayWithObject:stimulus];
                        [enemy enqueueStimuli:stimulusToAdd];
                    }
                }
                break;
            case kSlowStimulus:
                if (iceRange != kYuriNoAreaOfEffect)
                {
                    [[[IceExplosion alloc] initWithPosition:[[sourceEnemy sprite] position] andRadius: (iceRange / kYuriBaseAreaOfEffect)] release];
                    CCArray * dudesToAffect = [self findAllEnemiesInRange:[yuri iceAreaOfEffect] ofEnemy:sourceEnemy];
                    for (Enemy * enemy in dudesToAffect)
                    {
                        NSMutableArray * stimulusToAdd = [NSMutableArray arrayWithObject:stimulus];
                        [enemy enqueueStimuli:stimulusToAdd];
                    }
                }
                break;
            default:
                break;
        }
    }
}


-(id)findClosestTarget: (CGPoint) sourcePosition
{
    if ( _targets.count <= 1)
        return nil;
    
    id closestTarget;
    double closestRangeSquared = kMaxRange * kMaxRange;
    for ( Enemy * enemy in _targets )
    {
        CGPoint currentEnemyPosition = [[enemy sprite] position];
        float squaredDistance = [self squaredDistanceBetweenPointA:sourcePosition andPointB:currentEnemyPosition];
        if (squaredDistance < closestRangeSquared)
        {
            closestTarget = enemy;
            closestRangeSquared = squaredDistance;
        }
    }
    return closestTarget;
}

-(CCArray*)findAllEnemiesInRange: (double) range ofEnemy: (id) sourceEnemy
{
    CCArray * returnArray = [[CCArray alloc] init];
    CGPoint sourcePosition = [[sourceEnemy sprite] position];
    
    for ( Enemy * enemy in _targets )
    {
        if (enemy == sourceEnemy) continue;
        CGPoint currentEnemyPosition = [[enemy sprite] position];
        float squaredDistance = [self squaredDistanceBetweenPointA:sourcePosition andPointB:currentEnemyPosition];
        if (squaredDistance < range * range)
            [returnArray addObject:enemy];
    }
    return [returnArray autorelease];
}

-(double) squaredDistanceBetweenPointA: (CGPoint) pointA andPointB: (CGPoint) pointB
{
    return pow(pointA.x - pointB.x, 2) + pow(pointA.y - pointB.y, 2);
}



@end