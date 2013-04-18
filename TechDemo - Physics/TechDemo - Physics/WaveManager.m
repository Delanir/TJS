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
    NSDictionary * levelDetails = [self openPlist:level];
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
        NSDictionary * nextWave = [self openPlist:[waves dequeue]];
        NSNumber * vPosition = [nextWave objectForKey:@"verticalCenter"];
        NSArray * enemies = [nextWave objectForKey:@"enemies"];
        
        for (NSDictionary * enemy in enemies)
        {
            NSString * type = [enemy objectForKey:@"type"];
            NSDictionary * disp = [enemy objectForKey:@"displacement"];
            float xDisp = [[disp objectForKey:@"width"] floatValue];
            float yDisp = [[disp objectForKey:@"height"] floatValue];
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

#warning criar classe utils
-(NSDictionary *) openPlist: (NSString *) plist
{
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    plistPath = [[NSBundle mainBundle] pathForResource:plist ofType:@"plist"];
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary * dict = (NSDictionary *)[NSPropertyListSerialization
                                           propertyListFromData:plistXML
                                           mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                           format:&format
                                           errorDescription:&errorDesc];
    if (!dict)
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    return dict;
    
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