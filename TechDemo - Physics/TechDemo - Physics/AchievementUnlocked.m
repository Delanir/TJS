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

@implementation AchievementUnlocked

@synthesize achievements;

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
        //NSNumber * first = [achievements dequeue];
        CCNode * begin = [CCBReader nodeGraphFromFile:@"AchievmentUnlocked.ccbi"];
        CCBAnimationManager * am = [begin userObject];
        [am runAnimationsForSequenceNamed:@"animate"];
        [self addChild:begin z:1 tag:0];
    }
    else [self setEffectEnded:YES];
}


- (void) update
{
    CCNode * begin = [self getChildByTag:0];
    CCBAnimationManager * am = [begin userObject];
    if ([am runningSequenceName] == nil)
    {
        [self setEffectEnded:YES];
        if ([achievements count] > 0)
            [[[AchievementUnlocked alloc] initWithAchievements:achievements] autorelease];
    }
    
    [super update];
}

-(void) dealloc
{
    [achievements release];
    [super dealloc];
}

@end
