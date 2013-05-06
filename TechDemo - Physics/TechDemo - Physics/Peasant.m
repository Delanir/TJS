//
//  Peasant.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Peasant.h"


@implementation Peasant


-(id) initWithSprite:(NSString *)spriteFile
{
    if (self = [super initWithSprite:spriteFile])
    {
        [self setCurrentState:kWalkEnemyState];
        [self setHealth:40];
        [self setSpeed:14];
        [self setStrength:0.25];
        [self setGoldValue:1];
        [self setDamageVulnerability:kDamageBaseVulnerability * 1];
        [self setFireVulnerability:kFireBaseVulnerability * 1];
        [self setIceVulnerability:kIceBaseVulnerability * 1];
        [self setPushbackVulnerability:kPushbackBaseVulnerability * 1];
        
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

- (void) shout{
    
    int s;
    NSString *sound;
    
    int play= [Utils getRandomNumberBetween:1 to:100];
    if (play > shoutPercentage) {
        return;
    }
    s= [Utils getRandomNumberBetween:1 to:5];
    sound = [NSString stringWithFormat:@"shout0%d",s];
    
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:sound]];
}

@end
