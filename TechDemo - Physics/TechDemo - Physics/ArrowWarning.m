//
//  ArrowWarning.m
//  L'Archer
//
//  Created by jp on 18/05/13.
//
//

#import "ArrowWarning.h"
#import "CCBAnimationManager.h"
#import "ResourceManager.h"

@implementation ArrowWarning

- (void) performAction
{
    CCNode * arrowWarning = [CCBReader nodeGraphFromFile:@"Begin.ccbi"];
    
    CCBAnimationManager * am = [arrowWarning userObject];
    [am runAnimationsForSequenceNamed:@"Arrows"];
    [self addChild:arrowWarning];
}


- (void) update
{
    if ([[ResourceManager shared] arrows] > kAcceptableNumberOfArrows)
    {
        [self setEffectEnded:YES];
        [self removeAllChildrenWithCleanup:YES];
    }
    
    [super update];
}


@end

