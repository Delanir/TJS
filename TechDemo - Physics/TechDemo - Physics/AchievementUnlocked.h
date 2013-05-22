//
//  AchievementUnlocked.h
//  L'Archer
//
//  Created by jp on 14/05/13.
//
//

#import "InstantEffect.h"

@interface AchievementUnlocked : InstantEffect
{
    NSMutableArray * achievements;
}

-(id) initWithAchievements: (NSMutableArray*) achievs;

@end
