//
//  LevelUp.m
//  L'Archer
//
//  Created by jp on 19/05/13.
//
//

#import "LevelUp.h"
#import "CCBAnimationManager.h"

@implementation LevelUp

- (id) initWithLevel: (int) lvl
{
    if (self = [super initWithPosition:ccp(0,0)])
    {
        level = lvl;
    }
    return self;
}

- (void) performAction
{
    [self setZOrder:5100];
    
    CCNode * levelUp = [CCBReader nodeGraphFromFile:@"LevelUp.ccbi"];
    
    CCLabelTTF * number = (CCLabelTTF*)[[levelUp children] objectAtIndex:3];
    [number setString:[NSString stringWithFormat:@"%d", level]];
    
    CCBAnimationManager * am = [levelUp userObject];
    
    [am runAnimationsForSequenceNamed:@"Appear"];
    [self addChild:levelUp z:1 tag:0];
}


- (void) update
{
    CCNode * levelUp = [self getChildByTag:0];
    CCBAnimationManager * am = [levelUp userObject];
    if ([am runningSequenceName] == nil)
    {
        [self setEffectEnded:YES];
        [self removeAllChildrenWithCleanup:YES];
    }
    
    [super update];
}


@end

