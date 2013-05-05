//
//  FireElemental.m
//  L'Archer
//
//  Created by jp on 03/05/13.
//
//

#import "FireElemental.h"
#import "CollisionManager.h"

@implementation FireElemental

@synthesize blastAction, walkAction;

-(id) initWithSprite:(NSString *)spriteFile
{
    if (self = [super initWithSprite:spriteFile])
    {
        [self setCurrentState:kWalkEnemyState];
        [self setHealth:1];
        [self setSpeed:6];
        [self setStrength:3.0];
        [self setGoldValue:6];
        [self setDamageVulnerability:kDamageBaseVulnerability * 0];
        [self setFireVulnerability:kFireBaseVulnerability * 0];
        [self setIceVulnerability:kIceBaseVulnerability * 2];
        [self setPushbackVulnerability:kPushbackBaseVulnerability * 0];
        
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
                          [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"f_walk" ]]]];
    [self setBlastAction: [CCSequence actions:
                           [CCCallFuncN actionWithTarget:self selector:@selector(damageWall)],
                           [CCCallFuncN actionWithTarget:self selector:@selector(die)],
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
    [[self sprite] runAction:[CCRepeat actionWithAction:blastAction times:1]];
}

-(void) die
{
    [super die];
    [self setCurrentState:kDieEnemyState];
    [[self sprite] stopAllActions];
    [[CollisionManager shared] removeFromTargets:self];
    CCFiniteTimeAction * dieAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"f_blast" ]] times:1];
    [[self sprite] runAction:dieAction];
    
}


@end