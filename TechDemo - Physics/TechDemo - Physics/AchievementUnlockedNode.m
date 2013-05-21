//
//  AchievementUnlockedNode.m
//  L'Archer
//
//  Created by jp on 15/05/13.
//
//

#import "AchievementUnlockedNode.h"
#import "Registry.h"

@implementation AchievementUnlockedNode

@synthesize number;

-(id) init
{
    self = [super init];
#ifdef kDebugMode
    [[Registry shared] addToCreatedEntities:self];
#endif
    return self;
}

-(void) initWithNumber: (int) n
{
    number = n;
    [unlockedAchievement setInformation:number-1];
    [unlockedAchievement setImage:[NSString stringWithFormat:@"achievement%d.png",number]];
    [unlockedAchievement setIsEnabled:YES];
    [unlockedAchievement initAchievement];
    
}

-(void) dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [super dealloc];
}

@end
