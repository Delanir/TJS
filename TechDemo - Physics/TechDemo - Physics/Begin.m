//
//  Begin.m
//  L'Archer
//
//  Created by jp on 14/05/13.
//
//

#import "Begin.h"
#import "CCBAnimationManager.h"

@implementation Begin



- (void) performAction
{
    CCNode * begin = [CCBReader nodeGraphFromFile:@"Begin.ccbi"];
    
    CCBAnimationManager * am = [begin userObject];
    [am runAnimationsForSequenceNamed:@"Begin"];
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