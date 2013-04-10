//
//  Enemy.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Enemy.h"
#import "CollisionManager.h"

@implementation Enemy

- (id) initWithSprite:(NSString *)spriteFile andWindowSize:(CGSize) winSize
{
    if( (self=[super init])) {
        
        [self setSpriteWithSpriteFrameName:spriteFile];
        [self addChild:sprite];
        
        CGSize spriteSize = [self spriteSize];
        
        int minY = winSize.height/6 + spriteSize.height/2;
        int maxY = (5 * winSize.height / 6) - spriteSize.height/2;
        int rangeY = maxY - minY;
        int actualY = (arc4random() % rangeY) + minY;
        
        // Create the target slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        sprite.position = ccp(winSize.width + (spriteSize.width/2), actualY);
        
        // Determine speed of the target
        int minDuration = 10;                                                   //@TODO ficheiro de configuraçao
        int maxDuration = 20;                                                   //@TODO ficheiro de configuracao
        int rangeDuration = maxDuration - minDuration;
        int actualDuration = (arc4random() % rangeDuration) + minDuration;
        
        // Create the actions
        id actionMove = [CCMoveTo actionWithDuration:actualDuration
                                            position:ccp(-spriteSize.width/2, actualY)];
        id actionMoveDone = [CCCallFuncN actionWithTarget:self
                                                 selector:@selector(spriteMoveFinished:)];
        [sprite runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
        
    }
    
    return self;
}


-(void)spriteMoveFinished:(id)sender {
    [self removeChild:sprite cleanup:YES];
    [[CollisionManager shared] removeFromTargets:self];
}


@end
