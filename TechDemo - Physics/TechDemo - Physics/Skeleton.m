//
//  Skeleton.m
//  L'Archer
//
//  Created by jp on 03/05/13.
//
//

#import "Skeleton.h"

@implementation Skeleton

-(id) initWithSprite:(NSString *)spriteFile
{
    if (self = [super initWithSprite:spriteFile])
    {
        [self setCurrentState:kWalkEnemyState];
        [self setHealth:60];
        [self setSpeed:13];
        [self setStrength:0.4];
        [self setGoldValue:2];
        [self setDamageVulnerability:kDamageBaseVulnerability * 0.75];
        [self setFireVulnerability:kFireBaseVulnerability * 2.0];
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
    [self setCurrentState:kAttackEnemyState];
    [[self sprite] stopAllActions];
    [[self healthBar] stopAllActions];
    [sprite setPosition:ccp([sprite position].x +16, [sprite position].y)];
    [healthBar setPosition:ccp([sprite position].x, [sprite position].y + [sprite contentSize].height/2 + 2)];
    [[self sprite] runAction:[CCRepeatForever actionWithAction:attackAction]];
}

-(void) die
{
    [super die];
    [self setCurrentState:kDieEnemyState];
    [[self sprite] stopAllActions];
    
    CCFiniteTimeAction * dieAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"sk_dies" ]] times:1];
    [[self sprite] runAction:dieAction];
}


@end