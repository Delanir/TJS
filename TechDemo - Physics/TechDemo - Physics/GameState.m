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

@synthesize starStates, goldState;

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
    [defaults setObject:goldState forKey:@"Gold"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[ResourceManager shared] update];
}

-(void)loadApplicationData
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    starStates = [defaults objectForKey:@"Stars"];
    if ( starStates == nil)
        [self initApplicationData];
    goldState = [defaults objectForKey:@"Gold"];
}

-(void)initApplicationData
{
    starStates = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++)
        [starStates addObject: [NSNumber numberWithInt:0]];
    goldState = [NSNumber numberWithInt:0];
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
    [_sharedSingleton release];
    [super dealloc];
}

@end
