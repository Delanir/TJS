//
//  InstantEffect.m
//  L'Archer
//
//  Created by jp on 07/05/13.
//
//

#import "InstantEffect.h"

@implementation InstantEffect

@synthesize instantAction, effectPos, effectEnded;

-(id) initWithPosition: (CGPoint) position
{
    if ( self = [super init])
    {
        effectEnded = NO;
        effectPos = position;
        //CGSize winSize = [[CCDirector sharedDirector] winSize];
        LevelLayer * levelLayer = [[Registry shared] getEntityByName:@"LevelLayer"];
        [levelLayer addChild:self z:5000];//winSize.height - position.y];
        
        [self setInstantAction: [CCSequence actions:
                                 [CCCallFuncN actionWithTarget:self selector:@selector(performAction)],
                                 [CCCallFuncN actionWithTarget:self selector:@selector(scheduleUpdate)],
                                 nil]];
        [self runAction:instantAction];
    }
    return self;
}


-(void) performAction
{

}

-(void) scheduleUpdate
{
    [self schedule:@selector(update)];
    
}

-(void) update
{
    if (effectEnded)
        [self clearEffect];
}

-(void) clearEffect
{
    LevelLayer * levelLayer = [[Registry shared] getEntityByName:@"LevelLayer"];
    [levelLayer removeChild:self cleanup:YES];
}




@end
