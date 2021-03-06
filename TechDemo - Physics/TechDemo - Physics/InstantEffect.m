//
//  InstantEffect.m
//  L'Archer
//
//  Created by jp on 07/05/13.
//
//

#import "InstantEffect.h"

@implementation InstantEffect

@synthesize effectPos, effectEnded;

-(id) initWithPosition: (CGPoint) position
{
    if ( self = [super init])
    {
#ifdef kDebugMode
        [[Registry shared] addToCreatedEntities:self];
#endif
        effectEnded = NO;
        effectPos = position;
        LevelLayer * levelLayer = [[Registry shared] getEntityByName:@"LevelLayer"];
        [levelLayer addChild:self z:5000];
        [self runAction:[CCSequence actions:
                         [CCCallFuncN actionWithTarget:self selector:@selector(performAction)],
                         nil]];
        [self schedule:@selector(updateInstant)];
    }
    return self;
}


-(void) performAction
{

}


-(void) updateInstant
{
    if (effectEnded)
        [self clearEffect];
}

-(void) clearEffect
{
    LevelLayer * levelLayer = [[Registry shared] getEntityByName:@"LevelLayer"];
    [levelLayer removeChild:self cleanup:YES];
}

-(void) onExit
{
    [self unscheduleAllSelectors];
    [self removeAllChildrenWithCleanup:YES];
    [super onExit];
}

-(void) dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [super dealloc];
}




@end
