//
//  WaveManager.m
//  L'Archer
//
//  Created by jp on 18/04/13.
//
//

#import "WaveManager.h"
#import "Registry.h"
#import "LevelLayer.h"
#import "EnemyFactory.h"
#import "Enemy.h"
#import "Utils.h"

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
                                                               displacement:displacementPoint];
            [ll addEnemy:newEnemy];
        }
    }
    else
        [self stopWaves];
}

-(void) clearLevel
{
    // todo
}

-(void)dealloc
{
    [waves dealloc];
    [_sharedSingleton release];
    [super dealloc];
}


@end