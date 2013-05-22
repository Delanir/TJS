//
//  AchievementUnlocked.m
//  L'Archer
//
//  Created by jp on 14/05/13.
//
//

#import "AchievementUnlocked.h"
#import "CCBAnimationManager.h"
#import "NSMutableArray+QueueAdditions.h"
#import "AchievementUnlockedNode.h"
#import "AchievementNode.h"

@implementation AchievementUnlocked

-(id) initWithAchievements: (NSMutableArray*) achievs
{
    if ( self = [super initWithPosition:ccp(0,0)] )
    {
        achievements = [[NSMutableArray alloc] init];
        for (NSNumber * number in achievs)
             [achievements enqueue:number];
    }
    return self;
}

- (void) performAction
{
    if ([achievements count] > 0)
    {
        NSNumber * first = [achievements dequeue];
        
        AchievementUnlockedNode * node = (AchievementUnlockedNode *)[CCBReader nodeGraphFromFile:@"AchievmentUnlocked.ccbi"];
        [node initWithNumber:[first intValue]];
        
        CCBAnimationManager * am = [node userObject];
        [am runAnimationsForSequenceNamed:@"animate"];
        [self addChild:node z:1 tag:0];
        [node release];
    }
    else [self setEffectEnded:YES];
}


- (void) updateInstant
{
    CCNode * begin = [self getChildByTag:0];
    CCBAnimationManager * am = [begin userObject];
    if ([am runningSequenceName] == nil)
    {
        [self setEffectEnded:YES];
        if ([achievements count] > 0)
            [[[AchievementUnlocked alloc] initWithAchievements:achievements] release];
    }
    
    [super updateInstant];
}

-(void) dealloc
{
    [achievements release];
    [super dealloc];
}

@end
