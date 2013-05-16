//
//  Wraith.m
//  L'Archer
//
//  Created by jp on 03/05/13.
//
//

#import "Wraith.h"
#import "LevelLayer.h"
#import "Registry.h"

@implementation Wraith

-(id) initWithSprite:(NSString *)spriteFile initialState:(state) initialState
{
    if (self = [super initWithSprite:spriteFile initialState:initialState])
    {
        [self setCurrentState:initialState];
        [self setHealth:140];
        [self setSpeed:10];
        [self setStrength:1.2];
        [self setGoldValue:4];
        [self setDamageVulnerability: kDamageBaseVulnerability * 0.6];
        [self setFireVulnerability: kFireBaseVulnerability * 1.6];
        [self setIceVulnerability: kIceBaseVulnerability * 0.25];
        [self setPushbackVulnerability: kPushbackBaseVulnerability * 0.5];
        
        [self postInit];
    }
    return self;
}

-(void) setupActions
{
    walkAnimation = @"w_walk";
    attackAnimation = @"w_attack";
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
    
    [self schedule:@selector(shout) interval:6.5];
    shoutPercentage = 80;
}

-(void) attack
{
    [super attack];
    if ([self isDead]) return;  // may die in super because of the moat
    [self setCurrentState:kAttackEnemyState];
    [self stopAnimations];
    [[self healthBar] stopAllActions];
    [sprite setPosition:ccp([sprite position].x +20, [sprite position].y)];
    [healthBar setPosition:ccp([sprite position].x, [sprite position].y + [sprite contentSize].height/2 + 2)];
    [[self sprite] runAction:[CCRepeatForever actionWithAction:attackAction]];
}

-(void) die
{
    [self setCurrentState:kDieEnemyState];
    [self stopAnimations];
    [self unscheduleAllSelectors];
    CCFiniteTimeAction * dieAction = [CCSequence actions:
                                      [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"w_dies" ]] times:1],
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
                                        [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"w_taunt" ]] times:2],
                                        [CCCallFuncN actionWithTarget:self selector:@selector(startGame)],
                                        [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"w_taunt" ]] times:2],
                                        [CCCallFuncN actionWithTarget:self selector:@selector(resumeFromTaunt)],
                                        nil];
    [[self sprite] runAction:tauntAction];
}

- (void) startGame
{
    [healthBar setPosition:ccp([sprite position].x, [sprite position].y + [sprite contentSize].height/2 + 2)];
    LevelLayer * levelLayer = [[Registry shared] getEntityByName:@"LevelLayer"];
    [levelLayer setGameStarted:YES];
}

- (void) stopWalking
{
    [self stopAction:walkAction];
}

- (void) resumeFromTaunt
{
    [[self sprite] stopAllActions];
    [self setCurrentState:kWalkEnemyState];
    [self setupActions];
}

- (void) stopAnimations
{
    [[self sprite] stopAllActions];
}

- (void) shout{
    
    int s;
    NSString *sound;
    
    int play= [Utils getRandomNumberBetween:1 to:100];
    if (play > shoutPercentage) {
        return;
    }
    s= [Utils getRandomNumberBetween:1 to:3];
    sound = [NSString stringWithFormat:@"wraith0%d",s];
    
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:sound] pitch:1.0f pan:0.7f gain:1.4f];
}




@end