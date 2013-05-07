//
//  Yuri.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Yuri.h"
#import "ResourceManager.h"


@implementation Yuri

@synthesize readyToFire, level;
@synthesize strength, critical;
@synthesize criticalBonus, speedBonus, bonusActive, strengthBonus;
@synthesize fireDuration, fireDamage, fireAreaOfEffect, fireNumberOfChainTargets;
@synthesize slowTime, slowPercentage, iceAreaOfEffect, freezePercentage;
@synthesize fireDurationBonus, fireDamageBonus, slowTimeBonus, slowPercentageBonus;


-(id) init
{
    level = [self determineLevel];
    
    [self initBonuses];
    
    strength = kYuriBaseStrength * level;
    critical = kYuriBaseCritical * level;
    fireDamage = kYuriBaseDamageOverTimeDamage * fireDamageBonus;
    fireDuration = kYuriBaseDamageOverTimeDuration * fireDurationBonus;
    slowTime = kYuriBaseSlowDownDuration * slowTimeBonus;
    slowPercentage = kYuriBaseSlowDownPercentage * slowPercentageBonus;
    iceAreaOfEffect = kYuriNoAreaOfEffect;
    fireAreaOfEffect = kYuriNoAreaOfEffect;
    fireNumberOfChainTargets = kYuriNoChainTargets;
    freezePercentage = kYuriNoFreezePercentage;
    
    // Init animations with basic speed
    if(self = [super initWithSprite:[NSString stringWithFormat:@"y_lvl%d_06.png",level ]])
    {
        readyToFire = YES;
        
        [self setShootUp:[CCRepeat actionWithAction:
                          [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:[NSString stringWithFormat:@"y_attack_up_lvl%d",level ] ]] times:1]];
        [self setShootFront:[CCRepeat actionWithAction:
                             [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:[NSString stringWithFormat:@"y_attack_front_lvl%d",level ] ]] times:1]];
        [self setShootDown:[CCRepeat actionWithAction:
                            [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:[NSString stringWithFormat:@"y_attack_down_lvl%d",level ] ]] times:1]];
    }
    return self;
}

-(void) initBonuses
{
    strengthBonus = 1.0f;
    speedBonus = 1.0f;
    criticalBonus = kYuriBaseCriticalBonus;
    fireDamageBonus = kYuriDamageOverTimeDamageNoBonus;
    fireDurationBonus = kYuriDamageOverTimeDurationNoBonus;
    slowTimeBonus = kYuriSlowDownDurationNoBonus;
    slowPercentageBonus = kYuriSlowDownPercentageNoBonus;
}


-(BOOL)fireIfAble:(CGPoint)location
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    if(readyToFire)
    {
        readyToFire = NO;
        int direction = (int)(floor(location.y / (winSize.height/3)));
        switch (direction)
        {
            case 0:
                [[self sprite] runAction:[CCSequence actions: [self shootDown],
                                          [CCCallFuncN actionWithTarget:self selector:@selector(getReady)],
                                          nil]];
                break;
            case 1:
                [[self sprite] runAction:[CCSequence actions: [self shootFront],
                                          [CCCallFuncN actionWithTarget:self selector:@selector(getReady)],
                                          nil]];
                break;
            case 2:
                [[self sprite] runAction:[CCSequence actions: [self shootUp],
                                          [CCCallFuncN actionWithTarget:self selector:@selector(getReady)],
                                          nil]];
                break;
        }
        return true;
    }
    else return false;
}


-(void) initBasicStats
{
    strength = kYuriBaseStrength * level * strengthBonus;
    critical = kYuriBaseCritical * level *  criticalBonus;
    [self changeFireRate:[self getCurrentFireRate] * speedBonus];
    fireDamage = kYuriBaseDamageOverTimeDamage * fireDamageBonus;
    fireDuration = kYuriBaseDamageOverTimeDuration * fireDurationBonus;
    slowTime = kYuriBaseSlowDownDuration * slowTimeBonus;
    slowPercentage = kYuriBaseSlowDownPercentage * slowPercentageBonus;
}

-(void) getReady
{
    [self setReadyToFire:YES];
}

-(void) changeFireRate: (float) fireRate
{
    //setup animations
    [[[CCAnimationCache sharedAnimationCache] animationByName:[NSString stringWithFormat:@"y_attack_up_lvl%d",level ] ] setDelayPerUnit:fireRate];
    [[[CCAnimationCache sharedAnimationCache] animationByName:[NSString stringWithFormat:@"y_attack_front_lvl%d",level ] ] setDelayPerUnit:fireRate];
    [[[CCAnimationCache sharedAnimationCache] animationByName:[NSString stringWithFormat:@"y_attack_down_lvl%d",level ] ] setDelayPerUnit:fireRate];
    
    [[self sprite] stopAllActions];
    
    [self setShootUp:[CCRepeat actionWithAction:
                      [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:[NSString stringWithFormat:@"y_attack_up_lvl%d",level ] ]] times:1]];
    [self setShootFront:[CCRepeat actionWithAction:
                         [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:[NSString stringWithFormat:@"y_attack_front_lvl%d",level ] ]] times:1]];
    [self setShootDown:[CCRepeat actionWithAction:
                        [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:[NSString stringWithFormat:@"y_attack_down_lvl%d",level ] ]] times:1]];
    
}

-(float) getCurrentFireRate
{
    return [[[CCAnimationCache sharedAnimationCache] animationByName:[NSString stringWithFormat:@"y_attack_front_lvl%d",level ]] delayPerUnit];
}

-(unsigned int) determineLevel
{
    unsigned int stars = [[ResourceManager shared] skillPoints];
    if (stars < kYuriPointsToLevel2)
        return 1;
    else if(stars < kYuriPointsToLevel3)
        return 2;
    else return 3;
}

-(int)isCritical
{
    return arc4random_uniform(100) < critical * 100 ?2 :1;
}

-(BOOL) freezeWithCold
{
    return arc4random_uniform(100) < freezePercentage * 100;
}


@end
