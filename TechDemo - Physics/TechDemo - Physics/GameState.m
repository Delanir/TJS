//
//  GameState.m
//  L'Archer
//
//  Created by jp on 22/04/13.
//
//

#import "GameState.h"
#import "ResourceManager.h"

@implementation GameState

static GameState* _sharedSingleton = nil;

@synthesize starStates, goldState, skillStates;
@synthesize  enemiesKilledState, buyArrowsState, fireElementalKilledState, dragonsKilledState;

+(GameState*)shared
{
	@synchronized([GameState class])
	{
		if (!_sharedSingleton)
			[[self alloc] init];
		return _sharedSingleton;
	}
	return nil;
}

+(id)alloc
{
	@synchronized([GameState class])
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
        [self loadApplicationData];
    }
	return self;
}

-(void)saveApplicationData
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:starStates forKey:@"Stars"];
    [defaults setObject:skillStates forKey:@"Skills"];
    [defaults setObject:goldState forKey:@"Gold"];
    [defaults setObject:achievementStates forKey:@"Achievements"];
    [defaults setObject:buyArrowsState forKey:@"BuyArrows"];
    [defaults setObject:enemiesKilledState forKey:@"EnemiesKilled"];
    [defaults setObject:dragonsKilledState forKey:@"DragonsKilled"];
    [defaults setObject:fireElementalKilledState forKey:@"FireElementalKilled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[ResourceManager shared] update];
}

-(void)loadApplicationData
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    starStates = [defaults objectForKey:@"Stars"];
    skillStates =[defaults objectForKey:@"Skills"]; 
    if ( starStates == nil||skillStates==nil)
        [self initApplicationData];
    goldState = [defaults objectForKey:@"Gold"];
    achievementStates = [defaults objectForKey:@"Achievements"];
    buyArrowsState = [defaults objectForKey:@"BuyArrows"];
    enemiesKilledState = [defaults objectForKey:@"EnemiesKilled"];
    dragonsKilledState = [defaults objectForKey:@"DragonsKilled"];
    fireElementalKilledState = [defaults objectForKey:@"FireElementalKilled"];
}

-(void)initApplicationData
{
    starStates = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++)
        [starStates addObject: [NSNumber numberWithInt:0]];
    achievementStates = [[NSMutableArray alloc] init];
    for (int i = 0; i < 16; i++)
        [achievementStates addObject: [NSNumber numberWithInt:0]];
    
    skillStates = [[NSMutableArray alloc] init];
    for (int i = 0; i < 28; i++)
        [skillStates addObject: [NSNumber numberWithInt:0]];
    goldState = [NSNumber numberWithInt:0];
    buyArrowsState = [NSNumber numberWithInt:0];
    enemiesKilledState = [NSNumber numberWithInt:0];
    dragonsKilledState = [NSNumber numberWithInt:0];
    fireElementalKilledState = [NSNumber numberWithInt:0];
}


-(void)resetApplicationData
{
    [NSUserDefaults resetStandardUserDefaults];
    [self initApplicationData];
    [self saveApplicationData];
    // limpar tudo
    // chamar init Application Data
}


-(void)dealloc
{
    [starStates release];
    [skillStates release];
    [achievementStates release];
    [_sharedSingleton release];
    [super dealloc];
}

@end
