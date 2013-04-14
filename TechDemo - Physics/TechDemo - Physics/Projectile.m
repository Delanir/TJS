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

@synthesize destination, timeToLive;

-(void)spriteMoveFinished:(id)sender {
    [self destroy];
    [[CollisionManager shared] removeFromProjectiles:self];
}

- (id) initWithSprite:(NSString *)spriteFile
{
    if( (self=[super init])) {
      
        [self setSpriteWithSpriteFrameName:spriteFile];
        [self addChild:sprite];
        
    }
    return self;
}






@end
