//
//  Peasant.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Peasant.h"

@implementation Peasant

@synthesize attackAction, walkAction;


-(id) initWithSprite:(NSString *)spriteFile
{
    if (self = [super initWithSprite:spriteFile])
    {
        [self setCurrentState:kWalkEnemyState];
        [self setStrength:0.5];
        [self setGoldValue:1];
        [self setSpeed:15];
        [self setHealth:50];
        
        [self postInit];
    }
    return self;
}

-(void) setupActions
{
    // Setup Movement
    [self animateWalkLeft];
    
    // Setup animations
    [self setWalkAction: [CCRepeatForever actionWithAction:
                          [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"p_walk" ]]]];
    [self setAttackAction: [CCSequence actions:
                            [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"p_attack"]],
                            [CCCallFuncN actionWithTarget:self selector:@selector(damageWall)],
                            nil]];
    [[self sprite] runAction:walkAction];
}

-(void)attack
{
    [self setCurrentState:kAttackEnemyState];
    [sprite stopAllActions];
    [healthBar stopAllActions];
    [sprite setPosition:ccp([sprite position].x +6, [sprite position].y)];
    [healthBar setPosition:ccp([sprite position].x, [sprite position].y + [sprite contentSize].height/2 + 2)];
    [sprite runAction:[CCRepeatForever actionWithAction:attackAction]];
}

-(void)die
{
    [super die];
    [self setCurrentState:kDieEnemyState];
    [[self sprite] stopAllActions];
    
    CCFiniteTimeAction * dieAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"p_dies" ]] times:1];
    [[self sprite] runAction:dieAction];
}

@end
