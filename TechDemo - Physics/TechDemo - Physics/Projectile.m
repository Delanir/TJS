//
//  Projectile.m
//  TechDemo - Physics
//
//  Created by jp on 02/04/13.
//
//

#import "Projectile.h"
#import "CollisionManager.h"

@implementation Projectile

@synthesize destination, timeToLive, stimuli, sprite;

-(void)spriteMoveFinished:(id)sender
{
    [self destroy];
    [[CollisionManager shared] removeFromProjectiles:self];
}

- (void)dealloc
{
   // [stimuli release];
   // [sprite release];
    [super dealloc];
}

- (void) destroy
{
    [self removeAllChildrenWithCleanup:YES];
}


@end
