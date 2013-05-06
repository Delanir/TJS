//
//  Zealot.m
//  L'Archer
//
//  Created by jp on 13/04/13.
//
//

#import "Zealot.h"
#define ZEALOTSHOUT 3

@implementation Zealot

-(id) initWithSprite:(NSString *)spriteFile
{
    if (self = [super initWithSprite:spriteFile])
    {
        [self setCurrentState:kWalkEnemyState];
        [self setHealth:100];
        [self setSpeed:16];
        [self setStrength:1.2];
        [self setGoldValue:4];
        [self setDamageVulnerability:kDamageBaseVulnerability * 1];
        [self setFireVulnerability:kFireBaseVulnerability * 0.75];
        [self setIceVulnerability:kIceBaseVulnerability * 0.75];
        [self setPushbackVulnerability:kPushbackBaseVulnerability * 1.5];
        
        [self postInit];
    }
    return self;
}

-(void) setupActions
{
    walkAnimation = @"z_walk";
    attackAnimation = @"z_attack";
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
    
    shoutPercentage =ZEALOTSHOUT;
}

-(void) attack
{
    [self setCurrentState:kAttackEnemyState];
    [[self sprite] stopAllActions];
    [[self healthBar] stopAllActions];
    [sprite setPosition:ccp([sprite position].x +10, [sprite position].y)];
    [healthBar setPosition:ccp([sprite position].x, [sprite position].y + [sprite contentSize].height/2 + 2)];
    [[self sprite] runAction:[CCRepeatForever actionWithAction:attackAction]];
}

-(void) die
{
    [super die];
    [self setCurrentState:kDieEnemyState];
    [[self sprite] stopAllActions];
    
    CCFiniteTimeAction * dieAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"z_dies" ]] times:1];
    [[self sprite] runAction:dieAction];
}

- (void) shout{
    
    int s;
    NSString *sound;
    
    int play= [Utils getRandomNumberBetween:1 to:100];
    if (play > shoutPercentage) {
        return;
    }
    s= [Utils getRandomNumberBetween:1 to:5];
    sound = @"chant";
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:sound]];
}


@end