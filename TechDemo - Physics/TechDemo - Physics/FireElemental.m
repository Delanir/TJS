//
//  FireElemental.m
//  L'Archer
//
//  Created by jp on 03/05/13.
//
//

#import "FireElemental.h"
#import "CollisionManager.h"
#import "ElementalExplosion.h"

@implementation FireElemental

-(id) initWithSprite:(NSString *)spriteFile initialState:(state) initialState
{
    if (self = [super initWithSprite:spriteFile initialState:initialState])
    {
        [self setCurrentState:initialState];
        [self setHealth:1];
        [self setSpeed:6];
        [self setStrength:7.0];
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

    walkAnimation = @"f_walk";
    attackAnimation = @"f_blast1";
    
    // Setup animations
    [self setWalkAction: [CCRepeatForever actionWithAction:
                          [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName: walkAnimation]]]];
    [self setAttackAction: [CCSequence actions:
                           [CCCallFuncN actionWithTarget:self selector:@selector(damageWall)],
                           [CCCallFuncN actionWithTarget:self selector:@selector(die)],
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


- (void) freeze
{
    [super freeze];
    if (currentState != kDieEnemyState)
        sprite.color=ccc3(255, 255, 255);
}



-(void) attack
{
    [super attack];
    if ([self isDead]) return;  // may die in super because of the moat
    [self setCurrentState:kAttackEnemyState];
    [[self sprite] stopAllActions];
    [[self healthBar] stopAllActions];
    [sprite setPosition:ccp([sprite position].x +20, [sprite position].y)];
    [healthBar setPosition:ccp([sprite position].x, [sprite position].y + [sprite contentSize].height/2 + 2)];
    [[self sprite] runAction:[CCRepeat actionWithAction:attackAction times:1]];
}

-(void) die
{
    [self setCurrentState:kDieEnemyState];
    [[self sprite] stopAllActions];
    [[CollisionManager shared] removeFromTargets:self];    
    
    CCSequence * dieAction = [CCSequence actions:
                              [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName: attackAnimation]] times:1],
                              [CCCallFuncN actionWithTarget:self selector:@selector(blastEffect)],
                              [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName: @"f_blast2"]] times:1],
                              [CCCallFuncN actionWithTarget:self selector:@selector(mockDie)], nil];
                              
    [[self sprite] runAction:dieAction];
    
    int fireKilled = [[[GameState shared] fireElementalKilledState] intValue] + 1;
    [[GameState shared] setFireElementalKilledState:[NSNumber numberWithInt: fireKilled]];
}


-(void) mockDie
{
    [super die];
}

-(void) blastEffect
{
    [[[ElementalExplosion alloc] initWithPosition:[sprite position]] autorelease];

}

@end