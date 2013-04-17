//
//  Zealot.m
//  L'Archer
//
//  Created by jp on 13/04/13.
//
//

#import "Zealot.h"
#import "Wall.h"

@implementation Zealot

@synthesize attackAction, walkAction;

-(id) initWithSprite:(NSString *)spriteFile andWindowSize:(CGSize)winSize
{
    if (self = [super initWithSprite:spriteFile andWindowSize:winSize])
    {
        [self setCurrentState:walk];
        [self setStrength:1.0];
        
        // Setup Movement
        // Determine speed of the target
        int minDuration = 16;                                                   //@TODO ficheiro de configuraçao
        int maxDuration = 18;                                                   //@TODO ficheiro de configuracao
        int rangeDuration = maxDuration - minDuration;
        int actualDuration = (arc4random() % rangeDuration) + minDuration;
        
        // Create the actions
        id actionMove = [CCMoveTo actionWithDuration:actualDuration
                                            position:ccp(-sprite.contentSize.width/2, sprite.position.y)];
        id actionMoveDone = [CCCallFuncN actionWithTarget:self
                                                 selector:@selector(spriteMoveFinished:)];
        [sprite runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
        
        
        // Setup animations
        [self setWalkAction: [CCRepeatForever actionWithAction:
                             [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"z_walk" ]]]];
        [self setAttackAction: [CCSequence actions:
                                [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"z_attack"]],
                                [CCCallFuncN actionWithTarget:self selector:@selector(damageWall)],
                                nil]];
        [[self sprite] runAction:walkAction];
        
    }
    return self;
}

-(void)attack
{
    [self setCurrentState:attack];
    [[self sprite] stopAllActions];
    [[self sprite] setPosition:CGPointMake([self sprite].position.x +10, [self sprite].position.y)];
    [[self sprite] runAction:[CCRepeatForever actionWithAction:attackAction]];
}

-(void)die
{
    [super die];
    [self setCurrentState:die];
    [[self sprite] stopAllActions];
    
    CCFiniteTimeAction * dieAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"z_dies" ]] times:1];
    [[self sprite] runAction:dieAction];
}


@end