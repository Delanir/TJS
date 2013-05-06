//
//  BlackDragon.m
//  L'Archer
//
//  Created by jp on 03/05/13.
//
//

#import "BlackDragon.h"

@implementation BlackDragon

-(id) initWithSprite:(NSString *)spriteFile
{
    if (self = [super initWithSprite:spriteFile])
    {
        [self setCurrentState:kWalkEnemyState];
        [self setHealth:400];
        [self setSpeed:20];
        [self setStrength:2.8];
        [self setGoldValue:20];
        [self setDamageVulnerability: kDamageBaseVulnerability * 0.5];
        [self setFireVulnerability: kFireBaseVulnerability * 1.0];
        [self setIceVulnerability: kIceBaseVulnerability * 1.5];
        [self setPushbackVulnerability: kPushbackBaseVulnerability * 1.0];
        
        [self postInit];
    }
    return self;
}

-(void) setupActions
{
    // Setup Movement
    [self animateWalkLeft];
    walkAnimation = @"bd_walk";
    attackAnimation = @"bd_attack";
    // Setup animations
    [self setWalkAction: [CCRepeatForever actionWithAction:
                          [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName: walkAnimation]]]];
    [self setAttackAction: [CCSequence actions:
                            [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName: attackAnimation]],
                            [CCCallFuncN actionWithTarget:self selector:@selector(damageWall)],
                            nil]];
    [[self sprite] runAction:walkAction];
}

-(void) attack
{
    [self setCurrentState:kAttackEnemyState];
    [[self sprite] stopAllActions];
    [[self healthBar] stopAllActions];
    [sprite setPosition:ccp([sprite position].x +80, [sprite position].y)];
    [healthBar setPosition:ccp([sprite position].x, [sprite position].y + [sprite contentSize].height/2 + 2)];
    [[self sprite] runAction:[CCRepeatForever actionWithAction:attackAction]];
}

-(void) die
{
    [super die];
    [self setCurrentState:kDieEnemyState];
    [[self sprite] stopAllActions];
    
    CCFiniteTimeAction * dieAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"bd_dies" ]] times:1];
    [[self sprite] runAction:dieAction];
}


@end