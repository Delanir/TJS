//
//  WaveManager.m
//  L'Archer
//
//  Created by jp on 18/04/13.
//
//

#import "WaveManager.h"
#import "LevelLayer.h"

@implementation WaveManager

@synthesize intervalBetweenWaves, waves;

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
	self = [super init];
	if (self != nil) {
        waves = [[NSMutableArray alloc] init];
    }
	return self;
}

-(void) initializeLevelLogic: (NSString *) level;
{
    [self clearLevel];
    // Por waves numa queue. Guardar tempo entre layers
    NSDictionary * levelDetails = [Utils openPlist:level];
    [self setIntervalBetweenWaves:[(NSNumber*)[levelDetails objectForKey:@"timeBetweenWaves"] doubleValue]];
    
    NSArray* temp = [levelDetails objectForKey:@"waves"];
    for(NSString * wave in temp)
        [waves enqueue:wave];
}

-(void) beginWaves
{
    [self schedule:@selector(sendNextWave) interval:intervalBetweenWaves];
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
            self.enemies++;
        }
    }
    else
        [self stopWaves];
}

-(void) sendWave:(NSString*)waveName taunt:(BOOL)isTaunt
{
    LevelLayer * ll = [[Registry shared] getEntityByName:@"LevelLayer"];
    NSDictionary * nextWave = [Utils openPlist:waveName];
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
                                                                  taunt:isTaunt];
        [ll addEnemy:newEnemy];
        self.enemies++;
    }
}

- (BOOL) anymoreWaves
{
    return [waves count] > 0;
}

-(void) clearLevel
{
    [waves removeAllObjects];
    self.enemies = 0;
    // todo
}

-(void)dealloc
{
    [waves release];
    [_sharedSingleton release];
    [super dealloc];
}


@end