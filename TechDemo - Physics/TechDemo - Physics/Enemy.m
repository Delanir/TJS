//
//  Enemy.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Enemy.h"
#import "CollisionManager.h"
#import "Registry.h"
#import "ResourceManager.h"

@implementation Enemy

@synthesize currentState, strength, goldValue;

- (id) initWithSprite:(NSString *)spriteFile andWindowSize:(CGSize) winSize
{
    if( (self = [super init])) {
        
        
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
        
    }
    
    return self;
}


-(void)spriteMoveFinished:(id)sender {
    [self removeChild:sprite cleanup:YES];
    [[CollisionManager shared] removeFromTargets:self];
}

-(void)attack
{
    
}

-(void)die
{
    [[ResourceManager shared] increaseEnemyKillCount];
    [[ResourceManager shared] addGold: goldValue];
}

- (void)damageWall
{
    Wall * wall = [[Registry shared] getEntityByName:@"Wall"];
    [wall damage:strength];
}

-(void ) shout
{
}

@end
