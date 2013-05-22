//
//  GetReady.m
//  L'Archer
//
//  Created by jp on 14/05/13.
//
//

#import "GetReady.h"
#import "Begin.h"
#import "CCBAnimationManager.h"

@implementation GetReady

- (void) performAction
{
    CCNode * begin = [CCBReader nodeGraphFromFile:@"Begin.ccbi"];
    
    CCBAnimationManager * am = [begin userObject];
    [am runAnimationsForSequenceNamed:@"GetReady"];
    [self addChild:begin];

}


- (void) updateInstant
{
    LevelLayer * levellayer = [[Registry shared] getEntityByName:@"LevelLayer"];
    if ([levellayer gameStarted])
    {
        [self setEffectEnded:YES];
        [self removeAllChildrenWithCleanup:YES];
        [[[Begin alloc] initWithPosition:ccp(512, 384)] release];
        
    }
    
    [super updateInstant];
}


@end
