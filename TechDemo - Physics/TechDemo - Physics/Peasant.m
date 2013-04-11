//
//  Peasant.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Peasant.h"

@implementation Peasant

@synthesize moveAction = _moveAction;
@synthesize walkAction = _walkAction;


-(id) initWithSprite:(NSString *)spriteFile andWindowSize:(CGSize)winSize
{
    if (self = [super initWithSprite:spriteFile andWindowSize:winSize])
    {
        
#warning TODO initialize animation here
        _walkAction = [CCRepeatForever actionWithAction:
                                [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"p_walk" ] restoreOriginalFrame:NO]];
        [[self sprite] runAction:_walkAction];
        
    }
    return self;
}
/*
 -(id) init {
    if((self = [super init])) {
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
         @"Peasant.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode
                                          batchNodeWithFile:@"Peasant.png"];
        [self addChild:spriteSheet];
        NSMutableArray *walkAnimFrames = [NSMutableArray array];
        for(int i = 1; i <= 8; ++i) {
            [walkAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"walk0%d.png", i]]];
            
        }
        CCAnimation *walkAnim = [CCAnimation
                                 animationWithSpriteFrames:walkAnimFrames delay:0.1f];
        
        
        sprite = [KKPixelMaskSprite spriteWithSpriteFrameName:@"walk01.png"];
        
        self.walkAction = [CCRepeatForever actionWithAction:
                           [CCAnimate actionWithAnimation:walkAnim]];
        [sprite runAction:_walkAction];
        [spriteSheet addChild:sprite];
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        CGSize spriteSize = [self spriteSize];
        
        int minY = winSize.height/6 + spriteSize.height/2;
        int maxY = (5 * winSize.height / 6) - spriteSize.height/2;
        int rangeY = maxY - minY;
        int actualY = (arc4random() % rangeY) + minY;
        
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
 
 */


-(void)dealloc
{
    //self.walkAction = nil;
    [super dealloc];
}

@end
