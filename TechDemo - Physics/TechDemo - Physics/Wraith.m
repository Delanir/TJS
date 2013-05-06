//
//  Wraith.m
//  L'Archer
//
//  Created by jp on 03/05/13.
//
//

#import "Wraith.h"

@implementation Wraith

-(id) initWithSprite:(NSString *)spriteFile
{
    if (self = [super initWithSprite:spriteFile])
    {
        [self setCurrentState:kWalkEnemyState];
        [self setHealth:140];
        [self setSpeed:10];
        [self setStrength:1.0];
        [self setGoldValue:4];
        [self setDamageVulnerability: kDamageBaseVulnerability * 0.75];
        [self setFireVulnerability: kFireBaseVulnerability * 2.0];
        [self setIceVulnerability: kIceBaseVulnerability * 0.25];
        [self setPushbackVulnerability: kPushbackBaseVulnerability * 0.5];
        
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
                          [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"w_walk" ]]]];
    [self setAttackAction: [CCSequence actions:
                            [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"w_attack"]],
                            [CCCallFuncN actionWithTarget:self selector:@selector(damageWall)],
                            nil]];
    [[self sprite] runAction:walkAction];
}

-(void) attack
{
    [self setCurrentState:kAttackEnemyState];
    [[self sprite] stopAllActions];
    [[self healthBar] stopAllActions];
    [sprite setPosition:ccp([sprite position].x +20, [sprite position].y)];
    [healthBar setPosition:ccp([sprite position].x, [sprite position].y + [sprite contentSize].height/2 + 2)];
    [[self sprite] runAction:[CCRepeatForever actionWithAction:attackAction]];
}

-(void) die
{
    [super die];
    [self setCurrentState:kDieEnemyState];
    [[self sprite] stopAllActions];
    
    CCFiniteTimeAction * dieAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"w_dies" ]] times:1];
    [[self sprite] runAction:dieAction];
}


@end