//
//  GameState.m
//  L'Archer
//
//  Created by jp on 22/04/13.
//
//

#import "GameState.h"

@implementation GameState

static GameState* _sharedSingleton = nil;

@synthesize starStates;

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
	self = [super init];
	if (self != nil)
    {
        [self loadApplicationData];
    }
	return self;
}

-(void)saveApplicationData
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:starStates forKey:@"Stars"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)loadApplicationData
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    starStates = [defaults objectForKey:@"Stars"];
    if ( starStates == nil)
        [self initApplicationData];
}

-(void)initApplicationData
{
//    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"GameData" ofType:@"plist"];
//    NSDictionary *appDefaults = [NSDictionary dictionaryWithContentsOfFile:plistPath];
//    [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
    starStates = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++)
        [starStates addObject: [NSNumber numberWithInt:0]];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}


-(void)resetApplicationData
{
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
