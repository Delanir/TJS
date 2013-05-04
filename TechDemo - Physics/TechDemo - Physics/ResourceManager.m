//
//  ResourceManager.m
//  L'Archer
//
//  Created by jp on 17/04/13.
//
//

#import "ResourceManager.h"
#import "GameState.h"
#import "SpriteManager.h"

@implementation ResourceManager

@synthesize skillPoints, arrows, gold, mana, arrowsUsed, enemiesFromStart, enemiesHit, enemyKillCount, maxMana;

static ResourceManager* _sharedSingleton = nil;

+(ResourceManager*)shared
{
	@synchronized([ResourceManager class])
	{
		if (!_sharedSingleton)
			[[self alloc] init];
        
		return _sharedSingleton;
	}
	return nil;
}

+(id)alloc
{
	@synchronized([ResourceManager class])
	{
		NSAssert(_sharedSingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedSingleton = [super alloc];
		return _sharedSingleton;
	}
    
	return nil;
}

+(void) loadLevelSprites
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeAllTextures];
    
    [[SpriteManager shared] addSpritesToSpriteFrameCacheWithFile:@"lvl1spritesheet.plist" andBatchSpriteSheet:@"lvl1spritesheet.png"];
    [[SpriteManager shared] addAnimationFromFile:@"peasant_anim.plist"];
    [[SpriteManager shared] addAnimationFromFile:@"fairiedragon_anim.plist"];
    [[SpriteManager shared] addAnimationFromFile:@"zealot_anim.plist"];
    [[SpriteManager shared] addAnimationFromFile:@"yurie_anim.plist"];
    [[SpriteManager shared] addAnimationFromFile:@"fireelemental_anim.plist"];
    [[SpriteManager shared] addAnimationFromFile:@"wraith_anim.plist"];
    [[SpriteManager shared] addAnimationFromFile:@"skeleton_anim.plist"];
    [[SpriteManager shared] addAnimationFromFile:@"blackdragon_anim.plist"];
}

-(id)init
{
	self = [super init];
	if (self != nil)
    {
		[self reset];
        [self setGold: [[[GameState shared] goldState] unsignedIntValue]];
        [self setSkillPoints:[self determineSkillPoints]];
    }
	return self;
}

// Called when game is saved
-(void)update
{
    [self reset];
    [self setGold: [[[GameState shared] goldState] unsignedIntValue]];
    [self setSkillPoints:[self determineSkillPoints]];
}

-(void) reset
{
    arrowsUsed = 0;
    enemyKillCount = 0;
    enemiesHit = 0;
    enemiesFromStart = 0;
}


-(void)dealloc
{
    [_sharedSingleton release];
    [super dealloc];
}


-(void) addSkillPoints:(unsigned int) add
{
    skillPoints += add;
}

-(void) addGold:(unsigned int) add
{
    gold += add;
}

-(void) addArrows:(unsigned int) add
{
    arrows += add;
}
-(void) addMana:(double) add
{
    mana += add;
}

-(BOOL) spendSkillPoints:(unsigned int) spend
{
    if( skillPoints < spend) return false;
    skillPoints -= spend;
    return true;
}

-(BOOL) spendGold:(unsigned int) spend
{
    if( gold < spend) return false;
    gold -= spend;
    return true;
}
-(BOOL) spendArrows:(unsigned int) spend
{
    if( arrows < spend) return false;
    arrows -= spend;
    return true;
}
-(BOOL) spendMana:(double) spend
{
    if( mana < spend) return false;
    mana -= spend;
    return true;
}

- (void)increaseEnemyCount
{
    enemiesFromStart++;
}

- (void)increaseEnemyKillCount
{
    enemyKillCount++;
}

-(void)increaseEnemyHitCount
{
    enemiesHit++;
}

- (void)increaseArrowsUsedCount
{
    arrowsUsed++;
    arrows--;
}

- (double)determineAccuracy
{
    if(arrowsUsed == 0)
        return -1;
    else return 100 * ( (enemiesHit * 1.0f) / arrowsUsed);
}

- (unsigned int) activeEnemies
{
    return enemiesFromStart - enemyKillCount;
}

- (unsigned int)determineSkillPoints
{
    NSMutableArray * levels = [[GameState shared] starStates];
    unsigned int result = 0;
    for(NSNumber * level in levels)
        result += [level unsignedIntValue];
    return result;
}

@end