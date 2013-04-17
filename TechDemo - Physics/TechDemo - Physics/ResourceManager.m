//
//  ResourceManager.m
//  L'Archer
//
//  Created by jp on 17/04/13.
//
//

#import "ResourceManager.h"

@implementation ResourceManager

@synthesize skillPoints, arrows, gold, mana;

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

-(id)init
{
	self = [super init];
	if (self != nil) {
		// initialize stuff here
        
    }
	return self;
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


@end