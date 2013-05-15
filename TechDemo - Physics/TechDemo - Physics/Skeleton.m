//
//  Skeleton.m
//  L'Archer
//
//  Created by jp on 03/05/13.
//
//

#import "Skeleton.h"

@implementation Skeleton

-(id) initWithSprite:(NSString *)spriteFile initialState:(state) initialState
{
    if (self = [super initWithSprite:spriteFile initialState:initialState])
    {
        [self setCurrentState:initialState];
        [self setHealth:70];
        [self setSpeed:13];
        [self setStrength:0.5];
        [self setGoldValue:2];
        [self setDamageVulnerability:kDamageBaseVulnerability * 0.6];
        [self setFireVulnerability:kFireBaseVulnerability * 1.5];
        [self setIceVulnerability:kIceBaseVulnerability * 0.25];
        [self setPushbackVulnerability:kPushbackBaseVulnerability * 0.5];
        
        [self postInit];
    }
    return self;
}

-(void) setupActions
{
    walkAnimation = @"sk_walk";
    attackAnimation = @"sk_attack";
    // Setup animations
    [self setWalkAction: [CCRepeatForever actionWithAction:
                          [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName: walkAnimation]]]];
    [self setAttackAction: [CCSequence actions:
                            [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName: attackAnimation]],
                            [CCCallFuncN actionWithTarget:self selector:@selector(damageWall)],
                            nil]];
    
    // Setup Movement
    if (currentState == kWalkEnemyState)
    {
        [[self sprite] runAction:walkAction];
        [self animateWalkLeft];
    }
    if (currentState == kAttackEnemyState)
        [sprite runAction:[CCRepeatForever actionWithAction:attackAction]];
    
}

-(void) attack
{
    [super attack];
    if ([self isDead]) return;  // may die in super because of the moat
    [self setCurrentState:kAttackEnemyState];
    [[self sprite] stopAllActions];
    [[self healthBar] stopAllActions];
    [sprite setPosition:ccp([sprite position].x +16, [sprite position].y)];
    [healthBar setPosition:ccp([sprite position].x, [sprite position].y + [sprite contentSize].height/2 + 2)];
    [[self sprite] runAction:[CCRepeatForever actionWithAction:attackAction]];
    
}

-(void) die
{
    [self setCurrentState:kDieEnemyState];
    [[self sprite] stopAllActions];
    
    CCFiniteTimeAction * dieAction = [CCSequence actions:
                                      [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"sk_dies" ]] times:1],
                                      [CCCallFuncN actionWithTarget:self selector:@selector(mockDie)],
                                      nil];
    [[self sprite] runAction:dieAction];
}

-(void) mockDie
{
    [super die];
}


@end