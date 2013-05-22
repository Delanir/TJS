//
//  WaveManager.m
//  L'Archer
//
//  Created by jp on 18/04/13.
//
//

#import "WaveManager.h"
#import "LevelLayer.h"
#import "MainScene.h"

@implementation WaveManager

@synthesize intervalBetweenWaves, waves, currentTauntType;

static WaveManager* _sharedSingleton = nil;

+(WaveManager*)shared
{
	@synchronized([WaveManager class])
	{
		if (!_sharedSingleton)
			[[self alloc] init];
        
		return _sharedSingleton;
	}
	return nil;
}

+(id)alloc
{
	@synchronized([WaveManager class])
	{
		NSAssert(_sharedSingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedSingleton = [super alloc];
		return _sharedSingleton;
	}
	return nil;
}

-(id)init
{
    if (self = [super init])
    {
        waves = [[NSMutableArray alloc] init];
#ifdef kDebugMode
        [[Registry shared] addToCreatedEntities:self];
#endif
    }
	return self;
}

-(void) initializeLevelLogic: (NSString *) level;
{
    [self clearLevel];
    // Por waves numa queue. Guardar tempo entre layers
    NSDictionary * levelDetails = [Utils openPlist:level];
    [self setIntervalBetweenWaves:[(NSNumber*)[levelDetails objectForKey:@"timeBetweenWaves"] doubleValue]];
    [self setCurrentTauntType:[levelDetails objectForKey:@"tauntEnemyType"]];
    
    [(MainScene*)[[Registry shared] getEntityByName:@"MainScene"] setBackgroundWithSpriteType: [levelDetails objectForKey:@"background"]];
    
    NSArray* temp = [levelDetails objectForKey:@"waves"];
    for(NSString * wave in temp)
        [waves enqueue:wave];
}

-(void) beginWaves
{
    [self schedule:@selector(sendNextWave) interval:intervalBetweenWaves];
    [self schedule:@selector(sendEnemy) interval:intervalBetweenWaves/2];
    [self sendNextWave];
}

-(void) stopWaves
{
    [self unscheduleAllSelectors];
}


- (void)sendNextWave
{
    if([waves count] > 0)
    {
        LevelLayer * ll = [[Registry shared] getEntityByName:@"LevelLayer"];
        NSDictionary * nextWave = [Utils openPlist:[waves dequeue]];
        NSNumber * vPosition = [nextWave objectForKey:@"verticalCenter"];
        NSArray * enemies = [nextWave objectForKey:@"enemies"];
        
        for (NSDictionary * enemy in enemies)
        {
            NSString * type = [enemy objectForKey:@"type"];
            float xDisp = [[enemy objectForKey:@"xdisp" ] floatValue];
            float yDisp = [[enemy objectForKey:@"ydisp"] floatValue];
            CGPoint displacementPoint = ccp(xDisp, yDisp);
            Enemy * newEnemy = [[EnemyFactory shared] generateEnemyWithType:type
                                                                   vertical:[vPosition intValue]
                                                               displacement:displacementPoint
                                                                      taunt:NO];
            [ll addEnemy:newEnemy];
            [newEnemy release];
            self.enemies++;
        }
    }
    else
        [self stopWaves];
}

-(void) dispatchTaunt
{
    LevelLayer * ll = [[Registry shared] getEntityByName:@"LevelLayer"];
    
    Enemy * newEnemy = [[EnemyFactory shared] generateEnemyWithType: currentTauntType
                                                           vertical: 380
                                                       displacement: ccp(0,0)
                                                              taunt: YES];
    [ll addEnemy:newEnemy];
    [newEnemy release];
    self.enemies++;
}

-(void) sendEnemy
{
    LevelLayer * ll = [[Registry shared] getEntityByName:@"LevelLayer"];
    
    Enemy * newEnemy = [[EnemyFactory shared] generateRandomEnemy];
    [ll addEnemy: newEnemy];
    [newEnemy release];
}

- (BOOL) anymoreWaves
{
    return [waves count] > 0;
}

-(void) clearLevel
{
    [waves removeAllObjects];
    self.enemies = 0;
}

-(void)dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [currentTauntType release];
    [waves release];
    [_sharedSingleton release];
    [super dealloc];
}


@end