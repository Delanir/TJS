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

@synthesize destination, timeToLive, stimuli;

-(void)spriteMoveFinished:(id)sender
{
    [self destroy];
    [[CollisionManager shared] removeFromProjectiles:self];
}




@end
