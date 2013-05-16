//
//  Ent.m
//  L'Archer
//
//  Created by jp on 16/05/13.
//
//

#import "Ent.h"

@implementation Ent

-(id) initWithSprite:(NSString *)spriteFile initialState:(state) initialState
{
    if (self = [super initWithSprite:spriteFile initialState:initialState])
    {
        [self setCurrentState:initialState];
        [self setHealth:400];
        [self setSpeed:40];
        [self setStrength:4];
        [self setGoldValue:8];
        [self setDamageVulnerability:kDamageBaseVulnerability * 0.1];
        [self setFireVulnerability:kFireBaseVulnerability * 2];
        [self setIceVulnerability:kIceBaseVulnerability * 0.1];
        [self setPushbackVulnerability:kPushbackBaseVulnerability * 0.1];
        
        [self postInit];
    }
    return self;
}

-(void) setupActions
{
    walkAnimation = @"e_walk";
    attackAnimation = @"e_attack";
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
    
    [self schedule:@selector(shout) interval:1.5];
}

-(void) attack
{
    [super attack];
    if ([self isDead]) return;  // may die in super because of the moat
    [self setCurrentState:kAttackEnemyState];
    [[self sprite] stopAllActions];
    [[self healthBar] stopAllActions];
    [sprite setPosition:ccp([sprite position].x +25, [sprite position].y)];
    [healthBar setPosition:ccp([sprite position].x, [sprite position].y + [sprite contentSize].height/2 + 2)];
    [[self sprite] runAction:[CCRepeatForever actionWithAction:attackAction]];
}

-(void) die
{
    [self setCurrentState:kDieEnemyState];
    [[self sprite] stopAllActions];
    
    CCFiniteTimeAction * dieAction = [CCSequence actions:
                                      [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"e_dies" ]] times:1],
                                      [CCCallFuncN actionWithTarget:self selector:@selector(mockDie)],
                                      nil];
    [[self sprite] runAction:dieAction];
}



-(void) mockDie
{
    [super die];
}


@end
