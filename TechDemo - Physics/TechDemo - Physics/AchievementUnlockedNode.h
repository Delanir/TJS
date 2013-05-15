//
//  AchievementUnlockedNode.h
//  L'Archer
//
//  Created by jp on 15/05/13.
//
//

#import "CCNode.h"
#import "AchievementNode.h"

@interface AchievementUnlockedNode : CCNode
{
    AchievementNode * unlockedAchievement;
    int number;
}

@property int number;

-(void) initWithNumber: (int) n;

@end
