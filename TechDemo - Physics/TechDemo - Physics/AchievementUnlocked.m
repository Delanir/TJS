//
//  AchievementUnlocked.m
//  L'Archer
//
//  Created by jp on 14/05/13.
//
//

#import "AchievementUnlocked.h"
#import "CCBAnimationManager.h"

@implementation AchievementUnlocked

- (void) performAction
{
    CCNode * begin = [CCBReader nodeGraphFromFile:@"AchievmentUnlocked.ccbi"];
    
    CCBAnimationManager * am = [begin userObject];
    [am runAnimationsForSequenceNamed:@"animate"];
    [self addChild:begin z:1 tag:0];
    
}


- (void) update
{
    CCNode * begin = [self getChildByTag:0];
    CCBAnimationManager * am = [begin userObject];
    if ([am runningSequenceName] == nil)
    {
        [self setEffectEnded:YES];
    }
    
    [super update];
}

@end
