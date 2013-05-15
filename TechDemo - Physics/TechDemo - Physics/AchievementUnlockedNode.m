//
//  AchievementUnlockedNode.m
//  L'Archer
//
//  Created by jp on 15/05/13.
//
//

#import "AchievementUnlockedNode.h"

@implementation AchievementUnlockedNode

@synthesize number;

-(void) initWithNumber: (int) n
{
    number = n;
    [unlockedAchievement setInformation:number-1];
    [unlockedAchievement setImage:[NSString stringWithFormat:@"achievement%d.png",number]];
    [unlockedAchievement setIsEnabled:YES];
    [unlockedAchievement initAchievement];
    
}

@end
