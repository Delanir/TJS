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

-(id) initWithSprite:(NSString *)spriteFile initialState:(state) initialState
{
    if (self = [super initWithSprite:spriteFile initialState:initialState])
    {
        [self setCurrentState:initialState];
        [self setHealth:100];
        [self setSpeed:16];
        [self setStrength:1.5];
        [self setGoldValue:4];
        [self setDamageVulnerability:kDamageBaseVulnerability * 0.75];
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
    
    if (currentState == kTauntEnemyState)
        [self taunt];
    
    // Setup Movement
    if (currentState == kWalkEnemyState)
    {
        [[self sprite] runAction:walkAction];
        [self animateWalkLeft];
    }
    if (currentState == kAttackEnemyState)
        [sprite runAction:[CCRepeatForever actionWithAction:attackAction]];
    
    shoutPercentage = ZEALOTSHOUT;
    [self schedule:@selector(shout) interval:1.5];
}

-(void) attack
{
    [super attack];
    if ([self isDead]) return;  // may die in super because of the moat
    [self setCurrentState:kAttackEnemyState];
    [[self sprite] stopAllActions];
    [[self healthBar] stopAllActions];
    [sprite setPosition:ccp([sprite position].x +10, [sprite position].y)];
    [healthBar setPosition:ccp([sprite position].x, [sprite position].y + [sprite contentSize].height/2 + 2)];
    [[self sprite] runAction:[CCRepeatForever actionWithAction:attackAction]];
}

-(void) die
{
    [self setCurrentState:kDieEnemyState];
    [[self sprite] stopAllActions];
    [self unscheduleAllSelectors];
    CCFiniteTimeAction * dieAction = [CCSequence actions:
                                      [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"z_dies" ]] times:1],
                                      [CCCallFuncN actionWithTarget:self selector:@selector(mockDie)],
                                      nil];
    [[self sprite] runAction:dieAction];
}



-(void) mockDie
{
    [super die];
}


- (void) taunt
{
    [self setCurrentState:kTauntEnemyState];
    [self stopAnimations];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    [[self sprite] runAction:walkAction];
    CCFiniteTimeAction * tauntAction = [CCSequence actions:
                                        [CCMoveTo actionWithDuration:[self speed]/4 position:ccp(3 * winSize.width/4,[[self sprite] position].y)],
                                        [CCCallFuncN actionWithTarget:self selector:@selector(stopWalking)],
                                        [CCCallFuncN actionWithTarget:self selector:@selector(shout)],
                                        [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"z_taunt" ]] times:1],
                                        [CCCallFuncN actionWithTarget:self selector:@selector(startGame)],
                                        [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"z_taunt" ]] times:4],
                                        [CCCallFuncN actionWithTarget:self selector:@selector(resumeFromTaunt)],
                                        nil];
    [[self sprite] runAction:tauntAction];
}


- (void) shout{
    if(![self isDead])
    {
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
}


@end