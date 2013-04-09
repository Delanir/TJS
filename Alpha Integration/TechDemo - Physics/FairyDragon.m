//
//  FairyDragon.m
//  Alpha Integration
//
//  Created by MiniclipMacBook on 4/7/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "FairyDragon.h"


@implementation FairyDragon


- (id) initWithWindowSize:(CGSize) winSize
{
    
    self= [self init];
    CCSprite * monster = [CCSprite spriteWithSpriteFrameName:@"Fly01.png"];
    CCAction *walkAction = [CCRepeatForever actionWithAction:
                            [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"fly" ] restoreOriginalFrame:NO]];
    
    CCFiniteTimeAction *landAction = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"land" ] restoreOriginalFrame:NO];
    CCRepeat *repeatAction = [CCRepeat actionWithAction:landAction times:1];
    
    //[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"land" ] restoreOriginalFrame:NO]];
    
    [monster runAction:walkAction];
    [self addChild:monster];

      
    // Determine where to spawn the monster along the Y axis
    int minY = monster.contentSize.height / 2+winSize.height/10;
    int maxY = winSize.height - monster.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    monster.position = ccp(winSize.width + monster.contentSize.width/2, actualY);
    //[self addChild:monster];
    monster.flipX=YES;
    // Determine speed of the monster
    int minDuration = 20.0;
    int maxDuration = 40.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    CCMoveTo * actionMoveR = [CCMoveTo actionWithDuration:actualDuration position:ccp(winSize.width/4+200, actualY)];
    
    //CCMoveTo * actionMoveL = [CCMoveTo actionWithDuration:actualDuration position:ccp(winSize.width+monster.contentSize.width/2, actualY)];
    id actionMoveDone = [CCCallFuncN actionWithTarget:self
                                             selector:@selector(spriteMoveFinished:)];
    
    CCCallBlockN * flip = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [((CCSprite *)node) stopAction:walkAction];
        [((CCSprite *)node) runAction:repeatAction];
        
    }];
    CCCallBlockN * die = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        ((CCSprite *)node).flipY=YES;
        //[[SimpleAudioEngine sharedEngine] playEffect:@"leMIAUdamiens.caf"];
        
    }];
    [monster runAction:[CCSequence actions:actionMoveR, flip, [CCDelayTime actionWithDuration:1.5],die,[CCDelayTime actionWithDuration:.5] , actionMoveDone, nil]];
    
    monster.tag = 1;
    // z ordering para os ursos nao andarem a cavalgar uns nos outros
    [self reorderChild: monster z: winSize.height - monster.position.y];
    
    return self;
}
@end
